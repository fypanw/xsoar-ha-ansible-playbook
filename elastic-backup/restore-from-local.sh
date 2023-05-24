#/usr/local/bin/zsh
source ./setup-creds.sh                                                                                                                                                                                        ─╯
indexes=( $(find ./backups/ -type f -exec basename {} \; | sed -e 's/.json//' ) )

for ind in $indexes[@];
do
  echo "Restoring $ind from backups/$ind.json to $OUT_ES_HOST:$OUT_ES_PORT";
  elasticdump --output=$OUT_ES_URL/$ind --input=backups/$ind.json --type=data --overwrite 2>stderr.log
done