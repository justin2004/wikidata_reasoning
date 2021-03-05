# Reasoning over Wikidata


## what


## why

Wikidata doesn't do inference.


## how

clone this repo

build this docker image

docker build --build-arg=uid=`id -u` --build-arg=gid=`id -g` -t justin2004/wikidata_reasoning .

docker run --rm -it -v `pwd`:/mnt justin2004/wikidata_reasoning
