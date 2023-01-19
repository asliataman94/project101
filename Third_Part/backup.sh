#!/bin/bash

# Check if we are root privilage or not
if [[ ${UID} -ne 0 ]]
then
    echo "Please run this script as root or with superuser privileges."
    exit 1
fi

# Which files are we going to back up. Please make sure to exist /home/ec2-user/data file
DIRECTORIES=("/home/ec2-user/data")
# Where do we backup to. Please crete this file before execute this script
BACKUP_DIR="/mnt/backup"
# Create archive filename based on time
DATE=$(date +%F-%H-%M)
HOSTNAME=$(hostname)

# Create the backup directory if doesnt exist.
if [[ ! -z ${BACKUP_DIR}]]
then
    mkdir ${BACKUP_DIR}
fi

FILENAME="${BACKUP_DIR}/${HOSTNAME}-${DATE}.tgz"
echo "We will backup ${BACKUP_DIR}/${HOSTNAME}-${DATE}.tgz"

tar -zvcf ${BACKUP_DIR}/${FILENAME}/${DIRECTORIES}

# Print end status message.
echo "Conguratulation"

# Long listing of files in $dest to check file sizes.
ls -l ${BACKUP_DIR}
-------------

# To set this script for executing in every 5 minutes, we'll create cronjob
crontab -e
# */5 * * * * sudo /home/ec2-user/backup.sh


