# Reasoning over Wikidata

## section

I posted [this question](https://www.reddit.com/r/semanticweb/comments/lp0iey/reasoning_over_service/) a few days ago. The idea is that it would be nice to be able to query a remote SPARQL endpoint and specify an ontology to be used with a reasoner over the triples from the remote endpoint. For example I know that in this ontology that I bring I would like this triple:

wdt:P31 rdfs:subPropertyOf rdf:type .

wdt:P31 is Wikidata's way of saying "is an instance of" and that is what rdf:type does too.


I naively thought this just might work if I query a triplestore that has reasoning enabled and I specify a service to get some triples from Wikidata.

 select * where { 
     service <https://query.wikidata.org/sparql> {
         ?s ?p ?o .
         filter(?s=wd:Q23) .
         filter(?o=wd:Q5) .
     }


But I couldn't get the local triplestore to reason over the triples that satisfy my service clause.


A little searching led me to [this](http://ceur-ws.org/Vol-996/papers/ldow2013-paper-08.pdf) academic paper.
![paper](media/paper.png)


It looked promising.

However, in this case the sparql endpoint provider decides which inference rules are used for its entailment regimes. In this paper, we propose an extension to the sparql query language to support remote reasoning, in which the data consumer can define the inference rules.

I was excited.

But I was reminded that academic currency is isn't usually useful to me. Publishing a paper (or attempting to) and proposing a standard or an extension to a standard might win academic points but it doesn't help me leverage Wikidata today.

I had recently read Ritchie and Thompson's "The UNIX Time-Shaing System" paper from 1974 and their software composability ideas where mingling with my desire to have reasoning over remote SPARQL endpoints.

"The most important role of UNIX is to provide a file system."

That is partly because files are a great way to allow interprocess communication to be blending with human interaction.


I got excited again thinking that I could implement something like remote reasoning using UNIX thinking:

Small Sharp tools reference. Composable, etc.

6.2 Filters
...
A sequence of commands separated by vertical bars causes the Shell to execute all the commands simultaneously and to arrange that the standard output of each command be delivered to the standard input of the next command in the sequence.


The sequence goes like this:

1) Find or craft some triples to serve as your Tbox (ontology) triples.

2) Query the remote SPARQL endpoint to obtain some triples that you want to reason over.

3) Apply a reasoner (using your Tbox triples) to the triples you want to reason over. 

4) Run a final SPARQL query against all the resultant (derived and original) triples.





I could have made this repo a single command pipeline but the Apache Jena command line utilities sometimes need to see a file extension so it can guess what RDF serialization format is in use. But it isn't terrible to store intermediate files because then you can change queries or the ontology file and let `make` decide what needs to be executed to update your output file. 

e.g 
If you update your Tbox triples then you need to run steps 2-4 again. 

If you update your final SPARQL query then you only need to run step 4. 

