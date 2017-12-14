#!/bin/bash

DIR_IRI="iri"
REPO_IRI="https://github.com/jserv/iri.git"
ROCKSDB_VER="5.8.8"

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
if [ ! -f $HOME/.m2/repository/org/rocksdb/rocksdbjni/$ROCKSDB_VER/rocksdbjni-$ROCKSDB_VER.jar ]; then
    echo "rocksdbjni-$ROCKSDB_VER is not available!"
    exit 1
fi
if ! grep "$ROCKSDB_VER" pom.xml; then
    echo "Depends on rocksdbjni-$ROCKSDB_VER"
    echo "Please modify iri/pom.xml in advance."
    exit 1
fi

echo "Building IRI. Please wait."

set -x
mvn -q clean compile
mvn -q package
cp -f target/iri-$1.jar ../
