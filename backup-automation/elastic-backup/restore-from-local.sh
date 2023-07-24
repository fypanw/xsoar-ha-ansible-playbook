#!/usr/local/bin/bash
BACKUP_DIR=./backups
ELASTICDUMP_CMD="docker run --rm -v $BACKUP_DIR:/backups -ti elasticdump/elasticsearch-dump:latest"

source ./setup-creds.sh                                                                                                                                                                                        ─╯
indexes=$(find $BACKUP_DIR -type d -exec basename {} \; | egrep -v $BACKUP_DIR | tr '\n' ' ')

for ind in $indexes
do
  echo "Working on Index: $ind"
  for exporttype in settings mapping alias data
  do
    echo "----------------------------------"
    echo "Restoring $ind ($exporttype) from $BACKUP_DIR/$ind/$exporttype.json to $OUT_ES_HOST:$OUT_ES_PORT";
    $ELASTICDUMP_CMD --output=$OUT_ES_URL/$ind --input=$BACKUP_DIR/$ind/$exporttype.json --type=$exporttype --overwrite 2>stderr.log
  done
done