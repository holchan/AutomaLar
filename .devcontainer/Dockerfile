FROM mcr.microsoft.com/vscode/devcontainers/javascript-node

RUN sudo apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get -y install --no-install-recommends postgresql-client \
        git \
        docker-ce-cli \
        nodejs \
        npm \
    && sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*
