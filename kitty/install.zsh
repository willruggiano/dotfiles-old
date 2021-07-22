#!/bin/zsh

set -eux

# Install script for kitty.
#
# Scipt arguments:
#
FIRST_INSTALL=true
TARGET_PYTHON_VERSION="3.8.5"
INSTALL_PYTHON_VERSION=true
CREATE_VIRTUALENV=true

for opt in "$@"; do
    case "$opt" in
        --python-version)
            shift
            TARGET_PYTHON_VERSION="$1"
            shift
            ;;
        --no-install-python)
            INSTALL_PYTHON_VERSION=false
            shift
            ;;
        --no-create-venv)
            CREATE_VIRTUALENV=false
            shift
            ;;
        --update)
            FIRST_INSTALL=false
            shift
            ;;
    esac
done

# Checkout the kitty source code:
if $FIRST_INSTALL; then
gh repo clone kovidgoyal/kitty ~/src/kitty
fi
pushd ~/src/kitty
if $FIRST_INSTALL = false; then
# git switch -
git fetch -t
fi
# git checkout $(git describe --abbrev=0)

# Install Python, if requested:
if $INSTALL_PYTHON_VERSION; then
    env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install $TARGET_PYTHON_VERSION
fi

# Create a Python virtualenv for kitty dependencies, if requested:
if $CREATE_VIRTUALENV; then
    pyenv virtualenv $TARGET_PYTHON_VERSION kitty
fi
source ~/.pyenv/versions/kitty/bin/activate
pip install -r docs/requirements.txt

# Build and install kitty:
python setup.py --prefix ~/.local linux-package

popd

