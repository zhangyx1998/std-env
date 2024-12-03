#!/bin/bash
echo "Iniaitlizing STD-ENV for Debian..."
# Install command line tools
sudo apt update && sudo apt upgrade -y

sudo apt install -y \
    build-essential make cmake llvm clang clangd \
    net-tools git curl wget \
    zip unzip vim htop tree \
    python-is-python3 \
    python3-pip python3-venv \
    ffmpeg vim nano

python3 -m pip install --break-system-packages --user -r $BASE/scripts/requirements.txt
