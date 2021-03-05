# Reasoning over Wikidata


## what

[Semantic reasoning](https://en.wikipedia.org/wiki/Semantic_reasoner) over [Wikidata](https://www.wikidata.org/).


## why

Wikidata doesn't do reasoning/inference.


## how

### prepare

clone this repo.

build this docker image:

```
docker build --build-arg=uid=`id -u` --build-arg=gid=`id -g` -t justin2004/wikidata_reasoning .
```

start the docker container:

```
docker run --rm -it -v `pwd`:/mnt justin2004/wikidata_reasoning
```


### usage


then you should find output.csv.

edit the sparql queries and save them and see the results propogate to output.csv.

e.g.
see this row in output.csv
```
s,p,o
http://www.wikidata.org/entity/Q76,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.wikidata.org/entity/Q5
```
which says that:
president_obama rdf:type human

which is something that Wikidata does not say explictly but which is deriveable.

read `Makefile` to see what is going on.


### notes

although this repo uses Wikidata it could be adapted to other SPARQL endpoints.
