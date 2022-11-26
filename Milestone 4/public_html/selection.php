<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<style>
		.form {
			margin: 1em;
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
	<h3>Select a table to Select from, then click Next</h3>
	<form method="GET" action="selection.php" class="form">
            <select name="table" class="form-select">
                <option value="Pokemon" selected>Pokemon</option>
                <option value="isType">isType</option>
                <option value="Attack">Attack</option>
            </select> <br>

            <input type="hidden" id="postTableRequest" name="postTableRequest">
            <input type="submit" value="Next" name="postTable" class="form btn btn-primary">
	</form>
	<?php
            function handleDisplayNextOptions($table) {
                if ($table == "Pokemon") {
                    header("Location: https://www.students.cs.ubc.ca/~woxtoby/pokemon-selection.php");
                } else if ($table == "isType") {
                    header("Location: https://www.students.cs.ubc.ca/~woxtoby/isType-selection.php");
                } else {
                    header("Location: https://www.students.cs.ubc.ca/~woxtoby/attack-selection.php");
                }
            }

            if (isset($_GET['postTableRequest'])) {
                handleDisplayNextOptions($_GET['table']);
            }
        ?>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>