import ollama
import os

def summarize_from_file(filename="extract.txt"):
    # 1. Check if the file actually exists to avoid crashing
    if not os.path.exists(filename):
        return f"Error: The file '{filename}' was not found in this folder."

    try:
        # 2. Read the content of the file
        with open(filename, 'r', encoding='utf-8') as file:
            content = file.read()

        print(f"--- Loaded {len(content)} characters from {filename} ---")

        # 3. Define the AI prompt
        prompt = f"""
        Below is a transcript or text extract. 
        Please provide a concise summary including:
        - The main topic
        - Key takeaways in bullet points
        
        TEXT CONTENT:
        {content}
        """

        # 4. Send to Local LLM (Ollama)
        print("Generating summary... (this may take a moment)")
        response = ollama.chat(
            model='llama3.1', # Ensure you have run 'ollama pull llama3.1'
            messages=[{'role': 'user', 'content': prompt}]
        )

        return response['message']['content']

    except Exception as e:
        return f"An error occurred: {str(e)}"

# Execute the function
if __name__ == "__main__":
    result = summarize_from_file("extract.txt")
    print("\n--- SUMMARY ---\n")
    print(result)
