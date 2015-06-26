PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX void: <http://rdfs.org/ns/void#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX dcat: <http://www.w3.org/ns/dcat#>
PREFIX dct: <http://purl.org/dc/terms/>
PREFIX dgfr: <http://colin.maudry.com/ontologies/dgfr#>

with <urn:graph:postprocessing>
delete {?distribution dcat:byteSize ?someSize .}
insert {
  ?distribution dgfr:responseStatusCode ?responseCode ;
								dcat:byteSize ?size ;
								dgfr:available ?available .
  ?distributionMT dcat:mediaType ?mediaType .
}
where {
   graph <urn:files:data> {
  	 ?distribution dgfr:responseStatusCode ?responseCode ;
									 dcat:byteSize ?size .
		 bind(if(?responseCode != "HTTP/1.1 200 OK", false, true) as ?available)
		 ?distributionMT dcat:mediaType ?mediaType .
  }
  	graph <urn:graph:postprocessing> {
			?distribution a dcat:Distribution .
			?distributionMT a dcat:Distribution .
		filter not exists {?distributionMT dcat:mediaType ?someMediaType}
  }}
