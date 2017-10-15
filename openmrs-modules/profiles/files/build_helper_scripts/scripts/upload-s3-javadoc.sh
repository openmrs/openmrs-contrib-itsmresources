#!/bin/bash

set -e
set -u
set -x

targetpath='openmrs-docs'


builddir=$1
version=$2

virtualenv .env
. .env/bin/activate

pip install awscli

mkdir -p ${builddir}/deploy
mkdir -p ${builddir}/target/apidocs
mv ${builddir}/target/apidocs ${builddir}/deploy/${version}
aws s3 sync ${builddir}/deploy/${version} s3://${targetpath}/${version}
