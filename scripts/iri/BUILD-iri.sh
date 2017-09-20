#!/bin/bash

DIR_IRI="iri"
REPO_IRI="https://github.com/jserv/iri.git"

# Specific IRI version to deploy
if [ "$1" == "" ]; then
    echo "Usage: ./BUILD-iri.sh [the iri version you want to build]"
    exit 1
fi

# Clone IRI
if [[ ! -e $DIR_IRI ]]; then
    git clone $REPO_IRI 
    sudo apt-get -y install maven
fi

# Build IRI
cd $DIR_IRI

## Sanity checks
echo "Sanity checking ... ..."
if [ ! -f $HOME/.m2/repository/org/rocksdb/rocksdbjni/5.8.0/rocksdbjni-5.8.0.jar ]; then
    echo "rocksdbjni-5.8.0 is not available!"
    exit 1
fi
if ! grep "5.8.0" pom.xml; then
    echo "Depends on rocksdbjni-5.8.0"
    echo "Please modify iri/pom.xml in advance."
    exit 1
fi

echo "Building IRI. Please wait."

set -x
mvn -q clean compile
mvn -q package
cp -f target/iri-$1.jar ../
