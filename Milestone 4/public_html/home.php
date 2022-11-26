<html>
	<head>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
		<style>
			.para {
				width: 70%;
				margin: 3rem;
			}
			.success {
				color: dodgerblue;
			}
			.fail {
				color: red;
			}
 		</style>
	</head> 
	<body>
		<!--inspiration from https://www.w3schools.com/bootstrap/bootstrap_get_started.asp-->
		<nav class="navbar navbar-default">
			<div class="container-fluid">
    		<div class="navbar-header">
      			<a class="navbar-brand" href="#">Pokemon Database</a>
    		</div>
    		<ul class="nav navbar-nav">
				<li class="active"><a href="#">Home</a></li>
				<li><a href="./insert.php">INSERT</a></li>
				<li><a href="./delete.php">DELETE</a></li>
				<li><a href="./update.php">UPDATE</a></li>
				<li><a href="./selection.php">SELECTION</a></li>
				<li><a href="./projection.php">PROJECTION</a></li>
				<li><a href="./join.php">JOIN</a></li>
				<li><a href="./division.php">DIVISION</a></li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="dropdown" href="#">AGGREGATION<span class="caret"></span></a>
					<ul class="dropdown-menu">
					<li><a href="./group_by.php">GROUP BY</a></li>
					<li><a href="./having.php">HAVING</a></li>
					<li><a href="./nested.php">NESTED - GROUP BY</a></li>
					</ul>
				</li>
    		</ul>
			</div>
		</nav>
		<div class="para">
		<h2>Project Description</h2>
		<p>
			Our project is a database with the intended function of keeping track of the events in the pokemon television show in terms of what happens with the characters and pokemon. We based our data on the events of the first season of the show which takes place in the Kanto region and has 82 episodes. We represented the events in the show by creating tables for the things we would like to keep track of, for example the pokemon, the characters, who battles who, etc. As we built our project we had to add certain tables in order for everything to work properly together such as PokemonIsOfInstance which allows us to have multiple instances of the same pokemon. We mostly stuck to the idea we had at the start of the project although we have had to make a couple of adjustments along the way. Now that we’ve completed our project it’s safe to say that we’ve completed our goal. If we were to continue watching the show and entering the data episode by episode we would easily be able to query our database at the end of the show in order to keep track of everything that happens throughout the entire show. We would easily be able to tell anyone interesting facts such as every pokemon that Ash catches throughout the show or how many battles there are in total.
		</p>
		<h2>Useful Links</h2>
		<p class="link" > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a target="_blank" href="https://github.students.cs.ubc.ca/CPSC304-2022W-T1/project_h3z2b_k4k3b_k7j3b">Project Github Page</a></p>
		<p class="link" > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://304-project.tiiny.site/" target="_blank">Final Project Report</a></p>
		<H2>Citations</H2>
		<ul>
			<li>The general structure of most .php files is inspired by the oracle-test.php file provided for CPSC 304 Tutorial 7. In particular, the following methods feature code from oracle-test.php:</li>
			<ul>
				<li>debugAlertMessage( )</li>
				<li>executePlainSQL( )</li>
				<li>executeBoundSQL( )</li>
				<li>connectToDB( )</li>
				<li>disconnectFromDB( )</li>
				<li>handle[SQL-statement]Request( )</li>
				<li>handlePostRequest( )</li>
				<li>printResult( )</li>
				<li>handleGetRequest( )</li>
			</ul>
			<li>Bootstrap was used throughout the project for HTML and CSS</li>
		</ul>
		</div>
		
		<?php
			if ($c=oci_connect("ora_woxtoby", "a24563199", "dbhost.students.cs.ubc.ca:1522/stu")) {
				echo "<p class='success'>Successfully connected to Oracle.</p>\n";
				oci_close($c);
			} else {
				$err = oci_error();
				echo "<p class='fail'>Oracle Connect Error " . $err['message'];
			}
		?>
		<!--From https://www.bootstrapdash.com/blog/use-bootstrap-with-php-->
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	</body>
</html>
