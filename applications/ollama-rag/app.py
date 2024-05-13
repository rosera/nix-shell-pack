from langchain_community.document_loaders import WebBaseLoader
from langchain_community.vectorstores import Chroma
from langchain_community import embeddings
from langchain_community.chat_models import ChatOllama
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate
from langchain.text_splitter import CharacterTextSplitter

# Select the model
model_local = ChatOllama(model="mistral")

# Add Data
urls = [
        "https://cloud.google.com/storage/docs",
        "https://cloud.google.com/storage/docs/discover-object-storage-gcloud",
        "https://cloud.google.com/storage/docs/creating-buckets",
        "https://cloud.google.com/storage/docs/storage-classes",
        "https://cloud.google.com/storage/docs/locations",
        "https://cloud.google.com/storage/docs/uploading-objects",
]

# Composition urls to docs
docs = [WebBaseLoader(url).load() for url in urls]
docs_list = [item for sublist in docs for item in sublist]
text_splitter = CharacterTextSplitter.from_tiktoken_encoder(
        chunk_size=7500,
        chunk_overlap=100)
# Split the document based on properties
doc_splits = text_splitter.split_documents(docs_list)

# Convert docs to embeddings and add to ChromaDB
vectorstore = Chroma.from_documents(
        documents=doc_splits,
        collection_name="rag-chroma",
        embedding=embeddings.OllamaEmbeddings(model='nomic-embed-text'),
)
retriever = vectorstore.as_retriever()

# No RAG
print("Without RAG\n")
before_rag_template = "What is {topic}"
before_rag_prompt = ChatPromptTemplate.from_template(before_rag_template)
before_rag_chain = before_rag_prompt | model_local | StrOutputParser()
print(before_rag_chain.invoke({"topic": "cloud storage"}))

print("With RAG\n")
after_rag_template = """Answer the question based only on the following context:
{context
Question: {question}
"""
after_rag_prompt = ChatPromptTemplate.from_template(after_rag_template)
after_rag_chain = (
        {"context": retriever, "question": RunnablePasstghrough()}
        | after_rag_prompt
        | model_local
        | StrOutputParser()
)
print(after_rag_chain.invoke("What is Google Cloud Storage"))
