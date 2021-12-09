
<?php 
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);

    echo htmlspecialchars($_GET['db_name']) . '<br>'; 

    $dbhost = 'localhost';
    $dbuser = 'Takrak';
    $dbpass = 'takrak';
    $dbdb = $_GET['db_name'];
    $conn = new mysqli($dbhost, $dbuser, $dbpass, $dbdb);

    //checks to see if it connects
    if ($conn->connect_errno){
		echo "Error: Failed to make a MySQL connection,
			  here is why: ". "<br>";
		echo "Errno: " . $conn->connect_errno . "\n";
		echo "Error: " . $conn->connect_error . "\n";
	} else {
		echo "Connected Successfully!" . "<br>";
		echo "YAY!" . "<br>";
	}

    //need to make rows and cols
    $tablelist = "SHOW tables;";
    $result = $conn->query($tablelist);
    $tb = "";
	while ($tbname = $result->fetch_array()){    //need to categorize it/it is a 2D array
        //echo "testing fetch array" . "<br>";
        //it grabs one array here so need to check the list once
        for ($x = 0; $x < 1; $x++){ 
            //echo "testing x= $x" . "<br>";
            $len = strlen($tbname[$x]);?>
            <?php echo $tbname[$x]; ?> 
            <br>
            <?php //echo "the length is $len" . "<br>";

            /*//checking how many arrays in the y pos
            for($y = 0; $y<$len; $y++){
                $tb = $tb . $tbname[$x][$y];
                //echo "testing if y= $y exists" . "<br>";
            } 
            //echo the table name and reset the $tb value
            echo $tb . "<br>";
            $tb = ""; */
        }
	}

    $conn->close();
?>