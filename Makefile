ENDPOINT = https://query.wikidata.org/sparql

default: output.csv

# first obtain some Tbox triples from the remote sparql endpoint
#
#    NOTE: Tbox triples don't have to come from a remote endpoint.
#          Wikidata happens to have some triples that are easy to turn 
#          into useful Tbox triples but you could also just make your 
#          own ontology.ttl file by some other means.
ontology.ttl: ontology-query.sparql ontology-query.sparql
	rsparql --results=graph \
	   	    --service=$(ENDPOINT) \
	   	    --query=ontology-query.sparql > ontology.ttl

# then make an initial selection of triples from remote sparql endpoint
over.ttl: ontology.ttl over-query.sparql
	rsparql --results=graph \
   	        --service=$(ENDPOINT) \
   	        --query=over-query.sparql > over.ttl 
   
# now use the rdfs reasoner to get all derivations and add those derived triples
# to the collection
over_and_derivations.ttl: over.ttl ontology.ttl
	infer --rdfs=ontology.ttl over.ttl > over_and_derivations.ttl 
 
# finally run the sparql query over the triples that came from the remote sparql 
# enpoints and the triples that were inferred
output.csv: over_and_derivations.ttl query.sparql
	sparql --results=csv \
	   	   --data=over_and_derivations.ttl \
	   	   --query=query.sparql > output.csv
