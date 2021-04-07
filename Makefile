ENDPOINT = https://query.wikidata.org/sparql

default: output.csv

# first obtain some Tbox triples from the remote sparql endpoint
#
#    NOTE: Tbox triples don't have to come from a remote endpoint.
#          Wikidata happens to have some triples that are easy to turn 
#          into useful Tbox triples but you could also just make your 
#          own ontology.ttl file by some other means.
#
ontology.ttl: ontology-query.sparql
	@echo '0/3' | figlet
	@echo rebuilding the ontology file...
	rsparql --results=graph \
	   	    --service=$(ENDPOINT) \
	   	    --query=ontology-query.sparql > ontology.ttl
	@echo exit code $$?


# then make an initial selection of triples from remote sparql endpoint.
# put these in the over.ttl file because these are the triples we will
# reason over.
#
over.ttl: ontology.ttl over-query.sparql
	@echo '1/3' | figlet
	@echo getting the initial selection of triples from the remote endpoint...
	rsparql --results=graph \
   	        --service=$(ENDPOINT) \
   	        --query=over-query.sparql > over.ttl 
	@echo exit code $$?
   
# now use:
#    - the rdfs reasoner
#    - over.ttl
#    - ontology.ttl 
# to get all derivations and add those derived triples to the collection
#
over_and_derivations.ttl: over.ttl
	@echo '2/3' | figlet
	@echo making all rdfs derivations...
	infer --rdfs=ontology.ttl over.ttl > over_and_derivations.ttl 
	@echo exit code $$?
 
# finally run the sparql query over all the triples.
# i like csv output so i can look at the results in visidata but
# you could also request json, etc.
#
output.csv: over_and_derivations.ttl query.sparql
	@echo '3/3' | figlet
	@echo running the final sparql query...
	sparql --results=csv \
	   	   --data=over_and_derivations.ttl \
	   	   --query=query.sparql > output.csv
	@echo exit code $$?



# watch for files in this directory to change and when any of them do run
# `make`
#
# this will stay in the foreground (until you ctrl-c it) so you can update 
# query files and hot-load the results
#
live:
	ls -1 . | entr make
