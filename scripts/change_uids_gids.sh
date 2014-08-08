#!/bin/bash
# Script for changing original uid and gid to a standard set that we can use for configuration managmenet.
# Change ryan uid and gid
/usr/sbin/usermod -u 9001 ryan
/usr/sbin/groupmod -g 9001 ryan

# Change mjdowney uid and gid
/usr/sbin/usermod -u 9002 mjdowney
/usr/sbin/groupmod -g 9002 mjdowney

# Change herooftime uid and gid
/usr/sbin/usermod -u 9003 herooftime
/usr/sbin/groupmod -g 9003 herooftime

# Change gid of admin group
/usr/sbin/groupmod -g 8001 admin
