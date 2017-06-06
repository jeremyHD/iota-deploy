#!/bin/sh

cd iri
# sanity checks
if [ ! -f $HOME/.m2/repository/org/rocksdb/rocksdbjni/5.1.5/rocksdbjni-5.1.5.jar ]; then
    echo "rocksdbjni-5.1.5 is not available!"
    exit 1
fi
if ! grep "5.1.5" pom.xml; then
    echo "Depends on rocksdbjni-5.1.5"
    echo "Please modify iri/pom.xml in advance."
    exit 1
fi

echo "Building IRI. Please wait."

set -x
mvn -q clean compile
mvn -q package
cp -f target/iri-*.jar ../
