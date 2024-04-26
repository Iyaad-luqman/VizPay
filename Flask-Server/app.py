from flask import Flask, jsonify, request
# import firebase_admin
# from firebase_admin import credentials, firestore
# from datetime import datetime
import google.generativeai as genai
# from termcolor import colored

app = Flask(__name__)

@app.route('/nlp_process/<user_question>', methods=['GET'])

def nlp_process(user_question):

    genai.configure(api_key="AIzaSyCijAAoN875pE3QOuTP1VVxVbMtXPxKLnE")

    # Set up the model
    generation_config = {
    "temperature": 0.9,
    "top_p": 1,
    "top_k": 1,
    "max_output_tokens": 2048,
    }

    safety_settings = [
    {
        "category": "HARM_CATEGORY_HARASSMENT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
        "category": "HARM_CATEGORY_HATE_SPEECH",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
        "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    {
        "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    },
    ]

    model = genai.GenerativeModel(model_name="gemini-pro",
                                generation_config=generation_config,
                                safety_settings=safety_settings)
  
    prompt_parts = [
    "{\n \"prompt\": \"this is the prompt for viz pay which is a voice based transaction app, where the transactions are made from the text obtained from the voice commands of the user. i will provide set of conditions and the respective actions to be carried out for the same.If in the prompt text reciever_name and amount is mentioned, the action=\"to_pay\". The next condition is that if \"reciever_name\" is not mentioned and only amount is mentioned in numbers the action= \"open_scanner\". Condition 3 is that if the mentioned \"reciever_name\" is not available in contacts the action to be carried out is \"open_keypad\". The prompt is \" "  + user_question + " \"  The output will be in the form of json like \n reciever_name: \"John Doe\", reciever_number: \"8714346406\",amount: 1000,     action: \"pay_money_contact\"}. The output should only be Json, and not including any other text or anything.\n"]

    response = model.generate_content(prompt_parts)
    response = response.text
    print(response)
    return response


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')