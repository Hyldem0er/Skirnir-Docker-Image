#!/bin/bash 

#VERSION="2.26.1"
VERSION=$(curl -s https://github.com/docker/compose/tags | grep -oE '/docker/compose/releases/tag/v[0-9]+\.[0-9]+\.[0-9]+' | cut -d'v' -f2 | head -n 1)

# Function to display errors
display_error() {
    echo "an error has occurred : $1"
    exit 1
}
# Check if Curl was installed 
check_curl_installed() {
    if ! curl -V &> /dev/null; then
        display_error "Error : curl is not installed."
    fi
}
check_curl_installed

# Check if Docker was installed
check_docker_installed() {
    echo "Docker..."
    if ! docker -v &>/dev/null; then
        # Installation docker
        echo "Docker Installation..."
        if ! curl -fsSL https://get.docker.com -o get-docker.sh; then
            display_error "Failed to download Docker."
        fi
        if ! sh get-docker.sh; then
            echo -e "Failed to install Docker with the script \nTrying to install with your package manager if is debian/ubuntu or Arch.... "
            if [ -f "get-docker.sh" ]; then 
                rm "get-docker.sh"
            fi
            # If the OS is Arch linux
            echo "Specifique installation if the OS are Arch linux..."
            if ! pacman -Sy --noconfirm docker; then
                display_error "Failed to install Docker for Arch Linux."
            fi
            # Start Docker service
            if ! systemctl start docker; then
                display_error "Failed to start Docker."
            echo "Docker has been installed successfully for Arch linux."
            fi
        else
            echo "Docker has been installed successfully."
        fi
    else
        echo "Docker is already installed"
            if ! systemctl start docker; then
            display_error "But Failed to start Docker."
            fi
            echo "Docker has been started"  
    fi
}
check_docker_installed


# docker-compose installation
check_docker_compose_installed() {
    echo "Docker Compose installation..."
    ARCH=$(uname -m)
    if ! docker-compose -v &>/dev/null; then
        # if docker-compose is not installed
        if ! curl -fsSL -o /usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/v${VERSION}/docker-compose-linux-${ARCH}" ; then
            display_error "Failed to download Docker Compose."
        fi
        if ! chmod +x /usr/local/bin/docker-compose; then
            display_error "Failed to set permissions for Docker Compose."
        fi
        echo "Docker Compose has been successfully installed."
    else
        echo "Docker Compose is already installed."
        # check if the version is up to date
        VERSION_ACTUAL=$(docker-compose -v | cut -d'v' -f3)
        if [[ "${VERSION_ACTUAL}" < "${VERSION}" ]]; then
            echo "Docker Compose is not up to date."
            echo "Update Docker Compose..."
            if ! curl -fsSL -o /usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/v${VERSION}/docker-compose-linux-${ARCH}" ; then
                display_error "Failed to Update Docker Compose."
            fi
            if ! chmod +x /usr/local/bin/docker-compose; then
                display_error "Failed to set permissions for Docker Compose."
            fi
            echo "Docker Compose has been successfully updated to ${VERSION}."
        else
            echo "Docker Compose is on the latest version."
        fi
    fi
}
check_docker_compose_installed
