## Introduction:
Build IOTA iri 1.1.4.x with rocksdb 5.1.5 and deploy automatically

* BUILD-iri.sh: (Build the llatest version iri (dev branch) with rocksdb 5.1.5
  * Clone IOTA iri repository https://github.com/iotaledger/iri.git and change to the dev branch
  * Make sure the rockdb path in $HOME/.m2/repository/org/rocksdb/rocksdbjni/5.1.5/rocksdbjni-5.1.5.jar
  * Execute ./BUILD-iri.sh

* DEPLOY-iri.sh: (Deploy the iri jar file to each puyuma server)
  * ./DEPLOY-iri.sh [the iri version you want to deploy]
