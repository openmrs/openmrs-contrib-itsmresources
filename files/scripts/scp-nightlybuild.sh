#!/bin/sh
# Variables that are passed from the bamboo deploy plan. e.g. ${bamboo.build.working.directory} trunk
builddir=$1
branchname=$2


# make /dist/nightly
nightlydir=${builddir}/dist/nightly
mkdir -p ${nightlydir}

# make /dist/nightly/2009-03-12/trunk etc.
d=`date +%Y-%m-%d`
nightlydatedir=${nightlydir}/${d}
mkdir ${nightlydatedir}
nightlydatedirwithbranch=${nightlydatedir}/$2
mkdir ${nightlydatedirwithbranch}

# copy .war files
cp ${builddir}/openmrs.war ${nightlydatedirwithbranch}
cp ${builddir}/openmrs-api-*.jar ${nightlydatedirwithbranch}

# Rsync nightly build to sourceforge
rsync -avOP -e "ssh -i $HOME/.ssh/id_rsa" ${nightlydir} openmrs,openmrsdev@frs.sourceforge.net:/home/frs/project/o/op/openmrs/
