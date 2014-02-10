#!/bin/sh
builddir=/opt/bamboo-home/xml-data/build-dir/$1
domain=216.70.68.11:8080
domainwithoutport=${domain%%:*}
tomcatuser=openmrs
tomcatpass=rubbed-welcome-describe-tide
webapp=openmrs
branchname=$2

# make /dist/nightly
mkdir -p ${builddir}/dist
nightlydir=${builddir}/dist/nightly
mkdir -p ${nightlydir}

# make /dist/nightly/2009-03-12/trunk etc.
d=`date +%Y-%m-%d`
nightlydatedir=${nightlydir}/${d}
mkdir ${nightlydatedir}
nightlydatedirwithbranch=${nightlydatedir}/$2
mkdir ${nightlydatedirwithbranch}

# copy .war files
cp /opt/bamboo-home/xml-data/build-dir/$1/webapp/target/openmrs.war ${nightlydatedirwithbranch}
cp /opt/bamboo-home/xml-data/build-dir/$1/webapp/target/openmrs/WEB-INF/lib/openmrs-api-*.jar ${nightlydatedirwithbranch}

# Rsync nightly build to sourceforge
rsync -avOP -e 'ssh -i /home/bamboo/bamboo-ssh-deploy/id_rsa' ${nightlydir} openmrs,openmrsdev@frs.sourceforge.net:/home/frs/project/o/op/openmrs/

#echo Undeploying the $webapp webapp on $domain
#curl -silent -u ${tomcatuser}:${tomcatpass} -o ${builddir}/webapp/target/tomcat.output.undeploy http://${domain}/manager/html/undeploy?path=/$webapp
#wait

#echo Dropping and recreating the database
#ssh -i /home/bamboo/.ssh/id_rsa bamboo@sprint1.openmrs.org "mysql -uopenmrs-ci -p8Mt3EhxpxQwYnPhZYRgymiQqNXue0rO -e'drop database openmrs; create database openmrs default character set utf8;'"

#echo Loading database demo data
#ssh -i /home/bamboo/.ssh/id_rsa bamboo@sprint1.openmrs.org "mysql -uopenmrs-ci -p8Mt3EhxpxQwYnPhZYRgymiQqNXue0rO -Dopenmrs < /home/bamboo/Demo-1.8.0.sql"

#echo Uploading $webapp.war to tomcat on $domain
#curl -silent -u ${tomcatuser}:${tomcatpass} -o ${builddir}/webapp/target/tomcat.output.upload -F deployWar=@${nightlydatedir}/$webapp.war --retry 10 http://${domain}/manager/html/upload
#wait
