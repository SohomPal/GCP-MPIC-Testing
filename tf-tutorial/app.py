import flask
import subprocess
app = flask.Flask(__name__)

@app.route('/')
def validateDomain():
    curl_command = "curl -X GET http://sohom-bgp.pretend-crypto-wallet.com//"
    result = subprocess.run(curl_command, shell=True, text=True, capture_output=True)
    return result.stdout

app.run(host='0.0.0.0')