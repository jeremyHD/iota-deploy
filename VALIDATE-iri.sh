#!/bin/sh

if ! which unzip >/dev/null; then
    echo "You should install unzip in advance."
    exit 1
fi

if ! which file >/dev/null; then
    echo "You should install file in advance."
    exit 1
fi

if test x"$1" = "x"; then
    echo "Usage: validate-iri.sh filename.jar"
    exit 1
fi

if ! file $1 | grep "Java archive data" >/dev/null; then
    echo "Error: not valid JAR"
    exit 1
fi

TMP_DIR=`mktemp -d`
unzip -q $1 librocksdbjni-linux64.so -d $TMP_DIR

if ! test -f $TMP_DIR/librocksdbjni-linux64.so; then
    echo "Error: unable to extract JNI"
    exit 1
fi

if ! file $TMP_DIR/librocksdbjni-linux64.so | grep "ARM aarch64" >/dev/null; then
    echo "Error: not valiad ARM64 JNI"
    exit 1
fi

echo
echo "$1 is verified as ARM64-built rocksdbjni."
