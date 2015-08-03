#!/bin/bash
echo "Dropping openmrs db"
./drop-openmrs.sh
echo "Renaming db"
./rename_db.sh openmrs1 openmrs
