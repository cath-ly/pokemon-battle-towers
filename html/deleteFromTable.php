<?php
	//will show error if not cooperating
	ini_set('display_errors', 1);
	ini_set('display_startup_errors', 1);
	error_reporting(E_ALL);

	//establishing variables!
	$dbhost = 'localhost';
	$dbuser = 'Takrak';
	$dbpass = 'takrak';
    //using db
    $database = 'instrument_rentals';

    $conn = new mysqli($dbhost, $dbuser, $dbpass, $database);

    if ($conn->connect_errno){
		echo "Error: Failed to make a MySQL connection,
			  here is why: ". "<br>";
		echo "Errno: " . $conn->connect_errno . "\n";
		echo "Error: " . $conn->connect_error . "\n";
	} else {
		echo "Connected Successfully!" . "<br>";
		echo "YAY!" . "<br>";
	}
    $insert = "INSERT INTO instruments (instrument_type) 
                    VALUES ('Guitar'),
                            ('Trumpet'),
                            ('Flute'),
                            ('Theremin'),
                            ('Violin'),
                            ('Tuba'),
                            ('Melodica'),
                            ('Trombone'),
                            ('Keyboard');";
    if(array_key_exists('insert_ins', $_POST)){
        $result = $conn->query($insert);
    }
    //$insert = $conn->query($query);
    
    //$del_stmt->execute();

    //pops the SQL query
    $query = "SELECT * FROM instruments;";
    $result = $conn->query($query);
    if(!$result){
        echo "query failed";
    }
    $rows = $result->fetch_all();
    $tot_row = $result->num_rows;
    $del_stmt = $conn->prepare("DELETE FROM instruments WHERE instrument_id = ?;"); 
    $del_stmt->bind_param('i', $id);
    for($i=0; $i<$tot_row; $i++){
        $id = $rows[$i][0];
        if (isset($_POST["checkbox$id"]) && !$del_stmt->execute()){
            echo $conn->error;
        }
    }

    $result = $conn -> query($query);

    function result_to_deletable_table($result){ 
        //$fields = $result->fetch_fields();
        $rows = $result->fetch_all();
        $tot_row = $result->num_rows;
        $tot_col = $result->field_count;
        //2D array of the instruments!
        ?>

        <?php echo $tot_row; ?> <br>
        <?php echo $tot_col; ?> <br>
        <p>
        <form action="deleteFromTable.php" method=POST>
        <table>
            <thead>
            <tr>
                <th> Delete batch? </th>
                <?php while ($field = $result->fetch_field()){ ?>
                    <td> <?php echo $field->name; ?> </td>
                <?php } ?>
            </tr>
            </thead>
            <?php for($x = 0; $x < $tot_row; $x++) { 
                    $id = $rows[$x][0];
                    //echo $id . '<br>';
                ?>
                <tr>
                    <td> <input type="checkbox" 
                                name="checkbox<?php echo $id?>"
                                value=<?php echo $id; ?>
                        /> 
                    </td>
                <?php for($y = 0; $y < $tot_col; $y++){ 
                    //$id = "SELECT instrument_id FROM ..."
                    ?>
                    <td> <?php echo $rows[$x][$y]; ?> </td>
                <?php } ?>
                </tr>
            <?php } ?>
        </table>
        <input type="submit" value="Delete Selected Records" method=POST/>
        </form>
        </p>
    <?php }

    //testing fnc to see if it works
    result_to_deletable_table($result, $conn, $del_stmt, $rows);
    ?>
    <form action="deleteFromTable.php" method=POST>
        <input type="submit" name= "insert_ins" value="Insert Instruments" method=POST/>

    </form>