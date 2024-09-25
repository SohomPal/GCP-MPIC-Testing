import subprocess
import requests
import json

# Function to get external IP of a VM using gcloud
def get_external_ip(vm_name, zone):
    try:
        # Run gcloud command to get the external IP of the VM
        result = subprocess.run(
            ["gcloud", "compute", "instances", "describe", vm_name, "--zone", zone, "--format=get(networkInterfaces[0].accessConfigs[0].natIP)"],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
        )
        if result.returncode == 0:
            return result.stdout.strip()  # Return the external IP address
        else:
            raise Exception(f"Error fetching IP for {vm_name}: {result.stderr}")
    except Exception as e:
        return f"Error: {e}"

# Function to fetch response from a given URL with a 30-second timeout
def get_response(url):
    try:
        response = requests.get(url, timeout=30)  # Set timeout to 30 seconds
        return response.text
    except requests.RequestException:
        return None  # Return None (null in JSON) if the request fails or times out

# Aggregate responses from multiple VMs
def aggregate_responses(vm_data):
    aggregated_responses = {}

    for vm_name, vm_zone in vm_data.items():
        vm_ip = get_external_ip(vm_name, vm_zone)
        print(vm_ip)

        if "Error" in vm_ip:
            aggregated_responses[vm_name] = {"error": vm_ip}
        else:
            vm_url = f"http://{vm_ip}:5000"
            vm_response = get_response(vm_url)
            print(vm_response)
            aggregated_responses[vm_name] = {"zone": vm_zone, "response": vm_response}
    
    return aggregated_responses

if __name__ == "__main__":
    # Define VM names and their corresponding zones
    vm_data = {
        "flask-vm-us-east": "us-east1-b",
        "flask-vm-us-central1": "us-central1-a",
        "flask-vm-us-west": "us-west1-a",
        "flask-vm-europe-west": "europe-west1-b",
        "flask-vm-europe-north": "europe-north1-a",
        "flask-vm-asia-east": "asia-east1-a",
        "flask-vm-asia-southeast": "asia-southeast1-a"
    }

    # Get aggregated responses
    aggregated_data = aggregate_responses(vm_data)

    # Print the JSON output
    print(json.dumps(aggregated_data, indent=4))  # Pretty-print the JSON
