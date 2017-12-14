# IOTA-deploy

## Introduction

A set of scripts which build and deploy IOTA reference implementation (IRI)
along with latest RocksDB automatically.

## Files

* BUILD-iri.sh
  * Build latest verified IRI and customized RocksDB.
  * Usage: `BUILD-iri.sh [preferable_IRI_version]`

* DEPLOY-iri.sh
  * Deploy IRI binary file(s) to IOTA nodes.
  * Usage: `DEPLOY-iri.sh [preferable_IRI_version]`

* MONITOR-iri.sh
  * Monitor IRI status and summarize system resources.
  * Uage: `MONITOR-iri.sh`
