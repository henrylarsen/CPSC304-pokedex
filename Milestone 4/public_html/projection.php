<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <style>
		.myform {
			margin: 1em;
		}
		#myCheck {
			margin: 0.5em;
		}
        .btn {
            margin-top: 1em;
        }
	</style>
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
				<li class="active"><a href="./projection.php">PROJECTION</a></li>
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
    <form method="GET" action="./projection.php" class="myform" >
        <h3>Select which attributes you would like to project from the Pokemon table</h3>
        <div id="myId">
            <input type="checkbox" id="myCheck" name="id" value="id-value">ID<br>
            <input type="checkbox" id="myCheck" name="name" value="name-value">Name<br>
            <input type="checkbox" id="myCheck" name="height" value="height-value">Height<br>
            <input type="checkbox" id="myCheck" name="weight" value="weight-value">Weight<br>
            <input type="checkbox" id="myCheck" name="size" value="size-value">Size<br>

            <input type="hidden" id="getPokemonRequest" name="getPokemonRequest" class="">
            <input type="submit" value="Project Pokemon" name="getPokemon" class="btn btn-primary">
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
                $listofprojections = getListofProjections();
                echo "<br>Retrieved data from table Pokemon:<br>";
                echo "<table class='table table-hover'>";
                echo "<tr>";
                for ($i =0; $i < sizeof($listofprojections); $i++) {
                    echo "<th>" . $listofprojections[$i] . "</th>";
                }
                echo "</tr>";
                echo "<tbody class='table-group-divider'>";
                while ($row = oci_fetch_array($result, OCI_BOTH)) {
                    echo "<tr>";
                    for ($i = 0; $i < sizeof($listofprojections); $i++) {
                        echo "<td>" . $row[$listofprojections[$i]] . "</td>";
                    }
                    echo "<tr>";
                }   
                echo "</tbody>"; 
                echo "</table>";
            }

            function connectToDB() {
                global $db_conn;
    
                // Your username is ora_(CWL_ID) and the password is a(student number). For example,
                // ora_platypus is the username and a12345678 is the password.
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

            function handleProjectRequest($query) {
                global $db_conn;
        
                $result = executePlainSQL($query);
                printResult($result);
            }

            function handleGETRequest($query) {
                if (connectToDB()) {
                    if (array_key_exists('getPokemon', $_GET)) {
                        handleProjectRequest($query);
                    }
    
                    disconnectFromDB();
                }
            }

            function getListofProjections() {
                $listOfProjections = [];
                    if (isset($_GET['id'])) {
                        array_push($listOfProjections, "ID");
                    }
                    if (isset($_GET['name'])) {
                        array_push($listOfProjections, "PNAME");
                    }
                    if (isset($_GET['height'])) {
                        array_push($listOfProjections, "HEIGHT");
                    }
                    if (isset($_GET['weight'])) {
                        array_push($listOfProjections, "WEIGHT");
                    }
                    if (isset($_GET['size'])) {
                        array_push($listOfProjections, "PSIZE");
                    }
                return $listOfProjections;
            }

            function makeQuery() {
                
                $listOfProjections = getListofProjections();
                $query = "";

                for ($i = 0; $i < sizeof($listOfProjections); $i++) {
                    if ($i == sizeof($listOfProjections) - 1) {
                        $query = $query . $listOfProjections[$i];
                    } else {
                        $query = $query . $listOfProjections[$i] . ", ";
                    }
                }
                print "<br>";
                print "<p> Executing <mark> SELECT " . $query . " FROM Pokemon</mark>  </p>";
                $query = "SELECT " . $query . " FROM Pokemon";
                return $query;
            }

            if (isset($_GET['getPokemonRequest'])) {
                handleGETRequest(makeQuery());
            }
        ?>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>