#!/bin/bash
echo "Iniaitlizing STD-ENV for MacOS..."

BASE=$(dirname $(dirname $(realpath $0)))

get_homebrew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Install Homebrew
if [ ! -x $(which brew) ]; then
    get_homebrew
else
    brew update
fi

# Install command line tools
brew install \
    git curl wget \
    zip unzip vim htop tree \
    python ffmpeg

# Python packages
python3 -m pip install --upgrade pip
python3 -m pip install --user -r $BASE/scripts/requirements.txt
