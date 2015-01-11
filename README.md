Semantic data.gouv.fr (0.2.0)
==============

Various stuff around uplifting the French open data portal to the [Semantic Web](http://www.w3.org/standards/semanticweb) (Web 3.0).

This is the foundation work that fuels the [data.gouv.fr explorer app](https://translate.google.com/translate?sl=fr&tl=en&js=y&prev=_t&hl=fr&ie=UTF-8&u=https%3A%2F%2Fwww.data.maudry.com%2Ffr&edit-text=).

## Update script

[build.xml](build.xml) is an Apache Ant script that runs the following tasks:

1. Downloading the latest metadata dumps from data.gouv.fr (CSV)
1. Cleaning the data dumps (empty lines, wrongly escaped quotes)
1. Converting the CSV into RDF (using )
1. Uploading the resulting RDF into an RDF repository

**I commit to run this script and update the RDF metadata ([see here in French](https://www.data.gouv.fr/fr/datasets/metadonnees-des-jeux-de-donnees-publies-sur-data-gouv-fr-1/), [in English](https://translate.google.com/translate?sl=fr&tl=en&js=y&prev=_t&hl=fr&ie=UTF-8&u=https%3A%2F%2Fwww.data.gouv.fr%2Ffr%2Fdatasets%2Fmetadonnees-des-jeux-de-donnees-publies-sur-data-gouv-fr-1%2F&edit-text=&act=url)) at least once a week**.

### Requirements

- [Apache Ant](http://ant.apache.org/bindownload.cgi), with [ANT INSTALL]/bin directory added to your PATH environment variable
- [cURL](http://curl.haxx.se/download.html), with [CURL INSTALL] directory added to your PATH environment variable
- [TARQL](https://github.com/cygri/tarql) by Richard Cyganiak (@cygri), with [TARQL INSTALL] directory added to your PATH environment variable

### Configuration

So far, I'm not able to give away the credentials of my repository and let anyone update the RDF metadata. This implies that the script does not run out-of-the-box, you need to edit the UPLOAD task with the address/credentials/graphs you wish.

If you run the script in a Unix environment, remember you need to remove ".bat" from executable names in the script (I need to automate this).

### Next steps

- Tell me!

## Contact

I would love to read your feedback/comments/suggestions!

If you have a Github account, you can [create an issue](https://github.com/ColinMaudry/datagouvfr-rdf/issues/new).

Otherwise, you can reach me:

- by email: colin@maudry.com
- on Twitter: [@CMaudry](https://twitter.com/CMaudry)

## Change log

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




