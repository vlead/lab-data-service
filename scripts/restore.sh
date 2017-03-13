#!/bin/bash

DB_NAME="lds"
DB_PASS="xxx"
VERSION="v1.0.0"

BACKUP_FILE=$1

usage() {
  echo "Usage:"
  echo "$0 <path/to/the/backup/file.tar>"
}

if [ -z $BACKUP_FILE ]; then
  echo "Error: No arguments were passed!!"
  echo "Error: The path to the backup file must be passed."
  usage
  exit 1;
fi

# untar the $BACKUP_FILE file
tar -xvf $BACKUP_FILE
if [ $? -ne 0 ]; then
  echo "Error: Something went wrong while untaring."
  echo "Aborting restore."
  exit 1;
fi

mysql -u root -p$DB_PASS -e "create database $DB_NAME"
if [ $? -ne 0 ]; then
  echo "Error: in creating database name $DB_NAME"
  echo "Aborting"
  exit 1;
fi

mysql -u root -p$DB_PASS $DB_NAME < $DB_NAME.sql
if [ $? -ne 0 ]; then
  echo "Error: Something went wrong while restoring db dump."
  echo "Aborting restore."
  exit 1;
fi
echo "################"
echo "Restore successful."
echo "###############"

exit 0;
