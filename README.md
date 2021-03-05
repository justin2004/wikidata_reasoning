# Reasoning over Wikidata


## what


## why

Wikidata doesn't do inference.


## how

### prepare

clone this repo

build this docker image

docker build --build-arg=uid=`id -u` --build-arg=gid=`id -g` -t justin2004/wikidata_reasoning .

docker run --rm -it -v `pwd`:/mnt justin2004/wikidata_reasoning


### usage

then you should find output.csv

edit the sparql queries and save them and see the results propogate to output.csv
