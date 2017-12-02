#!/bin/bash

set -e
set -u
set -x


echo "Deprecated. Please use upload-s3-javadoc.sh instead."

exit 1

targethost=bafoussam.openmrs.org
targetuser=bamboo
targetpath=/opt/www/resources.openmrs.org
builddir=$1
version=$2
mkdir -p ${builddir}/deploy
mkdir -p ${builddir}/target/apidocs
mv ${builddir}/target/apidocs ${builddir}/deploy/$2
scp -r -P 22 ${builddir}/deploy/$2 ${targetuser}@${targethost}:${targetpath}
