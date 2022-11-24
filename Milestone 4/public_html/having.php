<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-default">
        <div class="container-fluid">
    		<div class="navbar-header">
      			<a class="navbar-brand" href="./home.php">Pokemon Database</a>
    		</div>
    		<ul class="nav navbar-nav">
				<li><a href="./home.php">Home</a></li>
				<li><a href="./insert.php">INSERT</a></li>
				<li><a href="./delete.php">DELETE</a></li>
				<li><a href="./update.php">UPDATE</a></li>
				<li><a href="./selection.php">SELECTION</a></li>
				<li><a href="./projection.php">PROJECTION</a></li>
				<li><a href="./join.php">JOIN</a></li>
				<li><a href="./division.php">DIVISION</a></li>
				<li class="dropdown active">
					<a class="dropdown-toggle" data-toggle="dropdown" href="#">AGGREGATION<span class="caret"></span></a>
					<ul class="dropdown-menu">
					<li><a href="./group_by.php">GROUP BY</a></li>
					<li class="active"><a href="./having.php">HAVING</a></li>
					<li><a href="./nested.php">NESTED - GROUP BY</a></li>
					</ul>
				</li>
    		</ul>
        </div>
    </nav>
    <form action="./having.php" method="GET">
        <div class="form-group">
			<h3>Select Type Names where > 20 pokemon have type</h3>
			<p>SELECT TName, Count(Tname)<br>
				FROM isType <br>
				GROUP BY TName <br>
				HAVING COUNT(TName) > 20; <br>
			</p>
			<input type="hidden" id="getTableRequest" name="getTableRequest">
            <input type="submit" value="getTable" name="getTable">
        </div>
    </form>
	<?php
		$success = true;
		$db_conn = NULL;
		function debugAlertMessage($message) {
			global $show_debug_alert_messages;

			if ($show_debug_alert_messages) {
				echo "<script type='text/javascript'>alert('" . $message . "');</script>";
			}
		}

		function executePlainSQL($cmdstr) { //takes a plain (no bound variables) SQL command and executes it
			//echo "<br>running ".$cmdstr."<br>";
			global $db_conn, $success;

			$statement = oci_parse($db_conn, $cmdstr);
			//There are a set of comments at the end of the file that describe some of the OCI specific functions and how they work

			if (!$statement) {
				echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
				$e = OCI_Error($db_conn); // For OCIParse errors pass the connection handle
				echo htmlentities($e['message']);
				$success = False;
			}

			$r = oci_execute($statement, OCI_DEFAULT);
			if (!$r) {
				echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
				$e = oci_error($statement); // For OCIExecute errors pass the statementhandle
				echo htmlentities($e['message']);
				$success = False;
			}

			return $statement;
		}

		function printResult($result) { //prints results from a select statement
			$listofprojections = ["Id", "Tname"];
			echo "<br>Retrieved data from table isType:<br>";
			echo "<table border=1>";
			echo "<tr>";
			for ($i =0; $i < sizeof($listofprojections); $i++) {
				echo "<th>" . $listofprojections[$i] . "</th>";
			}
			echo "</tr>";

			while ($row = oci_fetch_array($result, OCI_BOTH)) {
				echo "<tr>";
				for ($i = 0; $i < sizeof($listofprojections); $i++) {
					echo "<td>" . $row[$i] . "</td>";
				}
				echo "<tr>";
			}    
			echo "</table>";
		}

		function connectToDB() {
			global $db_conn;
			$db_conn = oci_connect("ora_woxtoby", "a24563199", "dbhost.students.cs.ubc.ca:1522/stu");

			if ($db_conn) {
				debugAlertMessage("Database is Connected");
				return true;
			} else {
				debugAlertMessage("Cannot connect to Database");
				$e = oci_error(); // For OCILogon errors pass no handle
				echo htmlentities($e['message']);
				return false;
			}
		}

		function disconnectFromDB() {
			global $db_conn;

			debugAlertMessage("Disconnect from Database");
			oci_close($db_conn);
		}

		function handlePokemonProjectRequest() {
			global $db_conn;			
			printResult(executePlainSQL("SELECT TName, Count(Tname)
										FROM isType
										GROUP BY TName
										HAVING Count(TName) > 20"));
			oci_commit($db_conn);
		}

		function handleRequest() {
			if (connectToDB()) {
				if (array_key_exists('getTable', $_GET)) {
					handlePokemonProjectRequest();
				}
				disconnectFromDB();
			}
		}

		if (isset($_GET['getTableRequest'])) {
			handleRequest();
		}
	?>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>