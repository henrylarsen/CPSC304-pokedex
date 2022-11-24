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
				<li class="active"><a href="./update.php">UPDATE</a></li>
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
    <form method="POST" action="update.php">
		ID: <input type="text" name="id" value=""><br>
		<hr>
		Name: <input type="text" name="name" value=""><br>
		Height: <input type="text" name="height" value=""><br>
		Weight: <input type="text" name="weight" value=""><br>
		Size: <input type="text" name="size" value=""><br>
		<input type="hidden" id="postPokemonRequest" name="postPokemonRequest">
		<input type="submit" value="postPokemon" name="postPokemon">
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

            function executeBoundSQL($cmdstr, $list) {
				global $db_conn, $success;
				$statement = oci_parse($db_conn, $cmdstr);
	
				if (!$statement) {
					echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
					$e = OCI_Error($db_conn);
					echo htmlentities($e['message']);
					$success = False;
				}
	
				foreach ($list as $tuple) {
					foreach ($tuple as $bind => $val) {
						// echo $val;
						// echo "<br>".$bind."<br>";
						oci_bind_by_name($statement, $bind, $val);
						unset ($val); //make sure you do not remove this. Otherwise $val will remain in an array object wrapper which will not be recognized by Oracle as a proper datatype
					}
	
					$r = oci_execute($statement, OCI_DEFAULT);
					if (!$r) {
						echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
						$e = OCI_Error($statement); // For OCIExecute errors, pass the statementhandle
						echo htmlentities($e['message']);
						echo "<br>";
						$success = False;
					}
				}
			}

            function connectToDB() {
                global $db_conn;
                $db_conn = oci_connect("ora_woxtoby", "a24563199", "dbhost.students.cs.ubc.ca:1522/stu");
    
                if ($db_conn) {
                    debugAlertMessage("Database is Connected");
                    return true;
                } else {
                    debugAlertMessage("Cannot connect to Database");
                    $e = oci_error();
                    echo htmlentities($e['message']);
                    return false;
                }
            }

            function disconnectFromDB() {
                global $db_conn;
    
                debugAlertMessage("Disconnect from Database");
                oci_close($db_conn);
            }

			function createSet() {
				$set = "";
				$listOfSets = [];
				if ($_POST['name'] != "") {
					array_push($listOfSets, "pname = :bind1");
				}
				if ($_POST['height'] != "") {
					array_push($listOfSets, "height = :bind2");
				}
				if ($_POST['weight'] != "") {
					array_push($listOfSets, "weight = :bind3");
				}
				if ($_POST['size'] != "") {
					array_push($listOfSets, "psize = :bind4");
				}
				for ($i = 0; $i < sizeof($listOfSets); $i++) {
                    if ($i == sizeof($listOfSets) - 1) {
                        $set = $set . $listOfSets[$i];
                    } else {
                        $set = $set . $listOfSets[$i] . ", ";
                    }
                }
				return $set;
			}

            function handleUpdateRequest() {
				global $db_conn;
	
				//Getting the values from user and insert data into the table
				$tuple = array (
					":bind1" => $_POST['name'],
					":bind2" => number_format($_POST['height']),
					":bind3" => number_format($_POST['weight']),
					":bind4" => $_POST['size'],
					":bind5" => number_format($_POST['id'])
				);
	
				$alltuples = array (
					$tuple
				);

				$set = createSet();

				executeBoundSQL("update Pokemon set ". $set . " where id= :bind5", $alltuples);
				oci_commit($db_conn);
			}

			function handlePostRequest() {
                if (connectToDB()) {
                    if (array_key_exists('postPokemon', $_POST)) {
                        handleUpdateRequest();
                    }
    
                    disconnectFromDB();
                }
            }

            if (isset($_POST['postPokemonRequest'])) {
                handlePostRequest();
            }
        ?>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>