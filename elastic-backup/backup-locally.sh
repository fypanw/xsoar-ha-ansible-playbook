#/usr/local/bin/zsh

source ./setup-creds.sh
data=$(curl -k -XGET "$IN_ES_URL/_cat/indices?v&pretty=true" 2>/dev/null | grep -v 'index' )
indexes=(`echo $data | awk -F" " '{print $3}' | tr '\n' ' '`)

for ind in $indexes[@];
do
  echo "Backing up $ind from $IN_ES_HOST:$IN_ES_PORT to backups/$ind.json";
  elasticdump --input=$IN_ES_URL/$ind --output=backups/$ind.json --type=data --overwrite 2>stderr.log
done