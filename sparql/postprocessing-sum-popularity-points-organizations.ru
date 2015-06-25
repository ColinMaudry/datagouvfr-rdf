PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX void: <http://rdfs.org/ns/void#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX dcat: <http://www.w3.org/ns/dcat#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX dgfr: <http://colin.maudry.com/ontologies/dgfr#>
PREFIX xs: <http://www.w3.org/2001/XMLSchema#>
PREFIX apf: <http://jena.hpl.hp.com/ARQ/property#>

with <urn:graph:postprocessing>
#Sums up the points of related datasets and distributions at organization level
#and adds the result to the points gathered at organization level
insert {?organization dgfr:tempSumPopularityPoints ?sumObjectPoints}
where {
  {select ?organization ((sum(?datasetPoints) + ?organizationPoints) as ?sumObjectPoints) where {
    graph <urn:graph:postprocessing> {
    ?organization a foaf:Organization ;
          dgfr:popularityPoints ?organizationPoints ;
        dgfr:published ?dataset .
		?dataset a dcat:Dataset ; 
				dgfr:sumPopularityPoints ?datasetPoints . 
  }
  }#close inner where
group by ?organization ?organizationPoints		
	}};
with <urn:graph:postprocessing>
#Sums up the points of reuses at organization level
#Delete/insert is ineffective, so I had to create a extra query below to remove temp property
insert {?organization dgfr:sumPopularityPoints ?sumObjectPoints}
where {
	{select ?organization ((sum(?reusePoints) + ?oldSumObjectPoints) as ?sumObjectPoints) where {
    graph <urn:graph:postprocessing> {
    ?organization a foaf:Organization ;
		dgfr:tempSumPopularityPoints ?oldSumObjectPoints ;			
        dgfr:published ?reuse .
		?reuse a dgfr:Reuse ; 
				dgfr:popularityPoints ?reusePoints .
  }
	}#close inner where
group by ?organization ?oldSumObjectPoints  		
	}};
with <urn:graph:postprocessing>
#Remove temp property for org with reuses
delete {?organization dgfr:tempSumPopularityPoints ?sumObjectPoints}
where {?organization dgfr:tempSumPopularityPoints ?sumObjectPoints ;
				dgfr:published ?reuse .
				?reuse a dgfr:Reuse .	};
with <urn:graph:postprocessing>
#Replace temp property for org without reuses
delete {?organization dgfr:tempSumPopularityPoints ?sumObjectPoints}
insert {?organization dgfr:sumPopularityPoints ?sumObjectPoints}
where {?organization dgfr:tempSumPopularityPoints ?sumObjectPoints}
