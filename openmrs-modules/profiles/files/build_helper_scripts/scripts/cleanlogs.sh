#!/bin/sh
find /opt/www/logs/* -mtime +2 -exec rm {} \;
find /opt/tomcat/logs/* -mtime +2 -exec rm {} \;
find /opt/jira/logs/* -mtime +2 -exec rm {} \;
find /opt/jirahome/export/* -mtime +2 -exec rm {} \;
find /opt/crowd/apache-tomcat/logs/* -mtime +2 -exec rm {} \;
find /opt/crowdhome/logs/* -mtime +2 -exec rm {} \;
find /opt/confluence/logs/* -mtime +2 -exec rm {} \;
find /opt/sonatype-work/nexus/logs/* -mtime +2 -exec rm {} \;
rm -rf /opt/tomcat/temp/*
> /opt/jira/logs/catalina.out
> /opt/confluence/logs/catalina.out
> /opt/tomcat/logs/catalina.out
> /opt/bamboo/logs/bamboo.log
> /var/log/apache2/other_vhosts_access.log
> /opt/atlassian-bamboo-3.1.4/logs/bamboo.log
> /opt/atlassian-crowd-2.3.3/apache-tomcat/logs/catalina.out
