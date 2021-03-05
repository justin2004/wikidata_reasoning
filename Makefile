default: out.csv

ontology.ttl: ontology-query.sparql ontology-query.sparql
	rsparql --results=graph --service=https://query.wikidata.org/sparql --query=ontology-query.sparql > ontology.ttl

# initial selection from remote triplestore
wd.ttl: ontology.ttl query3.sparql
	rsparql --results=graph --service=https://query.wikidata.org/sparql --query=query3.sparql > wd.ttl 
   
derivations.ttl: wd.ttl ontology.ttl
	infer --rdfs=ontology.ttl wd.ttl > derivations.ttl 
 
out.csv: derivations.ttl query2.sparql
	sparql --results=csv --data=derivations.ttl --query=query2.sparql  > out.csv
