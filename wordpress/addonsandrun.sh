#!/bin/bash
echo "starting addons"

apt-get update
apt-get install unzip


for i in $(compgen -v  ADDONS_); do
	echo item: $i
	IFS='_' read -ra tokens <<< "$i"
	
	currentFolder=/var/www/html/wp-content/${tokens[1]}
	
	echo updating: $currentFolder
	echo downloading : "${!i}"

	mkdir -p $currentFolder
	curl -sS "${!i}" > $currentFolder/p1.zip
	unzip $currentFolder/p1.zip -d $currentFolder
	rm $currentFolder/p1.zip

done

apt-get --yes remove unzip

echo "addons completed. Starting site"
docker-entrypoint.sh "$@"
