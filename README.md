Semantic data.gouv.fr (0.7.0)
==============

Various stuff around uplifting the French open data portal, [data.gouv.fr](http://data.gouv.fr/en), to the [Semantic Web](http://www.w3.org/standards/semanticweb) (Web 3.0).

This is the foundation work that fuels [CasanovaLD](https://translate.google.com/translate?sl=fr&tl=en&js=y&prev=_t&hl=fr&ie=UTF-8&u=https%3A%2F%2Fwww.data.maudry.com%2Ffr&edit-text=).

## Update script

[build.xml](build.xml) is an Apache Ant script that runs the following tasks:

1. Downloading the latest metadata dumps from data.gouv.fr (CSV)
1. Cleaning the data dumps (empty lines, wrongly escaped quotes)
1. Converting the CSV into RDF (using [TARQL](https://github.com/cygri/tarql))
1. Upload to an RDF repository
1. Converts text identifiers in URIs for better linking across the data
3. Does some smart postprocessing to make the objects more interlinked in the graph, integrates the output of [beheader](https://github.com/ColinMaudry/beheader) into the graph
1. Adds some metadata about the resulting data set (DCAT, VoID, PROV)

**This script is run every 2 hours to update the RDF metadata ([see here in French](https://www.data.gouv.fr/fr/datasets/metadonnees-des-jeux-de-donnees-publies-sur-data-gouv-fr-1/), [in English](https://translate.google.com/translate?sl=fr&tl=en&js=y&prev=_t&hl=fr&ie=UTF-8&u=https%3A%2F%2Fwww.data.gouv.fr%2Ffr%2Fdatasets%2Fmetadonnees-des-jeux-de-donnees-publies-sur-data-gouv-fr-rdf-web-semantique%2F&edit-text=))**.

This wouldn't be possible and so easy without the publication of live CSVs by @noirbizarre for @etalab.

The data model can be seen [here](https://www.lucidchart.com/documents/view/6011b6e0-6a85-413a-8279-0588b0f10992).

### Requirements

- [Apache Ant](http://ant.apache.org/bindownload.cgi), with [ANT INSTALL]/bin directory added to your PATH environment variable
- [cURL](http://curl.haxx.se/download.html), with [CURL INSTALL] directory added to your PATH environment variable
- [TARQL](https://github.com/cygri/tarql) by Richard Cyganiak (@cygri), with [TARQL INSTALL] directory added to your PATH environment variable
- An RDF repository. Apache Fuseki is a good choice, but there are plenty.

### Configuration

- Copy upload_template.properties and rename it upload.properties
- Open it and fill it. As-is, your repository requires a user:password combination

### Run it

- If Requirements are fulfilled, just run `ant` in `datagouvfr-rdf` root folder.
- If you have already run the process and just want to reload the data in the triple store, run `ant quick`.

### Next steps

- Tell me!

## Contact

I would love to read your feedback/comments/suggestions!

If you have a Github account, you can [create an issue](https://github.com/ColinMaudry/datagouvfr-rdf/issues/new).

Otherwise, you can reach me:

- by email: colin@maudry.com
- on Twitter: [@CMaudry](https://twitter.com/CMaudry)

## Change log

#### 0.7.0

* Added properties dgfr:responseStatusCode, dgfr:responseTime and dgfr:availabilityCheckedOn to the ontology and API configuration
* Added direct link between organizations and published distributions (see the result in [the data model]((https://www.lucidchart.com/documents/view/6011b6e0-6a85-413a-8279-0588b0f10992))
* Added a view for anavailable resources in the API (https://www.data.maudry.com/fr/resources/unavailable)
* Icons for boolean values (true/false) are clearer now

#### 0.6.0

- Added ontology documentation (Ontoology, thanks @dgarijo). You can view it following the ontology URI at http://colin.maudry.com/ontologies/dgfr/index.html

#### 0.5.0

- Availability and unavailability count at dataset and organization levels

##### 0.4.3

- Made SPARQL endpoint configuration more flexible

##### 0.4.2

- Fixed errors in ontology

##### 0.4.1

- Disabled archiving of RDF due to disk space. Will enable again when I have a clearer archiving strategy.

#### 0.4.0

- Calculation of popularity points for all objects, and aggregate sums on organisations and datasets
- Integration of the data collected by [beheader](https://github.com/ColinMaudry/beheader) (availability of the distributions, content type, content length)

##### 0.3.3

- Enabled ETL with previously downloaded data to have CasanovaLD up quicker 

##### 0.3.2

- Not much...

##### 0.3.1

- Updated [the API documentation](https://www.data.maudry.com/fr/.doc#api)
- Updated VoiD and PROV metadata to match the new repository location

#### 0.3.0

- The RDF data is now loaded in a single atomic transaction in the repository
- Switch from Dydra (http://dydra.com) to a local Apache Fuseki instance
- Added organizations and reuses data, with all identifiers turned into URIs for full linking

##### 0.2.1

- That was a lame name. Say hi to [CasanovaLD](https://translate.google.com/translate?sl=fr&tl=en&js=y&prev=_t&hl=fr&ie=UTF-8&u=https%3A%2F%2Fwww.data.maudry.com%2Ffr&edit-text=)!
- Improved documentation

#### 0.2.0

- The [data.gouv.fr explorer app](https://translate.google.com/translate?sl=fr&tl=en&js=y&prev=_t&hl=fr&ie=UTF-8&u=https%3A%2F%2Fwww.data.maudry.com%2Ffr&edit-text=), with somewhat documented APIs, is live!
- URIs have changed to match the domain of the app
- Added dgfr:visits and dcterms:keywords (as comma-separated list, meh) in the data 

##### 0.1.5

- Redirections to the www. address was flaky on data.gouv.fr, so I had to specify the fully resolved address (e.g. http://www.data.gouv.fr/fr/datasets.csv)

##### 0.1.4

- Fixed missing properties (mismatch at conversion stage). Still no tags

##### 0.1.3

- Fixed RDF dataset modification date

##### 0.1.2

- Fixed resources that have spaces in their URLs (url-encode)
- Added dgfr:slug for datasets

##### 0.1.1

- Configured upload and update of VoID and PROV metadata (in default graph)
- Enabled scheduled task to update data every day

#### 0.1.0

- Script to download/clean/convert/publish data.gouv.fr dataset metadata
- Basic documentation





