PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX void: <http://rdfs.org/ns/void#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX dcat: <http://www.w3.org/ns/dcat#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX dgfr: <http://colin.maudry.com/ontologies/dgfr#>

#Store original media type for the few distributions that have one
with <urn:graph:postprocessing>
delete {?distribution dcat:byteSize ?someSize ;
			 dcat:mediaType ?oriMediaType .}
insert {?distribution dgfr:oriMediaType ?oriMediaType .}
where {
	?distribution a dcat:Distribution ;
						dcat:byteSize ?someSize ;			
						dcat:mediaType ?oriMediaType .
	};

#Copy distribution data over to postprocessing graph
ADD <urn:files:data> TO <urn:graph:postprocessing> ;

#Replace the value of dcat:mediaType from distribution data with the original one
with <urn:graph:postprocessing>
delete {?distribution dcat:mediaType ?newMediaType ;
			 dgfr:oriMediaType ?oriMediaType .}
insert {?distribution dcat:mediaType ?oriMediaType .}
where {
	?distribution a dcat:Distribution ;
						dgfr:oriMediaType ?oriMediaType ;
						dcat:mediaType ?newMediaType .
	};

#Count unavailable distributions in datasets
with <urn:graph:postprocessing>
insert {
?dataset dgfr:unavailableDistributions ?unavailableDistributions .
}
where {
{
  select ?dataset (count(?unavailableDistribution) as ?unavailableDistributions) 
  where {
  graph <urn:graph:postprocessing> {
       ?unavailableDistribution a dcat:Distribution ;
      dgfr:available false .
  ?dataset a dcat:Dataset ;
      dcat:distribution ?unavailableDistribution . 
      }
  }
    group by ?dataset
	}
};

#Count available distributions in datasets
with <urn:graph:postprocessing>
insert {
?dataset dgfr:availableDistributions ?availableDistributions .
}
where {
{
  select ?dataset (count(?availableDistribution) as ?availableDistributions) 
  where {
  graph <urn:graph:postprocessing> {
       ?availableDistribution a dcat:Distribution ;
      dgfr:available true .
  ?dataset a dcat:Dataset ;
      dcat:distribution ?availableDistribution . 
      }
  }
    group by ?dataset
	}
};

#Sum up unavailable distributions at organization level
with <urn:graph:postprocessing>
insert {
?organization dgfr:unavailableDistributions ?unavailableDistributions .

}
where {
{
  select ?organization (sum(?datasetUnavailableDistributions) as ?unavailableDistributions) 
  where {
        ?organization a foaf:Organization ;
          dgfr:published ?dataset .
       
         ?dataset a dcat:Dataset ;
            dgfr:unavailableDistributions ?datasetUnavailableDistributions . 
  }
    group by ?organization
	}
};

#Sum up available distributions at organization level
with <urn:graph:postprocessing>
insert {
?organization dgfr:availableDistributions ?availableDistributions .

}
where {
{
  select ?organization (sum(?datasetAvailableDistributions) as ?availableDistributions) 
  where {    
        ?organization a foaf:Organization ;
          dgfr:published ?dataset .
       
         ?dataset a dcat:Dataset ;
            dgfr:availableDistributions ?datasetAvailableDistributions . 
  }
    group by ?organization
	}
};

#Declare a list of content types as "machine readable"
with <urn:graph:postprocessing>
insert {
	?resource dgfr:machineReadable ?machineReadable .
}
where {
  values (?mediaType ?machineReadable) {
    ("application/xml" true)
    ("text/xml" true)
		("application/json" true)
    ("text/csv" true)
    ("application/csv" true)
    ("text/tsv" true)
    ("text/plain" true)
		("application/rdf+xml" true)
    ("text/turtle" true)
    ("text/trig" true)
    ("text/n-triples" true)
		("application/shp+zip" true)
    }
    ?resource a dcat:Distribution ;
      dcat:mediaType ?mediaType .
};

#The resources that didn't get the dgfr:machineReadable property are declared as not-machine readable
with <urn:graph:postprocessing>
insert {?resource dgfr:machineReadable false .}

where {
    ?resource a dcat:Distribution ;
    dcat:mediaType ?mediaType .
  filter not exists {?resource dgfr:machineReadable ?machineReadable}
}























