#!/bin/bash

# this cannot be executed but needs to be kept to rebuild my env

brew install openjdk # can precise versions 8 and 11 if wanted

#this creates it here /usr/local/opt/openjdk/libexec/
sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
# this creates a symlink into my java virtual machines
brew search jdk
