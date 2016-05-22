#!/bin/sh

builddir=~/bamboo-agent/xml-data/build-dir
builddir=${builddir}/$1
domain=$2
domainwithoutport=${domain%%:*}
tomcatuser=openmrs
#tomcatpass=16C8Eh4lWJksEhy4i6zYVLIUmGxdgnA
tomcatpass=rocks
webapp=$3

echo Undeploying the $webapp webapp on $domain
curl -u ${tomcatuser}:${tomcatpass} -o ${builddir}/webapp/target/tomcat.output.undeploy http://${domain}/manager/html/undeploy?path=/$webapp
wait

echo Uploading $webapp.war to tomcat on $domain
mv ${builddir}/webapp/target/openmrs.war ${builddir}/webapp/target/$webapp.war
curl -u ${tomcatuser}:${tomcatpass} -o ${builddir}/webapp/target/tomcat.output.upload -F deployWar=@${builddir}/webapp/target/$webapp.war --retry 10 http://${domain}/manager/html/upload
wait

#echo Restarting Tomcat
#sudo pkill -9 -f /opt/tomcat
#sudo /etc/init.d/demo start
