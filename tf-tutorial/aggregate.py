import subprocess
import requests

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

# Function to fetch response from a given URL
def get_response(url):
    try:
        response = requests.get(url)
        return response.text
    except requests.RequestException as e:
        return f"Error fetching data from {url}: {e}"

# Aggregate responses from multiple VMs
def aggregate_responses(vm_data):
    aggregated_responses = []
    
    for vm_name, vm_zone in vm_data.items():
        vm_ip = get_external_ip(vm_name, vm_zone)
        
        if "Error" in vm_ip:
            aggregated_responses.append(f"Failed to retrieve IP for {vm_name}: {vm_ip}")
        else:
            vm_url = f"http://{vm_ip}:5000"
            vm_response = get_response(vm_url)
            aggregated_responses.append(f"VM {vm_name} ({vm_zone}) Response: {vm_response}")
    
    return "\n\n".join(aggregated_responses)

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
    
    # Print aggregated responses
    print(aggregate_responses(vm_data))
