#!/bin/bash
#
# README: This script creates compressed archives of Demisto data 
# based on the official documentation for freeing up disk space
# by archiving data. The ARCHIVE_FOLDER are configurable.
# Make sure to use this after stopping Demisto Services
# -------------------------------------------------------------------

#### SETTINGS ####
BASE_LOCATION="/var/lib/demisto"
BACKUP_LOCATION="/tmp/demisto-archive"

# Core activity
mkdir -p $BACKUP_LOCATION

# Archive data
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Making backup of $BASE_LOCATION to $BACKUP_LOCATION"
tar -czf --exclude='tmp' --exclude='temp' $BACKUP_LOCATION/var-lib-demisto-backup.$(date +"%Y%m%d%H%M%S").tar.gz $BASE_LOCATION

backup_folder_size=$(du -hs $BACKUP_LOCATION/)
echo "[$(date "+%Y-%m-%d %H:%M:%S")] Size of backups in $BACKUP_LOCATION is $backup_folder_size"
