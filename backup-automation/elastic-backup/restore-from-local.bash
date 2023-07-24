#!/usr/local/bin/bash
BACKUP_DIR=./backups
ELASTICDUMP_CMD="docker run --rm -v $BACKUP_DIR:/backups -ti elasticdump/elasticsearch-dump:latest"

source ./setup-creds.sh                                                                                                                                                                                        ─╯
indexes=$(find ./backups/ -type f -exec basename {} \; | sed -e 's/.json//' | tr '\n' ' ')

for ind in $indexes;
do
  echo "Restoring $ind from backups/$ind.json to $OUT_ES_HOST:$OUT_ES_PORT";
  $ELASTICDUMP_CMD --output=$OUT_ES_URL/$ind --input=backups/$ind.json --type=data --overwrite 2>stderr.log
done