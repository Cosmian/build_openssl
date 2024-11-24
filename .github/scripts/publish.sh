#!/bin/bash
set -ex

env

DESTINATION_DIR=/mnt/package/openssl/${OPENSSL_VERSION}/${SUFFIX_DIR}
ssh -o 'StrictHostKeyChecking no' -i /root/.ssh/id_rsa cosmian@package.cosmian.com mkdir -p "$DESTINATION_DIR"
scp -o 'StrictHostKeyChecking no' -i /root/.ssh/id_rsa "${OPENSSL_VERSION}.tar.gz" cosmian@package.cosmian.com:"$DESTINATION_DIR"/
