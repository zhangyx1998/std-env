# Senitnel for the standard environment
export PROFILE_SOURCED=1

# Source the rc file for the current shell
RC_FILE=$HOME/.$(basename ${SHELL})rc
if [ -f $RC_FILE ]; then
    source $RC_FILE
fi
unset RC_FILE

# Set the home directory for the standard environment
export STD_ENV_HOME=$(dirname $(dirname $(realpath $HOME/.profile)))
if [ -d $STD_ENV_HOME ] && [ -e $STD_ENV_HOME/STD_ENV ]; then
    export PATH=$PATH:$STD_ENV_HOME/bin
else
    echo "Error: cannot locate std-env home" >&2
fi

# Prefer clang and clang++ over gcc and g++, when available
export CC=$(command -v clang || command -v gcc || command -v cc)
export CXX=$(command -v clang++ || command -v g++ || command -v c++)

# Local binaries are preferred over system binaries
export PATH=$PATH:$STD_ENV/bin:$HOME/.local/bin

# Add user library path for the current version of Python, if it exists
PY_VER=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
# Check OS type
case $(uname) in
Linux)
    # Linux
    if [ -d "$HOME/.local/lib/python$PY_VER/site-packages" ]; then
        export PYTHONPATH="$PYTHONPATH:$HOME/.local/lib/python$PY_VER/site-packages"
    fi
    ;;
Darwin)
# MacOS/Darwin
    # Make dyld happy
    if [ -z "$DYLD_LIBRARY_PATH" ]; then
        export DYLD_LIBRARY_PATH=/usr/local/lib
    else
        export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/lib
    fi
    if [ -d "$HOME/Library/Python/$PY_VER" ]; then
        export PATH="$PATH:$HOME/Library/Python/$PY_VER/bin"
    fi
    ;;
*)
    echo "Error: std-env does not support $(uname -s)" >&2
    return 1
    ;;
esac

# Include machine-specific configuration
LOCAL_CONFIG=$HOME/.rc.local
if [ -e $LOCAL_CONFIG ]; then
    source $LOCAL_CONFIG
else
    echo "# Start additional local configuration" > $LOCAL_CONFIG
fi
