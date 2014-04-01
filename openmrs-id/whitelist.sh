#!/bin/bash
read -p "Enter IP address to add to Dashboard whitelist: " ip_addr
echo
read -p "Press [Enter] key to type the MySQL root password add IP address $ip_addr to the whitelist, or CTRL-C to quit...."
mysql -u root -p -e "INSERT INTO id_dashboard.IPWhitelists (id, address, createdAt, updatedAt) VALUES (NULL, '$ip_addr', NOW(), NOW());"
echo "Process complete. You may wish to check the IPWhitelists table to verify."
