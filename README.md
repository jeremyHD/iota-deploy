## Introduction:
Build IOTA iri 1.3.x with rocksdb 5.6.x and deploy automatically

* BUILD-iri.sh: (Build the llatest version iri (dev branch) with rocksdb 5.6.x
  * Clone IOTA iri repository https://github.com/iotaledger/iri.git and change to the dev branch
  * Make sure the rockdb path in $HOME/.m2/repository/org/rocksdb/rocksdbjni/5.6.x/rocksdbjni-5.6.x.jar
  * Execute ./BUILD-iri.sh [the iri version you want to build]

* DEPLOY-iri.sh: (Deploy the iri jar file to each puyuma server)
  * ./DEPLOY-iri.sh [the iri version you want to deploy]

* MONITOR-iri.sh: (Monitor iri status and system resource loading)
  * ./MONITOR-iri.sh
