#!/bin/bash

set -e

echo "=== Grafana Installer for macOS ==="

check_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo "✅ Homebrew is already installed."
    fi
}

install_grafana() {
    echo "Installing Grafana via Homebrew..."
    brew update
    brew install grafana
}

configure_grafana_service() {
    echo "Setting up Grafana as a launchd service (user-level)..."
    brew services start grafana
}

post_install_info() {
    echo "✅ Grafana installation complete."
    echo "Grafana is running as a service on http://localhost:3000"
    echo "Default login: admin / admin"
    echo "Please change the password after first login."
}

# Main execution
check_homebrew
install_grafana
configure_grafana_service
post_install_info
