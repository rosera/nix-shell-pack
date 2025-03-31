# from ollama import chat
# from pydantic import BaseModel
import ollama
import pydantic

class Country(pydantic.BaseModel):
  name: str
  capital: str
  languages: list[str]

response = ollama.chat(
  model='gemma:2b',
  # model='llama3.1',
  messages=[
    {
      'role': 'user',
      'content': 'Tell me about Canada.',
    }
  ],
  format=Country.model_json_schema(),
)

country = Country.model_validate_json(response.message.content)
print(country)
