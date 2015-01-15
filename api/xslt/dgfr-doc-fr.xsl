<!--
Note: in at least some versions of libxslt (used by PHP), you can't set global
variables based on values retrieved by a key. Therefore this code contains
lots of redeclarations of the $northing, $easting, $lat, $long, $label,
$prefLabel, $altLabel, $title and $name variables.
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="linked-data-api.xsl"/>

<xsl:output method="html" encoding="utf-8" indent="yes" />

<xsl:param name="_resourceRoot">/</xsl:param> 

<xsl:param name="visibleSparqlEndpoint"/>
<xsl:param name="visibleSparqlForm"/>
<xsl:param name="activeImageBase" select="concat($_resourceRoot,'images/green/16x16')" />
<xsl:param name="inactiveImageBase" select="concat($_resourceRoot,'images/grey/16x16')" />

<xsl:param name="graphColour" select="'#577D00'" />

<xsl:template match="/">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
    
	<html lang="fr">
		<head>
			<meta charset="utf-8"/>
			<meta content="IE=edge" http-equiv="X-UA-Compatible"/>
			<meta content="width=device-width, initial-scale=1" name="viewport"/>
			<meta content="CasanovaLD, l'appli qui dévergonde les métadonnées data.gouv.fr" name="description"/>
			<meta content="Colin Maudry" name="author"/>
			<link rel="shortcut icon" href="{$_resourceRoot}images/datagovuk_favicon.png" type="image/x-icon" />
			
			<title>CasanovaLD pour data.gouv.fr by Colin Maudry</title>
			
			<!-- Bootstrap core CSS -->
			<link href="{$_resourceRoot}css/bootstrap/bootstrap.min.css" rel="stylesheet"/>
			
			<!-- Custom styles for Boostrap styles -->
			<link href="{$_resourceRoot}css/custom_bootstrap.css" rel="stylesheet"/>
		</head>
		
		<body>
			<nav class="navbar navbar-inverse navbar-fixed-top">
				<div class="container">
					<div class="navbar-header">
						<button aria-controls="navbar" aria-expanded="false" class="navbar-toggle collapsed" data-target="#navbar" data-toggle="collapse" type="button">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#">CasanovaLD</a>
					</div>
					<div class="collapse navbar-collapse" id="navbar">
						<ul class="nav navbar-nav">
							<li><a href="/fr/datasets">Explorer !</a></li>
							<li><a href="https://www.data.gouv.fr/fr/datasets/metadonnees-des-jeux-de-donnees-publies-sur-data-gouv-fr-1/">data.gouv.fr en RDF</a></li>
							<li><a href="https://github.com/ColinMaudry/datagouvfr-rdf">Code source</a></li>
							<li><a href="#contact">Contact</a></li>
						</ul>
					</div><!--/.nav-collapse -->
				</div>
			</nav>
			<div class="container">
				<div class="row">
					<div class="col-lg-8">
						<h1>CasanovaLD, l'appli qui dévergonde les métadonnées <a href="http://data.gouv.fr">data.gouv.fr</a></h1>
						<h2 id="what">Qu'est-ce que c'est ?</h2>
						<p><strong>CasanovaLD</strong> remplit deux fonctions :</p>
						<ul>
							<li>Proposer <a href="#api">des API</a> en lecture seule afin que les développeurs puissent facilement utiliser les métadonnées <a href="http://data.gouv.fr"
								>data.gouv.fr</a> pour leurs applications</li>
							<li>Grâce à ces mêmes API, proposer <a href="/fr/datasets">une interface de navigation et de recherche</a></li>
						</ul>
						<h2>Qu'est que CasanovaLD apporte par rapport aux fonctionnalités déjà présentes sur <a href="http://data.gouv.fr">data.gouv.fr</a> ?</h2>
						<h3>Pour les développeurs</h3>
						<p>data.gouv.fr <a href="https://www.data.gouv.fr/fr/apidoc/">propose une API</a> qui permet de consulter les métadonnées et procéder à des modifications. Un outil est
							même proposé pour tester les appels d'API depuis la page de documentation.</p>
						<p>CasanovaLD <a href="#api">complète les API proposées</a> avec davantage de
							formats disponibles. De plus, dans CasanovaLD, l'URI de chaque ressource est la même pour le HTML ou les autres formats. Seule l'extension (ex: .json) ou la <a
								href="https://fr.wikipedia.org/wiki/N%C3%A9gociation_de_contenu">négociation de contenu</a> change.</p>
						<h3>Pour les utilisateurs</h3>
						<p>Certaines métadonnées ne sont pas visibles pour l'utilisateur, notamment le nombre de visites et de visiteurs uniques sur la page d'un jeu de données. Ces métadonnées
							sont visibles dans l'interface de navigation de CasanovaLD. Lorsque vous vous trouvez sur la page d'un jeu de données sur data.gouv.fr, dans l'adresse,
							remplacez "gouv.fr" par "maudry.com". Et voilà.</p>
						<p><a href="/fr/datasets">L'interface de navigation</a> offre également de nombreuses possibilités de tri et de sélection.</p>
						<h2>Et quelles données y trouve t-on ?</h2>
						<p>Aujourd'hui, les métadonnées des objets suivants peuvent être consultées :</p>
						<ul>
							<li>Jeux de données (<a href="https://www.data.maudry.com/fr/datasets/metadonnees-des-jeux-de-donnees-publies-sur-data-gouv-fr-1">exemple</a>)</li>
							<li>Ressources (les fichiers de données, <a href="https://www.data.maudry.com/fr/resources/e0b7e6ce-461c-4648-aaf9-b98de3ef326d">exemple</a>)</li>
						</ul>
						<p>Les données accessibles dans CasanovaLD dépendent de leur <a href="https://wiki.data.gouv.fr/wiki/API_et_donn%C3%A9es_Data.gouv.fr">mise à disposition</a> par data.gouv.fr et de leur conversion en RDF.</p>
						<p>Les données relatives aux organisations qui publient des données sur data.gouv.fr (<a href="https://www.data.gouv.fr/fr/organizations/caisse-nationale-de-l-assurance-maladie-des-travailleurs-salaries/">exemple</a>) et celles relatives aux réutilisations (<a href="https://www.data.gouv.fr/fr/reuses/explorez-et-telechargez-les-donnees-damir-qui-vous-interessent/">exemple</a>) devraient être bientôt intégrées.</p>
						<h2 id="why">Mais pourquoi as-tu développé cet outil ?</h2>
						<ul>
							<li>Pour m'exercer à la publication de <a href="https://fr.wikipedia.org/wiki/Web_des_donn%C3%A9es">Linked data</a></li>
							<li>Pour démontrer mes compétences en la matière</li>
							<li>Parce que je publie déjà <a href="https://www.data.gouv.fr/fr/datasets/metadonnees-des-jeux-de-donnees-publies-sur-data-gouv-fr-rdf-web-semantique/">les métadonnées data.gouv.fr au
								format RDF</a> (le modèle du <a href="https://fr.wikipedia.org/wiki/Web_s%C3%A9mantique">Web sémantique</a>) ce qui était un pré-requis</li>
							<li>Parce que c'est agréable pour un développeur d'utiliser des outils faciles à utiliser et performants pour améliorer l'expérience des utilisateurs et des autres
								développeurs</li>
							<li>Parce que ce n'était ni difficile, ni long, compte tenu des <a href="#components">composants open source existants</a> et mon expérience dans des projets similaires
								tels que <a href="http://data.nxp.com">data.nxp.com</a></li>
							<li>Parce que je pense que les <a href="https://fr.wikipedia.org/wiki/Web_des_donn%C3%A9es">Linked data</a> sont le futur de la publication de données</li>
							<li>Parce que je veux faciliter la consommation des données publiques référencées sur data.gouv.fr</li>
						</ul>
						<h2 id="who">Qui est derrière la conception de cet outil ?</h2>
						<p>Moi, <a href="https://about.me/ColinMaudry">Colin Maudry</a>, suis l'unique développeur derrière cet outil. En revanche, la très grande majorité des fonctionnalités
							provient de <a href="#components">composants open source pré-existants</a>. Enfin, mon collègue <a href="https://twitter.com/wohnjalker">John Walker</a>, qui a déjà
							configuré un outil similaire, m'a donné quelques astuces.</p>
						<p>J'ai développé cet outil sur mon temps libre.</p>
						<h2 id="components">OK, OK, mais on veut voir ce qu'il y a sous le capot !</h2>
						<p>L'essentiel des fonctionnalités est fourni par <a href="https://epimorphics.github.io/elda/">Elda</a>, une implémentation des <a
							href="http://code.google.com/p/linked-data-api/wiki/Specification">Linked Data API</a> développée par <a href="http://epimorphics.com/">Epimorphics</a>. Ma
							contribution réside principalement dans <a href="https://github.com/ColinMaudry/datagouvfr-rdf/tree/master/api">la configuration d'Elda</a> afin qu'elle exploite et
							présente les métadonnées data.gouv.fr.</p>
						<p>Elda est codée en Java et est déployée sur un serveur d'applications Tomcat, hébérgé sur un VPS chez <a href="http://gandi.net">Gandi</a>. J'ai implémenté quelques
							règles de réécriture des URL afin que chacun puisse facilement passer d'une page data.gouv.fr à CasanovaLD.</p>
						<p>Une implémentation des Linked Data API existe également en PHP, <a href="https://code.google.com/p/puelia-php/">Puelia</a>. Même si elle est fonctionnelle, Elda jouit
							d'une communauté plus active.</p>
						<h2 id="api">Comment fonctionnent l'API ?</h2>
						<h3>Formats</h3>
						<p>Les formats suivants sont proposés en réponse de HTTP GET :</p>
						<table class="table">
							<thead>
								<tr>
									<th>Format</th>
									<th>Extension</th>
									<th>MIME type</th>
									<th>Exemple pour un item</th>
									<th>Exemple pour une liste</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>XML</td>
									<td>.xml</td>
									<td>application/xml</td>
									<td><a href="https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.xml">https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.xml</a></td>
									<td><a href="https://www.data.maudry.com/fr/datasets.xml">https://www.data.maudry.com/fr/datasets.xml</a></td>
								</tr>
								<tr>
									<td>JSON</td>
									<td>.json</td>
									<td>application/json</td>
									<td><a href="https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.json">https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.json</a></td>
									<td><a href="https://www.data.maudry.com/fr/datasets.json">https://www.data.maudry.com/fr/datasets.json</a></td>
								</tr>
								<tr>
									<td>CSV</td>
									<td>.csv</td>
									<td>text/csv</td>
									<td><a href="https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.csv">https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.csv</a></td>
									<td><a href="https://www.data.maudry.com/fr/datasets.csv">https://www.data.maudry.com/fr/datasets.csv</a></td>
								</tr>
								<tr>
									<td><a href="https://fr.wikipedia.org/wiki/Atom">Atom</a></td>
									<td>.atom</td>
									<td>application/atom+xml</td>
									<td><a href="https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.atom">https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.atom</a></td>
									<td><a href="https://www.data.maudry.com/fr/datasets.atom">https://www.data.maudry.com/fr/datasets.atom</a></td>
								</tr>
								<tr>
									<td><a href="https://en.wikipedia.org/wiki/RDF/XML">RDF/XML</a></td>
									<td>.rdf</td>
									<td>application/rdf+xml</td>
									<td><a href="https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.rdf">https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.rdf</a></td>
									<td><a href="https://www.data.maudry.com/fr/datasets.rdf">https://www.data.maudry.com/fr/datasets.rdf</a></td>
								</tr>
								<tr>
									<td><a href="https://en.wikipedia.org/wiki/Turtle_%28syntax%29">Turtle</a></td>
									<td>.ttl</td>
									<td>text/turtle</td>
									<td><a href="https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.ttl">https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.ttl</a></td>
									<td><a href="https://www.data.maudry.com/fr/datasets.ttl">https://www.data.maudry.com/fr/datasets.ttl</a></td>
								</tr>
							</tbody>
						</table>
						<h3>Plus d'exemples</h3>
						<table class="table">
							<thead>
								<tr>
									<th>Commande <a href="https://en.wikipedia.org/wiki/CURL">cURL</a></th>
									<th>Réponse</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><tt>curl <a href="https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.xml">https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018.xml</a></tt></td>
									<td>Un ensemble prédéfini de propriétés pour ce dataset en XML.</td>
								</tr>
								<tr>
									<td><tt>curl <a href="https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018?_view=all">https://www.data.maudry.com/fr/datasets/poles-d-excellence-rurale-30383018?_view=all</a></tt></td>
									<td>Toutes les propriétés directes de ce dataset en HTML.</td>
								</tr>
								<tr>
									<td><tt>curl <a href="https://www.data.maudry.com/fr/datasets.json">https://www.data.maudry.com/fr/datasets.json</a></tt></td>
									<td>Un ensemble prédéfini de propriétés pour les 10 derniers datasets créés sur data.gouv.fr en JSON.</td>
								</tr>
								<tr>
									<td><tt>curl -H "Accept:text/turtle" <a href="https://www.data.maudry.com/fr/datasets?_view=Statistics&amp;_page=0&amp;_sort=-followers">https://www.data.maudry.com/fr/datasets?_view=Statistics&amp;_page=0&amp;_sort=-followers</a></tt></td>
									<td>Les métadonnées liées aux statistiques des 10 datasets qui ont le plus de followers (ordre décroissant) au format Turtle. Comme ici on utilise la <a
										href="https://fr.wikipedia.org/wiki/N%C3%A9gociation_de_contenu">négociation de contenu</a>, la réponse inclut des métadonnées supplémentaire liées à la
										requête, telles que la requête SPARQL utilisée et la configuration de l'API.</td>
								</tr>
								<tr>
									<td><tt>curl <a href="https://www.data.maudry.com/fr/datasets?distribution.dgfr_format=zip">https://www.data.maudry.com/fr/datasets?distribution.dgfr_format=zip</a></tt></td>
									<td>Un ensemble prédéfini de propriétés pour les 10 derniers datasets créés sur data.gouv.fr qui ont au moins une distribution au format ZIP.</td>
								</tr>
							</tbody>
						</table>
						<p>Je ne présente ici qu'une petite partie des paramètres que vous pouvez passer dans l'URL. Je vous suggère de naviguer dans <a href="/fr/datasets">l'interface d'exploration</a> et de cliquer partout, en observant l'évolution de l'URL. Pour être honnête, je découvre encore les possibilités offertes par l'API Elda. Conscient qu'une bonne API est une API bien documentée, je tâcherai d'étoffer ce chapitre. Vous pouvez également <a href="https://github.com/ColinMaudry/datagouvfr-rdf/blob/master/api/xslt/dgfr-doc-fr.xsl">le faire vous-même</a> !</p>
						<h3>URI</h3>
						<p>La structure des URI est la même que celles utilisées pour les pages data.gouv.fr, à ceci près que :</p>
						<ul>
							<li>le domaine est différent : https://www.data.maudry.com</li>
							<li>il n'y pas de slash (/) à la fin des URI. Toutes les URI se terminant par un slash sont redirigées vers l'équivalent sans slash.</li>
						</ul>
						<p>Ce projet étant une pure initiative individuelle, il n'existe pas de garantie que ces URI perdurent indéfiniment. Le plus probable est qu'un jour, les possibilités offertes par CasanovaLD soient implémentées au sein du domaine data.gouv.fr.</p>
						<h3>Fraîcheur des données</h3>
						<p>Je m'engage à synchroniser les métadonnées data.gouv.fr avec le triple store au moins une fois par semaine. En pratique, cette synchronisation a lieu environ une fois par jour. Vous pouvez vérifier la fraîcheur des données <a href="http://dydra.com/colin-maudry/datagouvfr/derniers-jeux-de-donnees-heure-gmt.html">ici</a>.</p>
						<h3>Performance</h3>
						<p>Les données sont stockées dans un triple store fourni à titre gracieux par <a href="http://dydra.com">Dydra</a>. Si d'ordinaire les performances sont acceptables, il n'y a aucune garantie que ce soit toujours le cas si l'application est très sollicitée.</p>
						<p>Elda garde chaque réponse en cache pendant 10 minutes (en tout cas c'est ce que je lui ai demandé).</p>
						<p>Vous pouvez voir des statistiques sur les requêtes reçues par l'outil et les temps de réponse depuis le dernier redémarrage de l'application <a href="/control/show-stats">ici</a>.</p>
						<h2 id="contact">Me contacter</h2>
						<p>Par email : colin@maudry.com</p>
						<p>Sur Twitter : <a href="https://twitter.com/CMaudry">@CMaudry</a></p>
						<p><a href="https://github.com/ColinMaudry/datagouvfr-rdf/issues/new">Soumettre un issue sur Github</a></p>
					</div>
				</div>
			</div>
			<!-- Bootstrap core JavaScript
    ================================================== -->
			<!-- Sorry, couldn't use Piwik because https -->
			<script>
				(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
				(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
				m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
				})(window,document,'script','//www.google-analytics.com/analytics.js','ga');
				
				ga('create', 'UA-58462015-1', 'auto');
				ga('send', 'pageview');
				
			</script>
		</body>
		
	</html>
</xsl:template>

</xsl:stylesheet>
