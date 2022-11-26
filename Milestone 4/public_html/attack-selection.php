<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <style>
        .form {
            margin: 3rem;
        }
        #myCheck {
			margin: 0.5em;
		}
        #var1 {
            width: 75px;
        }
        .btn {
            margin: 1rem;
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
				<li class="active"><a href="./selection.php">SELECTION</a></li>
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
	<h3>Now select the attributes and compartors: </h3>
	<form method="GET" action="attack-selection.php" class="form">
		<div class="form-check">
            <h4>Which attributes would you like to project?</h4>
            <input type="checkbox" class="form-check-input" id="myCheck" name="attackname" value="attackname-value">Attack Name<br>
            <input type="checkbox" class="form-check-input" name="type" id="myCheck" value="type-value">Type<br>
            <input type="checkbox" class="form-check-input" name="damage" id="myCheck" value="damage-value">Damage<br>
            <hr>
            <h4>Now select which attributes will be compared, and what the selection conditions should be</h4>
            <p>WHERE  Field1 Opp1 Var1 OR Field2 Opp2 Var2</p>
            WHERE <select name="field-1" value="field-1">
                <option value="attackname" selected>Attack Name</option>
                <option value="type">Type</option>
                <option value="damage">Damage</option>
            </select>
            <select name="opp-1" value="opp-1">
                <option value="=">=</option>
                <option value=">">></option>
                <option value="<"><</option>
                <option value="<>"><></option>
            </select>
            <input type="text" name="var-1-text" placeholder="Var1" id="var1"> OR 
            <select name="field-2" value="field-2">
                <option value="attackname">Attack Name</option>
                <option value="type">Type</option>
                <option value="damage" selected >Damage</option>
            </select>
            <select name="opp-2" value="opp-2">
                <option value=">">></option>
                <option value="=" selected>=</option>
                <option value="<"><</option>
                <option value="<>"><></option>
            </select> <input type="text" name="var-2-text" placeholder="Var2" id="var1"> <br>

            <input type="hidden" id="getTableRequest" name="getTableRequest">
            <input type="submit" value="getTable" name="getTable" class="btn btn-primary">
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

        function getListofProjections() {
            $listOfProjections = [];
                if (isset($_GET['attackname'])) {
                    array_push($listOfProjections, "AttackName");
                }
                if (isset($_GET['type'])) {
                    array_push($listOfProjections, "Type");
                }
                if (isset($_GET['damage'])) {
                    array_push($listOfProjections, "Damage");
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
            return $query;
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
            echo "<br>Retrieved data from table isType:<br>";
            echo "<table class='table table-hover'>";
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

        function handleRequest($query) {
            if (connectToDB()) {
                if (array_key_exists('getTable', $_GET)) {
                    handlePokemonProjectRequest($query);
                }
                disconnectFromDB();
            }
        }

        function handlePokemonProjectRequest($query) {
            global $db_conn;

            $field_1_text = "";
            if ($_GET['field-1'] == "damage") {
                $field_1_text = strval($_GET['var-1-text']);
            } else {
                $field_1_text = "'".$_GET['var-1-text']."'";
            }

            $field_2_text = "";
            if ($_GET['field-2'] == "damage") {
                $field_2_text = strval($_GET['var-2-text']);
            } else {
                $field_2_text = "'".$_GET['var-2-text']."'";
            }

            $bind1 = $_GET['field-1'];
            $bind2 = $_GET['opp-1'];
            $bind3 = $field_1_text;

            $bind4 = $_GET['field-2'];
            $bind5 = $_GET['opp-2'];
            $bind6 = $field_2_text;


            echo "<p class='form'>Executing <mark>SELECT " . $query . " FROM Attack WHERE ". $bind1 . " " . $bind2 . " " . $bind3 ." OR ". $bind4 ." " . $bind5 . " ". $bind6 ."</mark></p>";
            printResult(executePlainSQL("SELECT " . $query . " FROM Attack WHERE ". $bind1 . " " . $bind2 . " " . $bind3 ." OR ". $bind4 ." " . $bind5 . " ". $bind6));
            oci_commit($db_conn);
        }

        if (isset($_GET['getTableRequest'])) {
            handleRequest(makeQuery());
        }
    ?>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>