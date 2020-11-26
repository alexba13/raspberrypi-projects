# raspberrypi-projects

## Nextcloud
tbd

### Docker-compose
tbd

### Backup & restore with restic
For creating a backup use the nc_backup.sh file. Adjust the variables and add your S3 bucket name.
Please execute the following steps to restore restic & nextcloud:

1. Create new containers or use existing ones
2. Execute the setup (Admin account creation & database setup) 
3. Set maintenance mode:
**docker exec -u www-data nextcloud-app php occ maintenance:mode --on &>> $LOGFILE**
4. Execute restic restore:
**AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION restic -r s3:s3.amazonaws.com/xxxx --verbose --password-file=$PASSWORD_FILE restore latest --target ${restoreDir})**
5. Create backup directory:
**/mnt/nextcloud/db/**
6. Copy .sql file to new backup directory:
**/mnt/nextcloud/db/**
7. DROP Database:
**docker exec nextcloud-db sh -c "/usr/bin/mysql -u nextcloud -p$dbPassword -e 'DROP DATABASE nextcloud'" &>> $LOGFILE**
8. Create Database:
**docker exec nextcloud-db sh -c "/usr/bin/mysql -u nextcloud -p$dbPassword -e 'CREATE DATABASE nextcloud'" &>> $LOGFILE**
9. Resore SQL backup:
**docker exec nextcloud-db sh -c "/usr/bin/mysql -u nextcloud -p$dbPassword < /config/backup/filename.bak" &>> $LOGFILE**
10. Copy data and apps folder from Restore folder to Nextcloud folder:
**cp -r data/ /mnt/nextcloud**
**cp -r apps/ /mnt/nextcloud**
11. chown /data and apps/ to www-data:www-data:
**chown -R www-data:www-data data/ apps/**
12. Execute maintenance:fingerprint:
**docker exec -u www-data nextcloud-app php occ maintenance:data-fingerprint --off &>> $LOGFILE**
13. End maintenance mode:
**docker exec -u www-data nextcloud-app php occ maintenance:mode --off &>> $LOGFILE**

## Openhab
tbd

## PiHole
tbd
