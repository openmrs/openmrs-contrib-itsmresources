Whitelisting IP Addresses with OpenMRS ID
========

First, finding blocked IP addresses:
--------

IP blocks are logged in the main OpenMRS ID logfile. An offending IP is logged
like this:

    [2014-02-19 00:12:26.230] [INFO] botproof - IP address 1.2.3.4 
    flagged as spam

To get a list of blocked IP addresses, and the times they were blocked, run:

    grep "botproof - IP address" /opt/id/logs/openmrsid.log

Often piping this to `tail` will allow you to focus on an address that was
recently blacklisted.


Whitelisting an IP address:
--------

The IP whitelist is a table names `IPWhitelists` in the ID Dashboard database.

To add to the whitelist execute the following SQL command: 

    INSERT INTO `id_dashboard`.`IPWhitelists`
      (`id`, `address`, `createdAt`, `updatedAt`)
      VALUES (NULL, 'IP_ADDRESS_HERE', NOW(), NOW());

The change will take effect immediately.