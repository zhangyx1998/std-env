#!/bin/sh
OS=$(uname -s)

REMOTE="https://github.com/zhangyx1998/std-env.git"
LOCAL="/opt/std-env"

echo "Setting up STD-ENV for ${OS}..."

# Test read and write access to HOME
if [ ! -d ${HOME} ] || [ ! -r ${HOME} ] || [ ! -w ${HOME} ]; then
  echo "Error: ${HOME} is not accessible."
  exit 1
fi

# Set up the environment
if [ ! -d "${LOCAL}" ]; then
  echo "Cloning from ${REMOTE} into ${LOCAL}..." \
  && sudo git clone ${REMOTE} ${LOCAL} \
  && cd "${LOCAL}" \
  && make install
  sudo git config --global --add safe.directory ${LOCAL}
else
  echo "Updating from ${REMOTE}..." \
  && cd ${LOCAL} \
  && sudo git pull origin master \
  && make install
fi

# Run the setup script
case $OS in
Linux)
    # Linux
    if command -v apt > /dev/null; then
        scripts/Debian.sh
    else
        echo "Error: unsupported release $(lsb_release -a)" >&2
    fi
    ;;
Darwin)
# MacOS/Darwin
    scripts/MacOS.sh
    ;;
*)
    echo "Error: std-env does not support $(uname -s)" >&2
    return 1
    ;;
esac
