<?php
	//will show error if not cooperating
	ini_set('display_errors', 1);
	ini_set('display_startup_errors', 1);
	error_reporting(E_ALL);

	//establishing variables!
	$dbhost = 'localhost';
	$dbuser = 'Takrak';
	$dbpass = 'takrak';

	$conn = new mysqli($dbhost, $dbuser, $dbpass);

	if ($conn->connect_errno){
		echo "Error: Failed to make a MySQL connection,
			  here is why: ". "<br>";
		echo "Errno: " . $conn->connect_errno . "\n";
		echo "Error: " . $conn->connect_error . "\n";
	} else {
		echo "Connected Successfully!" . "<br>";
		echo "YAY!" . "<br>";
	}

	$dblist = "SHOW databases;";
	$result = $conn->query($dblist);
	while ($dbname = $result->fetch_array()){
		echo $dbname['Database'] . "<br>";
	}

	$conn->close();
?>
<h2>Check back soon!</h2>

<!--creating form for details.php-->
<form action="details.php" method="get">
 	<p>Specific Database: <input type="text" name="db_name" /></p>
 	<p><input type="submit" /></p>
</form>
