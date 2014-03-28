targethost=bafoussam.openmrs.org
targetuser=bamboo
targetpath=/opt/www/resources.openmrs.org
builddir=$1/$2
version=$3
mkdir -p ${builddir}
mkdir -p ${builddir}/target/apidocs
mkdir -p ${builddir}/target/$3
mv ${builddir}/target/apidocs ${builddir}/target/$3
scp -r -P 22 ${builddir}/target/$3 ${targetuser}@${targethost}:${targetpath}/
