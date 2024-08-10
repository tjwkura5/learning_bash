#!/bin/bash
# This is a shebang that tells the system to use bash to interpret the script.

# Update the system
sudo apt update -y
# Updates the package list to ensure the latest package versions are available.
sudo apt upgrade -y
# Upgrades all installed packages to their latest versions.

# Install Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
# Downloads and runs the NodeSource setup script to configure the Node.js 20.x repository.
sudo apt install -y nodejs
# Installs Node.js and npm (Node Package Manager) from the NodeSource repository.

# Create a directory for the application
sudo mkdir -p /opt/prometheus-updater
# Creates the directory `/opt/prometheus-updater` where the application will reside.
cd /opt/prometheus-updater
# Changes the working directory to the newly created application directory.

# Create package.json
cat << EOF > package.json
{
  "name": "prometheus-config-updater",
  "version": "1.0.0",
  "description": "A web app to update Prometheus configuration",
  "main": "app.js",
  "dependencies": {
    "express": "^4.17.1",
    "js-yaml": "^4.1.0"
  }
}
EOF
# Creates a `package.json` file which defines the application name, version, description, and dependencies (`express` and `js-yaml`).

# Create app.js
cat << EOF > app.js
const express = require('express');
const yaml = require('js-yaml');
const fs = require('fs');
const path = require('path');

const app = express();
const port = 4000;  // Changed port to 4000

app.use(express.json());

const configPath = '/opt/prometheus/prometheus.yml';

function readPrometheusConfig() {
  const fileContents = fs.readFileSync(configPath, 'utf8');
  return yaml.load(fileContents);
}

function writePrometheusConfig(config) {
  const yamlStr = yaml.dump(config);
  fs.writeFileSync(configPath, yamlStr, 'utf8');
}

app.post('/add-target', (req, res) => {
  const { job, target } = req.body;

  if (!job || !target) {
    return res.status(400).json({ error: 'Both job and target are required' });
  }

  try {
    const config = readPrometheusConfig();

    let jobConfig = config.scrape_configs.find(sc => sc.job_name === job);
    if (!jobConfig) {
      jobConfig = { job_name: job, static_configs: [{ targets: [] }] };
      config.scrape_configs.push(jobConfig);
    }

    if (!jobConfig.static_configs[0].targets.includes(target)) {
      jobConfig.static_configs[0].targets.push(target);
      writePrometheusConfig(config);

      const { execSync } = require('child_process');
      execSync('sudo systemctl reload prometheus');

      res.json({ message: 'Target added successfully' });
    } else {
      res.json({ message: 'Target already exists' });
    }
  } catch (error) {
    console.error('Error updating Prometheus config:', error);
    res.status(500).json({ error: 'Failed to update Prometheus configuration' });
  }
});

app.listen(port, () => {
  console.log(\`Server running at http://localhost:\${port}\`);
});
EOF
# Creates the `app.js` file which contains the Node.js application code. This application:
# - Uses Express.js to create a web server that listens on port 4000.
# - Reads and writes the Prometheus configuration file (`prometheus.yml`).
# - Provides an endpoint (`/add-target`) to add a new target to Prometheus's scrape configurations.
# - Reloads Prometheus after updating the configuration.

# Install dependencies
sudo npm install
# Installs the dependencies (`express` and `js-yaml`) defined in `package.json`.

# Create a systemd service file
cat << EOF | sudo tee /etc/systemd/system/prometheus-updater.service
[Unit]
Description=Prometheus Config Updater
After=network.target

[Service]
ExecStart=/usr/bin/node /opt/prometheus-updater/app.js
Restart=always
User=root
Group=root
Environment=PATH=/usr/bin:/usr/local/bin
Environment=NODE_ENV=production
WorkingDirectory=/opt/prometheus-updater

[Install]
WantedBy=multi-user.target
EOF
# Creates a systemd service file for the Prometheus Config Updater application.
# This defines how the service should start, stop, and run under systemd.

# Reload systemd, enable and start the service
sudo systemctl daemon-reload
# Reloads the systemd manager configuration to recognize the new service.
sudo systemctl enable prometheus-updater
# Enables the Prometheus Config Updater service to start automatically at boot.
sudo systemctl start prometheus-updater
# Starts the Prom
