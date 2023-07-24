#/usr/local/bin/bash
BACKUP_DIR=./backups
ELASTICDUMP_CMD="docker run --rm -v $BACKUP_DIR:/backups -ti elasticdump/elasticsearch-dump:latest"

mkdir $BACKUP_DIR
source ./setup-creds.sh
#curl -k -XGET "$IN_ES_URL/_cat/indices?v&pretty=true" 2>/dev/null | grep -v 'index' | awk -F" " '{print $3}' 

indexes=$( curl -k -XGET "$IN_ES_URL/_cat/indices?v&pretty=true" 2>/dev/null | grep -v 'index' | awk -F' ' '{print $3}' | tr '\n' ' ' )
for ind in $indexes;
do
  for exporttype in "index settings data mapping policy alias template component_template index_template";
  do 
    echo "Backing up $ind;$exporttype from $IN_ES_HOST:$IN_ES_PORT to backups/$ind.$exporttype.json";
    $ELASTICDUMP_CMD --input=$IN_ES_URL/$ind --output=/backups/$ind.$exporttype.json --type=$exporttype --overwrite 2>stderr.log
  done
done