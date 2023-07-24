#/usr/local/bin/bash
BACKUP_DIR=./backups
ELASTICDUMP_CMD="docker run --rm -v $BACKUP_DIR:/backups -ti elasticdump/elasticsearch-dump:latest"

mkdir -p $BACKUP_DIR
source ./setup-creds.sh
#curl -k -XGET "$IN_ES_URL/_cat/indices?v&pretty=true" 2>/dev/null | grep -v 'index' | awk -F" " '{print $3}' 

indexes=$( curl -k -XGET "$IN_ES_URL/_cat/indices?v&pretty=true" 2>/dev/null | grep -v 'index' | awk -F' ' '{print $3}' | tr '\n' ' ' )
for ind in $indexes;
do
  mkdir -p $BACKUP_DIR/$ind
  for exporttype in index settings mapping policy alias data
  do
    echo "----------------------------------" 
    echo "Backing up $ind ($exporttype) from $IN_ES_HOST:$IN_ES_PORT to $BACKUP_DIR/$ind/$exporttype.json";
    $ELASTICDUMP_CMD --limit 200 --input=$IN_ES_URL/$ind --output=$BACKUP_DIR/$ind/$exporttype.json --type=$exporttype --overwrite 2>stderr.log
  done
done