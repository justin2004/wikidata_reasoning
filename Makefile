default: output.csv

ontology.ttl: ontology-query.sparql ontology-query.sparql
	rsparql --results=graph --service=https://query.wikidata.org/sparql --query=ontology-query.sparql > ontology.ttl

# initial selection from remote triplestore
over.ttl: ontology.ttl over-query.sparql
	rsparql --results=graph --service=https://query.wikidata.org/sparql --query=over-query.sparql > over.ttl 
   
over_and_derivations.ttl: over.ttl ontology.ttl
	infer --rdfs=ontology.ttl over.ttl > over_and_derivations.ttl 
 
output.csv: over_and_derivations.ttl query.sparql
	sparql --results=csv --data=over_and_derivations.ttl --query=query.sparql  > output.csv
