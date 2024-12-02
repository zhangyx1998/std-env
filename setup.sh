#!/bin/sh
OS=$(uname -s)

REMOTE:="https://github.com/zhangyx1998/std-env.git"
LOCAL:="/usr/local/std-env"

echo "Setting up STD-ENV for ${OS}..."

# Test read and write access to HOME
if [ ! -d ${HOME} || ! -r ${HOME} || ! -w ${HOME} ]; then
  echo "Error: ${HOME} is not accessible."
  exit 1
fi

# Set up the environment
if [ ! -d /usr/local/std-env ]; then
  echo "Cloning from ${REMOTE} into ${LOCAL}..." \
  && sudo git clone ${REMOTE} ${LOCAL} \
  && cd ${LOCAL} || exit 1 \
  && make install
else
  echo "Updating from ${REMOTE}..." \
  && cd ${LOCAL} \
  && git pull origin master
  && make install
fi
