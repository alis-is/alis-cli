#!/bin/sh

# install eli
wget https://raw.githubusercontent.com/cryon-io/eli/master/install.sh -O /tmp/install.sh && sh /tmp/install.sh \
&& ELI_DOWNLOADED="TRUE"

if [ ! $ELI_DOWNLOADED = "TRUE" ]; then 
    echo "Failed to download eli, please retry ... "
    exit 1
fi

# install ami
wget https://raw.githubusercontent.com/cryon-io/ami/master/install.sh -O /tmp/install.sh && sh /tmp/install.sh \
&& AMI_DOWNLOADED="TRUE"

if [ ! $AMI_DOWNLOADED = "TRUE" ]; then 
    echo "Failed to download ami, please retry ... "
    exit 1
fi

# install alis-cli
LATEST=$(curl -sL https://api.github.com/repos/cryon-io/alis-cli/releases/latest | grep tag_name | sed 's/  "tag_name": "//g' | sed 's/",//g')

TMP_NAME="/tmp/$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"

wget "https://github.com/cryon-io/alis-cli/releases/download/$LATEST/alis-cli-unix-$(uname -p).zip" -O "$TMP_NAME" &&
    printf "%s\n" "elify();zip.extract_file('$TMP_NAME', 'alis-cli-unix-$(uname -p)', '/usr/sbin/alis-cli', { flattenRootDir = true})" | eli &&
    chmod +x /usr/sbin/alis-cli &&
    echo "alis-cli $LATEST successfuly installed."
