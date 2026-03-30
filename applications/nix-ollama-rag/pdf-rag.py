import ollama
import chromadb
import json
import os
from pypdf import PdfReader
from sentence_transformers import SentenceTransformer
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Load sentence transformer for embedding
embedder = SentenceTransformer("all-MiniLM-L6-v2")

# Initialize ChromaDB client
chroma_client = chromadb.PersistentClient(path="./chroma_db")
collection = chroma_client.get_or_create_collection(name="pdf_rag")

def extract_text_from_pdf(pdf_path):
    """Extract text from a PDF file with error handling."""
    try:
        reader = PdfReader(pdf_path)
        text = "\n".join([page.extract_text() or "" for page in reader.pages])
        return text
    except FileNotFoundError:
        logging.error(f"PDF file not found: {pdf_path}")
        return None
    except Exception as e:
        logging.error(f"Error extracting text from PDF: {e}")
        return None

def add_to_chroma(text, chunk_size=500, overlap=50):
    """Chunk text with overlap and store embeddings in ChromaDB."""
    chunks = []
    for i in range(0, len(text), chunk_size - overlap):
        chunk = text[i:i + chunk_size]
        chunks.append(chunk)

    embeddings = embedder.encode(chunks).tolist()

    for i, chunk in enumerate(chunks):
        collection.add(documents=[chunk], ids=[str(i)], embeddings=[embeddings[i]])

    logging.info("Text added to ChromaDB.")

def query_ollama(question, n_results=3):
    """Query Ollama with retrieved context and improved prompt."""
    results = collection.query(query_embeddings=[embedder.encode([question])[0].tolist()], n_results=n_results)
    context = "\n".join([doc for doc in results["documents"][0]])

    prompt = f"""
    You are a helpful assistant. Use the following context to answer the user's question.

    Context:
    {context}

    Question: {question}

    Provide a concise and informative answer. If the answer is not in the context say "I cannot answer based on the provided context."
    Respond with a structured JSON object with the following keys:
    - "answer": The answer to the question.
    - "sources": A list of relevant sentences or phrases from the context.
    - "confidence": A score between 0 and 1, where 1 is certain and 0 is uncertain.

    Ensure the response is valid JSON.
    """

    try:
        response = ollama.chat(model="gemma2:2B", messages=[{"role": "user", "content": prompt}])
        result = json.loads(response["message"]["content"])
        return result
    except json.JSONDecodeError:
        logging.error(f"Ollama response was not valid JSON: {response['message']['content']}")
        return {"answer": response["message"]["content"], "sources": [context], "confidence": 0.0}
    except Exception as e:
        logging.error(f"Error querying Ollama: {e}")
        return {"answer": "An error occurred while processing the question.", "sources": [], "confidence": 0.0}

if __name__ == "__main__":
    pdf_path = "datasets/CKAD_v132.pdf"  # Updated PDF file path

    if not os.path.exists("./chroma_db"):  # Load PDF only once
        text = extract_text_from_pdf(pdf_path)
        if text:
            add_to_chroma(text)
        else:
            logging.error("Failed to process PDF, exiting.")
            exit(1)

    while True:
        question = input("Enter your question (or type 'exit' to quit): ")
        if question.lower() == 'exit':
            break

        result = query_ollama(question)
        print(json.dumps(result, indent=2))
        print("-" * 40) # Add a separator for readability
