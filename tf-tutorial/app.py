# file added to all perspectives but the central one
import requests
from flask import Flask, request

app = Flask(__name__)

# function to run DCV at the current perspective and return a response when done 
@app.route('/validate', methods=['POST'])
def validate():
    data = request.json
    domain = data.get('domain')
    token = data.get('token')

    # ping the domain through an http get request 
    try: 
        response = requests.get(f"http://{domain}/?token={token}", timeout=30)
        response.raise_for_status() 
        return {"status_code": response.status_code}, 200 
    except requests.RequestException as e:
        return {"error": str(e)}, 400



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
