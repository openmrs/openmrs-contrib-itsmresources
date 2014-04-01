#!/bin/bash
read -p "Enter IP address in question: " ip_addr
echo
echo "If the IP address was attempted to be used, but was flagged, it will appear on 1 or more following lines:"
grep "botproof - IP address $ip_addr" /opt/id/logs/openmrsid.log
echo
echo "If you do not see a log entry above, the IP address was not flagged."
read -p "Press [Enter] key to type the MySQL root password add IP address $ip_addr to the whitelist, or CTRL-C to quit...."
mysql -u root -p -e "INSERT INTO id_dashboard.IPWhitelists (id, address, createdAt, updatedAt) VALUES (NULL, '$ip_addr', NOW(), NOW());"
echo "Process complete. You may wish to check the IPWhitelists table to verify."
