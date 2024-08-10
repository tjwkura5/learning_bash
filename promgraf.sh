#!/bin/bash

# Update the system
sudo apt update -y && sudo apt upgrade -y
# The above command updates the package list and upgrades all installed packages to their latest versions.

# Install wget
sudo apt install wget -y
# Installs the 'wget' utility, which is used to download files from the web.

# Install Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.37.0/prometheus-2.37.0.linux-amd64.tar.gz
# Downloads the specified version of Prometheus.
tar xvfz prometheus-2.37.0.linux-amd64.tar.gz
# Extracts the downloaded Prometheus archive.
sudo mv prometheus-2.37.0.linux-amd64 /opt/prometheus
# Moves the extracted Prometheus files to the /opt/prometheus directory.

# Create a Prometheus user
sudo useradd --no-create-home --shell /bin/false prometheus
# Creates a system user 'prometheus' with no home directory and no login shell, for security purposes.

# Set ownership for Prometheus directories
sudo chown -R prometheus:prometheus /opt/prometheus
# Changes the ownership of the Prometheus directory and its contents to the 'prometheus' user and group.

# Create a Prometheus service file
cat << EOF | sudo tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/opt/prometheus/prometheus \
    --config.file /opt/prometheus/prometheus.yml \
    --storage.tsdb.path /opt/prometheus/data

[Install]
WantedBy=multi-user.target
EOF
# Creates a systemd service file for Prometheus to define how the service should start, stop, and run.

# Start and enable Prometheus service
sudo systemctl daemon-reload
# Reloads the systemd manager configuration to recognize the new Prometheus service.
sudo systemctl start prometheus
# Starts the Prometheus service.
sudo systemctl enable prometheus
# Enables the Prometheus service to start automatically at boot.

# Install Grafana
# Add Grafana GPG key and repository
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
# Downloads and adds the Grafana GPG key to verify package integrity.
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
# Adds the Grafana repository to the system's package sources.

# Update package list and install Grafana
sudo apt update -y
# Updates the package list to include the Grafana repository.
sudo apt install grafana -y
# Installs Grafana.

# Start and enable Grafana service
sudo systemctl start grafana-server
# Starts the Grafana service.
sudo systemctl enable grafana-server
# Enables the Grafana service to start automatically at boot.

# Print the public IP address
echo "Installation complete. Access Prometheus at http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):9090"
# Prints the public IP address and the URL to access Prometheus.
echo "Access Grafana at http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):3000"
# Prints the public IP address and the URL to access Grafana.
echo "Default Grafana login is admin/admin"
# Prints the default Grafana login credentials.
