#!/bin/bash

DIR_ROCKSDB="rocksdb"
REPO_ROCKSDB="https://github.com/jserv/rocksdb.git"
DIR_SNAPPY="snappy"
REPO_SNAPPY="https://github.com/google/snappy.git"
VER_SNAPPY="1.1.4"

# Clone RocksDB
if [[ ! -e $DIR_ROCKSDB ]]; then
    sudo apt-get -y install autotools-dev
    sudo apt-get -y install automake
    git clone $REPO_ROCKSDB 
fi

# Copy Platform script
cp BUILD-rocksdb-armv7.sh $DIR_ROCKSDB/BUILD.sh
cp DEPLOY_MAVEN-rocksdb-armv7.sh $DIR_ROCKSDB/DEPLOY_MAVEN.sh
cp Makefile $DIR_ROCKSDB
cp -rf $DIR_SNAPPY-$VER_SNAPPY $DIR_ROCKSDB

# Clone libsnappy 
cd $DIR_ROCKSDB
git clone https://github.com/yillkid/snappy-1.1.4.git

# Build RocksDB
./BUILD.sh
./DEPLOY_MAVEN.sh
