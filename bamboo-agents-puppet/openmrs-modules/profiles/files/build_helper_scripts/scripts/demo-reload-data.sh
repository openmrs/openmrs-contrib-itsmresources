#!/bin/sh

#echo Stopping demo site
#curl -s -u openmrs:16C8Eh4lWJksEhy4i6zYVLIUmGxdgnA -o /dev/null http://149.165.228.72/manager/html/stop?path=/openmrs
#wait

echo Connecting to demo server for data reload
ssh -i ~/.ssh/id_rsa bamboo@bafoussam.openmrs.org /opt/scripts/dbreset/demo_db_reload.sh
wait

#echo Starting demo site
#curl -s -u openmrs:16C8Eh4lWJksEhy4i6zYVLIUmGxdgnA -o /dev/null http://149.165.228.72/manager/html/start?path=/openmrs
#wait
