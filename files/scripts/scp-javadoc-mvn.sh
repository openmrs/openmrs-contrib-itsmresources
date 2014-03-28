targethost=bafoussam.openmrs.org
targetuser=bamboo
targetpath=/opt/www/resources.openmrs.org
builddir=$1
version=$2
mkdir -p ${builddir}
mkdir -p ${builddir}/target/apidocs
mkdir -p ${builddir}/target/$2
mv ${builddir}/target/apidocs ${builddir}/target/$2
scp -r -P 22 ${builddir}/target/$2 ${targetuser}@${targethost}:${targetpath}/
