#!/bin/bash

# Safety measures
set -o errexit   # Leave immediately if a command returns an error
set -o nounset   # Leave immediately if an unitialized value is used
set -euo pipefail  # Leave immediately if a command fails in a pipe

WHERE_AM_I=$(pwd)/src

if cat ~/.zshrc | grep -q GOPATH ; then
    sed "s~^export GOPATH.*~export GOPATH=$WHERE_AM_I~" ~/.zshrc >> temp-zshrc.txt
    cp temp-zshrc.txt ~/.zshrc
    rm temp-zshrc.txt
    echo succes
else
    tee -a ~/.zshrc << EOF 
    export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$(pwd)/src
export PATH=\$PATH:\$GOPATH/bin 
EOF
    echo "else case"
fi
