import random
import nltk
from transformers import pipeline

chatbot = pipeline("translation_XX_to_YY", model="facebook/blenderbot-400M-distill")

response = chatbot("Hello, how are you?")
print(response)

print("Chatbot: Hello! Type 'exit' to stop.")

while True:
    user_input = input("You: ")
    if user_input.lower() == "exit":
        print("Chatbot: Goodbye!")
        break
    response = chatbot(user_input)
    print("Chatbot:", response[0]['translation_text'])
    
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords

nltk.download("punkt")
nltk.download("stopwords")

def preprocess_text(text):
    tokens = word_tokenize(text.lower())
    return " ".join([word for word in tokens if word.isalnum() and word not in stopwords.words("english")])
  
custom_responses = {
    "hello": "Hey there! How can I assist you today?",
    "how are you": "I'm just a chatbot, but I'm doing great! How about you?",
    "your name": "I'm AI-Bot, your friendly Python-powered assistant!"
}

def get_response(user_input):
    for key in custom_responses:
        if key in user_input.lower():
            return custom_responses[key]
    return chatbot(user_input)[0]['translation_text']

while True:
    user_input = input("You: ")
    if user_input.lower() == "exit":
        print("Chatbot: Goodbye!")
        break
    response = get_response(user_input)
    print("Chatbot:", response)
