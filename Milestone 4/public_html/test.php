<html>
    <body>
        <h2>Test</h2>
        <p>This page exists to test the following query: SELECT * FROM Pokemon</p> <br>
        <p>Before pressing the button below, ensure the following is complete:</p>
        <ul>
            <li>SSH into the server and cd into the correct dir</li>
            <li>Start SQL*</li>
            <li>run    start restart_tables.sql</li>
        </ul>

        <hr />

        <h2>Press this button to execute the query</h2>
        <form method="GET" action="test.php">
            <input type="checkbox" name="id" value="id-value">ID<br>
            <input type="checkbox" name="name" value="name-value">Name<br>
            <input type="checkbox" name="height" value="height-value">Height<br>
            <input type="checkbox" name="weight" value="weight-value">Weight<br>
            <input type="checkbox" name="size" value="size-value">Size<br>

            <input type="hidden" id="getPokemonRequest" name="getPokemonRequest">
            <input type="submit" value="getPokemon" name="getPokemon">
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
                echo "<table border=1>";
                echo "<tr>";
                for ($i =0; $i < sizeof($listofprojections); $i++) {
                    echo "<th>" . $listofprojections[$i] . "</th>";
                }
                echo "</tr>";
    
                while ($row = oci_fetch_array($result, OCI_BOTH)) {
                    echo "<tr>";
                    for ($i = 0; $i < sizeof($listofprojections); $i++) {
                        echo "<td>" . $row[$listofprojections[$i]] . "</td>";
                    }
                    echo "<tr>";
                }    
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
                print "<p>This is the query: SELECT " . $query . " FROM Pokemon  </p>";
                $query = "SELECT " . $query . " FROM Pokemon";
                return $query;
            }

            if (isset($_GET['getPokemonRequest'])) {
                handleGETRequest(makeQuery());
            }
        ?>
    </body>
</html>