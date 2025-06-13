# Nextcloud

Nextcloud is used to store images and documents.
It is also running as Docker container defined with an `docker-compose.yml` file which is in this directory.

## Storage

All files will be stored on an external SSD connected with USB to the Raspberry PI.

The SSD needs to be connected before the installation. Once the SSD is plugged into the Raspberry Pi, execute the next steps:

```
# Login as sudo
sudo su -

# Check if SSD is connected. Should be /dev/sda1
lsblk

# Create mount directory
mkdir /mnt/nextcloud

# Mount the SSD to the directory
mount /dev/sda1 /mnt/nextcloud

# Check mount
df -h

# Get UUID and TYPE for fstab
blkid

# Edit /etc/fstab
nano /etc/fstab

# Add something like this at the end of the file
UUID=THE_UUID /mnt/nextcloud/ ext4 defaults,auto 0 3
```

## Installation

To start Nextcloud, you can use the `docker-compose.yml` file in this directory.
This will create two containers:

- One container is running the Nextcloud application
- One container for the MariaDB

## Backup

Restic will be used for creating the backups. Create the `nc_backup.sh` file. Adjust the variables and add your S3 bucket name.

```
# Login as sudo
sudo su -

# Create directory
mkdir ./nextcloud_backup

# Create nc_backup.sh and add the content from the file
nano nc_backup.sh

# Adjust crontab
crontab -e

# Add the following at the bottom of the file

# Running at 03:00 AM every night
0 3 * * * /root/nextcloud_backup/nc_backup.sh

```

## Restore with restic

Please execute the following steps to restore restic & nextcloud:

1. Create new containers or use existing ones
2. Execute the setup (Admin account creation & database setup) 
3. Set maintenance mode:<br />
`docker exec -u www-data nextcloud-app php occ maintenance:mode --on &>> $LOGFILE`
4. Execute restic restore:<br />
`AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION restic -r s3:s3.amazonaws.com/xxxx --verbose --password-file=$PASSWORD_FILE restore latest --target ${restoreDir})`
5. Create backup directory under `/mnt/nextcloud/db/`
6. Copy .sql file to new backup directory:<br />
`cp <bak_file_in_restore_dir> /mnt/nextcloud/db/backup`
7. DROP Database:<br />
`docker exec nextcloud-db sh -c "/usr/bin/mysql -u nextcloud -p$dbPassword -e 'DROP DATABASE nextcloud'" &>> $LOGFILE`
8. Create Database:<br />
`docker exec nextcloud-db sh -c "/usr/bin/mysql -u nextcloud -p$dbPassword -e 'CREATE DATABASE nextcloud'" &>> $LOGFILE`
9. Resore SQL backup:<br />
`docker exec nextcloud-db sh -c "/usr/bin/mysql -u nextcloud -p$dbPassword < /config/backup/<filename>.bak" &>> $LOGFILE`
10. Copy data and apps folder from Restore folder to Nextcloud folder:<br />
`cp -r data/ /mnt/nextcloud`<br />
`cp -r apps/ /mnt/nextcloud`
11. chown /data and apps/ to www-data:www-data:<br />
`chown -R www-data:www-data data/ apps/`
12. Execute maintenance:fingerprint:<br />
`docker exec -u www-data nextcloud-app php occ maintenance:data-fingerprint &>> $LOGFILE`
13. End maintenance mode:<br />
`docker exec -u www-data nextcloud-app php occ maintenance:mode --off &>> $LOGFILE`

## Adding new Apps

1. Download the tar.gz file for the app you want to install
2. Extract it to `/var/www/nextcloud/apps/` directory
3. Change to `/var/www/nextcloud/` directory
4. Execute `docker exec -u www-data nextcloud-app php occ app:enable <app_name>`
