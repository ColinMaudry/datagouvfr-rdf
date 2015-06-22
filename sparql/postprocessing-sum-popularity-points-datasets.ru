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
#Sums up the points of related distributions
#and adds the result to the points gathered at dataset/reuse level
insert {?dataset dgfr:sumPopularityPoints ?sumDatasetPoints}
where {
  {select ?dataset ((sum(?distributionPoints) + ?datasetPoints) as ?sumDatasetPoints) where {
    graph <urn:graph:pointsValues> {
      ?property dgfr:pointsPopularityValue ?points
    }
    graph <urn:graph:postprocessing> {
		 ?dataset a dcat:Dataset ;
		 dgfr:popularityPoints ?datasetPoints ;
			dcat:distribution ?distribution .					 
    ?distribution ?property ?propertyValue .
      }    
    bind ((?propertyValue * ?points) as ?distributionPoints)
  }#close inner where
group by ?dataset ?datasetPoints

}}