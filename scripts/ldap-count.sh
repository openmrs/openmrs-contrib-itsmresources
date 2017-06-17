#!/bin/bash

ldapsearch -x -W -LLL -D cn=admin,dc=openmrs,dc=org -b ou=users,dc=openmrs,dc=org uid=* uid | grep uid: | wc -l
