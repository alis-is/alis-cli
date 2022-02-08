#!/bin/sh

TMP_NAME="/tmp/$(tr -dc 'a-zA-Z0-9' </dev/urandom | fold -w 32 | head -n 1)"

if which curl >/dev/null; then
    set -- curl -L --progress-bar -o "$TMP_NAME"
    LATEST=$(curl -sL https://api.github.com/repos/alis-is/alis-cli/releases/latest | grep tag_name | sed 's/  "tag_name": "//g' | sed 's/",//g')
else
    set -- wget -q --show-progress -O "$TMP_NAME"
    LATEST=$(wget -qO- https://api.github.com/repos/alis-is/alis-cli/releases/latest | grep tag_name | sed 's/  "tag_name": "//g' | sed 's/",//g')
fi

# install ami
echo "Downloading ami setup script..."
if ! "$@" https://raw.githubusercontent.com/alis-is/ami/master/install.sh; then
    echo "Failed to download ami, please retry ... "
    exit 1
fi
if ! sh "$TMP_NAME"; then
    echo "Failed to install ami, please retry ... "
    exit 1
fi

# install alis-cli
echo "Downloading alis-cli $LATEST..."
if "$@" "https://github.com/alis-is/alis-cli/releases/download/$LATEST/alis-cli-unix-$(uname -p).zip" &&
    printf "%s\n" "zip.extract_file('$TMP_NAME', 'alis-cli-unix-$(uname -p)', '/usr/sbin/alis-cli', { flattenRootDir = true })" | eli &&
    chmod +x /usr/sbin/alis-cli; then
    echo "alis-cli $LATEST successfuly installed."
else
    echo "alis-cli  installation failed!" 1>&2
    exit 1
fi
