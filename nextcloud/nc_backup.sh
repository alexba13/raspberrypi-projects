#!/bin/bash

# Logfile
LOGFILE="/var/log/nextcloud.log"

# Current date
currentDate=$(date +"%Y%m%d_%H%M%S")

# Backup directory main
backupMainDir="/mnt/nextcloud/db/backup/"

# Backup directory
backupdir="/mnt/nextcloud/db/backup/${currentDate}/"

# Backup age
backupage="5"

# Database Backup Filename
backupDatabaseName="nextcloud-sqlbkp_`date +"%Y%m%d-%H:%M"`.bak"

# Database password
dbPassword="<add_password_here>"

# AWS Access Key
AWS_ACCESS_KEY_ID="<add_access_key_here>"

# AWS Secret Key
AWS_SECRET_ACCESS_KEY="<add_secret_key_here>"

# AWS Default Region
AWS_DEFAULT_REGION=eu-central-1

# Restic password
PASSWORD_FILE=/home/pi/resticpw/pw

# Backup Start
date >> $LOGFILE
echo "---------------Starting backup---------------" >> $LOGFILE

# Create backup directory
echo "Creating backup directory..." &>> $LOGFILE
if [ ! -d "${backupdir}" ]
then
        mkdir -p "${backupdir}" && echo "Backup directory created" &>> $LOGFILE
else
        echo "ERROR: The backup directory ${backupdir} already exists!" &>> $LOGFILE
        exit 1
fi

# Maintenance Mode on
docker exec -u www-data nextcloud-app php occ maintenance:mode --on &>> $LOGFILE
date >> $LOGFILE

# Backup database
echo "Backup MariaDB..." >> $LOGFILE
date >> $LOGFILE
docker exec nextcloud-db sh -c "/usr/bin/mysqldump --single-transaction --all-databases -u nextcloud -p$dbPassword > /config/backup/$currentDate/$backupDatabaseName" &>> $LOGFILE
echo "Backup of MariaDB completed..." >> $LOGFILE

# Starting restic backup
echo "---------------Starting restic backup---------------" >> $LOGFILE
echo "Backup /mnt/nextcloud without html directory..." >> $LOGFILE
AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION restic -r s3:s3.amazonaws.com/restic-xxxx --verbose --password-file=$PASSWORD_FILE backup --option s3.storage-class=STANDARD_IA --tag nextcloud /mnt/nextcloud --exclude=/mnt/nextcloud/html
echo "Restic backup completed..." >> $LOGFILE

# Checking integrity of restic backup
echo "Checking integrity of restic backup..." >> $LOGFILE
AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION restic -r s3:s3.amazonaws.com/restic-xxxx --password-file=$PASSWORD_FILE check &>> $LOGFILE
echo "---------------Ending restic backup---------------" >> $LOGFILE

# Remove old backups
echo "---------------Start cleanup of backup and disable maintenance mode---------------" >> $LOGFILE
echo "Backups older than" ${backupage} "will be deleted" >> $LOGFILE
find "${backupMainDir}" -type d -mtime +"${backupage}" | xargs rm -rf &>> $LOGFILE

# Maintenance Mode off
docker exec -u www-data nextcloud-app php occ maintenance:mode --off &>> $LOGFILE
date >> $LOGFILE

# Backup Finished
date >> $LOGFILE
echo "---------------Backup Finished---------------" >> $LOGFILE
