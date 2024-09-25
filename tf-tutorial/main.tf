# Define the network
resource "google_compute_network" "vpc_network" {
  name                    = "my-custom-mode-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

# Subnetworks for each region

# Subnetwork for VM in us-east1
resource "google_compute_subnetwork" "subnet_us_east" {
  name          = "my-custom-subnet-east"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-east1"
  network       = google_compute_network.vpc_network.id
}

# Subnetwork for VM in us-central1 because us-central2 is unavilable
resource "google_compute_subnetwork" "subnet_us_central1" {
  name          = "my-custom-subnet-central1"
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

# Subnetwork for VM in us-west1
resource "google_compute_subnetwork" "subnet_us_west" {
  name          = "my-custom-subnet-west"
  ip_cidr_range = "10.0.3.0/24"
  region        = "us-west1"
  network       = google_compute_network.vpc_network.id
}

# Subnetwork for VM in europe-west1
resource "google_compute_subnetwork" "subnet_europe_west" {
  name          = "my-custom-subnet-europe-west"
  ip_cidr_range = "10.0.4.0/24"
  region        = "europe-west1"
  network       = google_compute_network.vpc_network.id
}

# Subnetwork for VM in europe-north1
resource "google_compute_subnetwork" "subnet_europe_north" {
  name          = "my-custom-subnet-europe-north"
  ip_cidr_range = "10.0.5.0/24"
  region        = "europe-north1"
  network       = google_compute_network.vpc_network.id
}

# Subnetwork for VM in asia-east1
resource "google_compute_subnetwork" "subnet_asia_east" {
  name          = "my-custom-subnet-asia-east"
  ip_cidr_range = "10.0.6.0/24"
  region        = "asia-east1"
  network       = google_compute_network.vpc_network.id
}

# Subnetwork for VM in asia-southeast1
resource "google_compute_subnetwork" "subnet_asia_southeast" {
  name          = "my-custom-subnet-asia-southeast"
  ip_cidr_range = "10.0.7.0/24"
  region        = "asia-southeast1"
  network       = google_compute_network.vpc_network.id
}

# VM Instances for each region

# VM in us-east1
resource "google_compute_instance" "vm_us_east" {
  name         = "flask-vm-us-east"
  machine_type = "e2-micro"
  zone         = "us-east1-b"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y python3-pip; pip3 install flask"

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_us_east.id

    access_config {
      # External IP address
    }
  }
}

# VM in us-central1
resource "google_compute_instance" "vm_us_central1" {
  name         = "flask-vm-us-central1"
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y python3-pip; pip3 install flask"

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_us_central1.id

    access_config {
      # External IP address
    }
  }
}

# VM in us-west1
resource "google_compute_instance" "vm_us_west" {
  name         = "flask-vm-us-west"
  machine_type = "e2-micro"
  zone         = "us-west1-a"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y python3-pip; pip3 install flask"

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_us_west.id

    access_config {
      # External IP address
    }
  }
}

# VM in europe-west1
resource "google_compute_instance" "vm_europe_west" {
  name         = "flask-vm-europe-west"
  machine_type = "e2-micro"
  zone         = "europe-west1-b"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y python3-pip; pip3 install flask"

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_europe_west.id

    access_config {
      # External IP address
    }
  }
}

# VM in europe-north1
resource "google_compute_instance" "vm_europe_north" {
  name         = "flask-vm-europe-north"
  machine_type = "e2-micro"
  zone         = "europe-north1-a"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y python3-pip; pip3 install flask"

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_europe_north.id

    access_config {
      # External IP address
    }
  }
}

# VM in asia-east1
resource "google_compute_instance" "vm_asia_east" {
  name         = "flask-vm-asia-east"
  machine_type = "e2-micro"
  zone         = "asia-east1-a"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y python3-pip; pip3 install flask"

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_asia_east.id

    access_config {
      # External IP address
    }
  }
}

# VM in asia-southeast1
resource "google_compute_instance" "vm_asia_southeast" {
  name         = "flask-vm-asia-southeast"
  machine_type = "e2-micro"
  zone         = "asia-southeast1-a"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = "sudo apt-get update; sudo apt-get install -y python3-pip; pip3 install flask"

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_asia_southeast.id

    access_config {
      # External IP address
    }
  }
}

# Firewall rules (SSH and Flask)

resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "flask" {
  name    = "allow-flask"
  network = google_compute_network.vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["5000"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# Output external IP addresses for all VMs
output "Web-server-VM-URLs" {
  value = [
    join("", ["http://", google_compute_instance.vm_us_east.network_interface.0.access_config.0.nat_ip, ":5000"]),
    join("", ["http://", google_compute_instance.vm_us_central1.network_interface.0.access_config.0.nat_ip, ":5000"]),
    join("", ["http://", google_compute_instance.vm_us_west.network_interface.0.access_config.0.nat_ip, ":5000"]),
    join("", ["http://", google_compute_instance.vm_europe_west.network_interface.0.access_config.0.nat_ip, ":5000"]),
    join("", ["http://", google_compute_instance.vm_europe_north.network_interface.0.access_config.0.nat_ip, ":5000"]),
    join("", ["http://", google_compute_instance.vm_asia_east.network_interface.0.access_config.0.nat_ip, ":5000"]),
    join("", ["http://", google_compute_instance.vm_asia_southeast.network_interface.0.access_config.0.nat_ip, ":5000"])
  ]
}
