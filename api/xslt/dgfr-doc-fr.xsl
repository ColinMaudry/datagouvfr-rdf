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
			<meta content="" name="description"/>
			<meta content="" name="author"/>
			<link rel="shortcut icon" href="{$_resourceRoot}images/datagovuk_favicon.png" type="image/x-icon" />
			
			<title>Documentation - data.gouv.fr explorer by Colin Maudry</title>
			
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
						<a class="navbar-brand" href="#">Data.gouv.fr explorer</a>
					</div>
					<div class="collapse navbar-collapse" id="navbar">
						<ul class="nav navbar-nav">
							<li><a href="/fr/datasets">Explorer</a></li>
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
						<h1>Documentation</h1>
						<h2 id="what">Qu'est-ce que c'est ?</h2>
						<p>Le <strong>data.gouv.fr explorer</strong> remplit deux fonctions :</p>
						<ul>
							<li>Proposer <a href="#api">des API</a> en lecture seule afin que les développeurs puissent facilement utiliser les métadonnées <a href="http://data.gouv.fr"
								>data.gouv.fr</a> pour leurs applications</li>
							<li>Grâce à ces mêmes API, proposer <a href="/fr/datasets">une interface de navigation et de recherche</a></li>
						</ul>
						<h2>Qu'est qu'il apporte par rapport aux fonctionnalités déjà présentes sur <a href="http://data.gouv.fr">http://data.gouv.fr</a> ?</h2>
						<h3>Pour les développeurs</h3>
						<p>data.gouv.fr <a href="https://www.data.gouv.fr/fr/apidoc/">propose une API</a> qui permet de consulter les métadonnées et procéder à des modifications. Un outil est
							même proposé pour tester les appels d'API depuis la page de documentation. Le data.gouv.fr explorer <a href="#api">complète les API proposées</a> avec davantage de
							formats disponibles.</p>
						<h3>Pour les utilisateurs</h3>
						<p>Certaines métadonnées ne sont pas visibles pour l'utilisateur, notamment le nombre de visites et de visiteurs uniques sur la page d'un jeu de données. Ces métadonnées
							sont visibles dans l'interface de navigation du data.gouv.fr explorer. Lorsque vous vous trouvez sur la page d'un jeu de données sur data.gouv.fr, dans l'adresse,
							remplacez "gouv.fr" par "maudry.com". Et voilà.</p>
						<h2 id="why">Mais pourquoi as-tu développé cet outil ?</h2>
						<ul>
							<li>Pour m'exercer à la publication de <a href="https://fr.wikipedia.org/wiki/Web_des_donn%C3%A9es">Linked data</a></li>
							<li>Pour démontrer mes compétences en la matière</li>
							<li>Parce que je publie déjà <a href="https://www.data.gouv.fr/fr/datasets/metadonnees-des-jeux-de-donnees-publies-sur-data-gouv-fr-1/">les métadonnées data.gouv.fr au
								format RDF</a> (un format du <a href="https://fr.wikipedia.org/wiki/Web_s%C3%A9mantique">Web sémantique</a>) ce qui était un pré-requis</li>
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
							règles de réécriture des URL afin que chacun puisse facilement passé d'une page data.gouv.fr à l'explorer.</p>
						<p>Une implémentation des Linked Data API existe également en PHP, <a href="https://code.google.com/p/puelia-php/">Puelia</a>. Même si elle est fonctionnelle, Elda jouit
							d'une communauté plus active.</p>
						<h2 id="api">Comment fonctionnent les APIs ?</h2>
						<h3>Formats</h3>
						<p>Les formats suivants sont proposés en réponse :</p>
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
									<td>http://localhost:8080/fr/datasets/poles-d-excellence-rurale-30383018.xml</td>
									<td>http://localhost:8080/fr/datasets.xml</td>
								</tr>
								<tr>
									<td>JSON</td>
									<td>.json</td>
									<td>application/json</td>
									<td>http://localhost:8080/fr/datasets/poles-d-excellence-rurale-30383018.json</td>
									<td>http://localhost:8080/fr/datasets.json</td>
								</tr>
								<tr>
									<td>CSV</td>
									<td>.csv</td>
									<td>text/csv</td>
									<td>http://localhost:8080/fr/datasets/poles-d-excellence-rurale-30383018.csv</td>
									<td>http://localhost:8080/fr/datasets.csv</td>
								</tr>
								<tr>
									<td><a href="https://fr.wikipedia.org/wiki/Atom">Atom</a></td>
									<td>.atom</td>
									<td>application/atom+xml</td>
									<td>http://localhost:8080/fr/datasets/poles-d-excellence-rurale-30383018.atom</td>
									<td>http://localhost:8080/fr/datasets.atom</td>
								</tr>
								<tr>
									<td>Text (identique au JSON)</td>
									<td>.text</td>
									<td>text/plain</td>
									<td>http://localhost:8080/fr/datasets/poles-d-excellence-rurale-30383018.text</td>
									<td>http://localhost:8080/fr/datasets.text</td>
								</tr>
								<tr>
									<td><a href="https://en.wikipedia.org/wiki/RDF/XML">RDF/XML</a></td>
									<td>.rdf</td>
									<td>application/rdf+xml</td>
									<td>http://localhost:8080/fr/datasets/poles-d-excellence-rurale-30383018.rdf</td>
									<td>http://localhost:8080/fr/datasets.rdf</td>
								</tr>
								<tr>
									<td><a href="https://en.wikipedia.org/wiki/Turtle_%28syntax%29">Turtle</a></td>
									<td>.ttl</td>
									<td>text/turtle</td>
									<td>http://localhost:8080/fr/datasets/poles-d-excellence-rurale-30383018.ttl</td>
									<td>http://localhost:8080/fr/datasets.ttl</td>
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
									<td><tt>curl http://localhost:8080/fr/datasets/poles-d-excellence-rurale-30383018.xml</tt></td>
									<td>Un ensemble prédéfini de propriétés pour ce dataset en XML.</td>
								</tr>
								<tr>
									<td><tt>curl http://localhost:8080/fr/datasets/poles-d-excellence-rurale-30383018?_view=all</tt></td>
									<td>Toutes les propriétés directes de ce dataset en HTML.</td>
								</tr>
								<tr>
									<td><tt>curl http://localhost:8080/fr/datasets.json</tt></td>
									<td>Un ensemble prédéfini de propriétés pour les 10 derniers datasets créés sur data.gouv.fr en JSON.</td>
								</tr>
								<tr>
									<td><tt>curl -H "Accept:text/turtle" http://localhost:8080/fr/datasets?_view=Statistics&amp;_page=0&amp;_sort=-followers</tt></td>
									<td>Les métadonnées liées aux statistiques des 10 datasets qui ont le plus de followers (ordre décroissant) au format Turtle. Comme ici on utilise la <a
										href="https://fr.wikipedia.org/wiki/N%C3%A9gociation_de_contenu">négociation de contenu</a>, la réponse inclue des métadonnées supplémentaire liées à la
										requête, telles que la requête SPARQL utilisée et la configuration de l'API.</td>
								</tr>
							</tbody>
						</table>
						<p>Je ne présente ici qu'une petite partie des paramètres que vous pouvez passer dans l'URL. Je vous suggère de naviguer dans <a href="/fr/datasets">l'interface d'exploration</a> et de cliquer partout, en observant l'évolution de l'URL.</p>
						<h3>URI</h3>
						<p>La structure des URI est la même que celle utilisées pour les pages data.gouv.fr, à ceci près que :</p>
						<ul>
							<li>le domaine est différent : https://www.data.maudry.com</li>
							<li>il n'y pas de slash (/) à la fin des URI. Toutes les URI se terminant par un slash sont redirigées vers l'équivalent sans slash.</li>
						</ul>
						<p>Ce projet étant une pure initiative individuelle, il n'existe pas de garantie que ces URI perdurent indéfiniment. Le plus probable est qu'un jour, les possibilités offertes par l'explorer soient implémentées au sein du domaine data.gouv.fr.</p>
						<h3>Fraîcheur des données</h3>
						<p>Je m'engage à synchroniser les métadonnées data.gouv.fr avec le triple store au moins une fois par semaine. En pratique, cette synchronisation a lieu environ une fois par jour. Vous pouvez vérifier la fraîcheur des données <a href="http://dydra.com/colin-maudry/datagouvfr/derniers-jeux-de-donnees-heure-gmt.html">ici</a>.</p>
						<h3>Performance</h3>
						<p>Les données sont stockées dans un triple store fourni à titre gracieux par Dydra. Si d'ordinaire les performances sont acceptables, il n'y a aucune garantie que ce soit toujours le cas si l'application est très sollicitée.</p>
						<p>Elda garde chaque réponse en cache pendant 10 minutes (en tout cas c'est ce que je lui ai demandé).</p>
						<p>Vous pouvez voir des statistiques sur les requêtes reçues par l'outil et les temps de réponse <a href="/control/show-stats">ici</a>.</p>
						<h2 id="contact">Me contacter</h2>
						<p>Par email : colin@maudry.com</p>
						<p>Sur Twitter : <a href="https://twitter.com/CMaudry">@CMaudry</a></p>
						<p><a href="https://github.com/ColinMaudry/datagouvfr-rdf/issues/new">Soumettre un issue sur Github</a></p>
					</div>
				</div>
			</div>
			<!-- Bootstrap core JavaScript
    ================================================== -->
			<!-- Placed at the end of the document so the pages load faster -->
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
			<script src="../../dist/js/bootstrap.min.js"></script>
			<script src="../../assets/js/docs.min.js"></script>
			<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
			<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
			<!-- Piwik -->
			<script type="text/javascript">
				var _paq = _paq || [];
				_paq.push(['trackPageView']);
				_paq.push(['enableLinkTracking']);
				(function() {
				var u="//analytics.maudry.com/";
				_paq.push(['setTrackerUrl', u+'piwik.php']);
				_paq.push(['setSiteId', 4]);
				var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
				g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
				})();
			</script>
			<noscript><p><img alt="" src="//analytics.maudry.com/piwik.php?idsite=4" style="border:0;" /></p></noscript>
			<!-- End Piwik Code -->
		</body>
		
	</html>
</xsl:template>

</xsl:stylesheet>
