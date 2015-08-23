#!/bin/bash

number=0
touch reconcile.csv

while read line ; do

curl -X POST http://spotlight.dbpedia.org/rest/annotate --data-urlencode "text=${line}" > temp.xml
uri=`xpath -e "//@URI" temp.xml | grep -oE "http://(.*)" | tr -d '"'`
if [[ -n $uri ]] ; then
echo "\"${line}\",\"${uri}\"" >> reconcile.csv 
fi
done < organizations.txt
