# this file is added only to the main/central perspective which acts as an endpoint for the user communicate with
# it triggers DCV at all other perspectives and itself

import requests
from flask import Flask, request
from concurrent.futures import ThreadPoolExecutor

app = Flask(__name__)

# List of all VM URLs [need to manually edit]
all_vms = [
  "http://34.75.246.52:5000",
  "http://34.171.228.132:5000",
  "http://34.83.63.223:5000",
  "http://34.140.35.230:5000",
  "http://34.88.225.17:5000",
  "http://35.221.197.15:5000",
  "http://35.185.188.182:5000",
]

# sends a http request to validate the domain at the given VM
def send_request(vm, domain, token):
    response = requests.post(f"{vm}/validate", json={"domain": domain, "token": token}, timeout = 30)
    return vm, response.status_code
    

# function to begin running DCV at all 7 GCP perspectives 
@app.route('/run-all', methods=['POST'])
def runAll():
    data = request.json
    domain = data.get('domain')
    token = data.get('token')

    errors = []

    # send DCV requests to all VMs and wait for their completion
    with ThreadPoolExecutor() as executor:
        futures = {executor.submit(send_request, vm, domain, token): vm for vm in all_vms}
        for future in futures:
            vm, status_code = future.result()  
            if status_code != 200:
                errors.append(f"{vm} failed with status code {status_code}")
    
    if errors:
        return {"errors": errors, "message": "DCV failed at some perspectives"}
    else:
        return {"message": "DCV completed at all 7 GCP perspectives!"}

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
