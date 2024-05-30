#!/bin/bash

# Define variables
PG_USER=""
PG_DB=""
PG_PASS=""
PG_HOST=""
PG_PORT=""
BACKUP_DIR="/home/azureuser"
#AZURE_CONTAINER="livatdbbackup"
#AZURE_STORAGE_ACCOUNT="livatappdbbackup"
S3_BUCKET="abc"

# Create backup directory if it doesn't exist
#mkdir -p $BACKUP_DIR

# Backup PostgreSQL database
pg_dump -U $PG_USER -h $PG_HOST -p $PG_PORT -d $PG_DB  > $BACKUP_DIR/$PG_DB-$(date +%Y-%m-%d_%H-%M-%S).sql


# Upload backup to S3
aws s3 cp $BACKUP_FILE s3://$S3_BUCKET/

# Remove old backups (optional)
find $BACKUP_DIR -type f -mtime +7 -exec rm -f {} \;