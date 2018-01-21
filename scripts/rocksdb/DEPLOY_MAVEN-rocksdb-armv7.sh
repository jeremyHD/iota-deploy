#!/bin/sh

VER=5.8.8

M2_ROCKSDBJNI=$HOME/.m2/repository/org/rocksdb/rocksdbjni/$VER
JARBALL=java/target/rocksdbjni-$VER-linux32.jar

set -x

mkdir -p $M2_ROCKSDBJNI

cp $JARBALL $M2_ROCKSDBJNI/rocksdbjni-$VER.jar
sha1sum $JARBALL | cut -f1 -d ' ' > $M2_ROCKSDBJNI/rocksdbjni-$VER.jar.sha1

cp java/rocksjni.pom $M2_ROCKSDBJNI/rocksjni-$VER.pom
sha1sum java/rocksjni.pom | cut -f1 -d ' ' > $M2_ROCKSDBJNI/rocksdbjni-$VER.pom.sha1
