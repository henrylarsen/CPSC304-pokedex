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
        <form method="GET" action="og_test.php">
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
                echo "<br>Retrieved data from table Pokemon:<br>";
                echo "<table>";
                echo "<tr><th>ID</th><th>PName</th></tr>";
    
                while ($row = oci_fetch_array($result, OCI_BOTH)) {
                    echo "<tr><td>" . $row["ID"] . "</td><td>" . $row["PNAME"] . "</td></tr>"; //or just use "echo $row[0]"
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

            function handleSelectRequest() {
                global $db_conn;

                $result = executePlainSQL("SELECT * FROM Pokemon");
                printResult($result);
            }

            function handleGETRequest() {
                if (connectToDB()) {
                    if (array_key_exists('getPokemon', $_GET)) {
                        handleSelectRequest();
                    }
    
                    disconnectFromDB();
                }
            }

            if (isset($_GET['getPokemonRequest'])) {
                handleGETRequest();
            }
        ?>
    </body>
</html>