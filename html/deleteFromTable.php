<html>
    <head>
        <style> <?php include 'basic.css'; ?> </style>
    </head>
    <?php
        //will show error if not cooperating
        ini_set('display_errors', 1);
        ini_set('display_startup_errors', 1);
        error_reporting(E_ALL);

        //was informed that we need header
        //header("Location: {$_SERVER['REQUEST_URI']}", true, 303);

        session_start();            // begin or lookup session for client
        if(isset($_SESSION['username'])){?>
            <p>Welcome <?php echo htmlspecialchars($_SESSION['username']); ?></p>
                <!-- Using default action (this page). -->
            <form method=POST> 
                <input type=submit name=logout value="Logout"/>
            </form>
        <?php }
        else{ ?>
            <p>Remember my session:
                <!-- Using default action (this page). -->
                <form method=POST>
                    <input type=text name=username placeholder='Enter name...'/>
                    <input type=submit value='Remember Me'/>
                </form>
            </p>
        <?php }
        // store a variable in a cookie
        if (!isset($_COOKIE['dark'])){
            $_COOKIE['dark'] = 'false';     // access the value of a cookie
        }
        //check if someone logs in needs to be in if statement loops
        //need to replace form or delete and come up with another method!
        if(array_key_exists('username', $_POST)){
            $_SESSION['username'] = $_POST['username'];  // assign to set new values
            $_SESSION['count'] = 0;
            header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
            exit();
        }
        //session_unset();            // free session variables doesn't this release/logout the info?
        if(array_key_exists('logout', $_POST)){
            $count = 0;
            session_unset();
            header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
            exit();
        }
        
        //establishing variables!
        $dbhost = 'localhost';
        $dbuser = 'Takrak';
        $dbpass = 'takrak';
        //using db
        $database = 'instrument_rentals';

        $config = parse_ini_file('/home/Takrak/mysql.ini');
        $dbname = 'instrument_rentals';
        $conn = new mysqli(
                    $config['mysqli.default_host'],
                    $config['mysqli.default_user'],
                    $config['mysqli.default_pw'],
                    $dbname);

        if ($conn->connect_errno){
            echo "Error: Failed to make a MySQL connection,
                here is why: ". "<br>";
            echo "Errno: " . $conn->connect_errno . "\n";
            echo "Error: " . $conn->connect_error . "\n";
        } else {
            echo "Connected Successfully!" . "<br>";
            echo "YAY!" . "<br>";
        }
        // inserting values when button is clicked
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
        ?>
        <?php
        // want to check what css is on before turning it
        if(array_key_exists('toggle_dark_mode', $_POST)){ 
            if($_COOKIE['dark'] == 'true'){      
        ?>
            <?php setcookie('dark', 'false', 0, '/', '', false, true);
            }
            else{ ?>
                <?php setcookie('dark', 'true', 0, '/', '', false, true);
            }
            header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
            exit();
        }

        //checking if darkmode is on or nah
        if(isset($_COOKIE['dark']) && $_COOKIE['dark'] == 'true'){ ?>
            <link rel = 'stylesheet' href= 'darkmode.css'>
        <?php }

        //pops the SQL query
        $query = "SELECT * FROM instruments;";
        $result = $conn->query($query);
        if(!$result){
            echo "query failed";
        }
        //gather info from fields
        $rows = $result->fetch_all();
        $tot_row = $result->num_rows;
        $del_stmt = $conn->prepare("DELETE FROM instruments WHERE instrument_id = ?;"); 
        $del_stmt->bind_param('i', $id);
        
        //checking if we deleted anything it will use header!
        $delete = false;

        for($i=0; $i<$tot_row; $i++){
            $id = $rows[$i][0];
            //checks to see whether the checkbox is checked if so we will delete
            if (isset($_POST["checkbox$id"]) && !$del_stmt->execute()){
                echo $conn->error;
            }
            if (isset($_POST["checkbox$id"])){
                $delete = true;
                $_SESSION['count'] = $_SESSION['count'] + 1;
            }
        }
        if ($delete == true){
            header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
            exit();
        }

        $result = $conn -> query($query); 
        ?>
        
        <?php
        function result_to_deletable_table($result){ 
            //$fields = $result->fetch_fields();
            $rows = $result->fetch_all();
            $tot_row = $result->num_rows;
            $tot_col = $result->field_count;
            //2D array of the instruments!
            ?>
            <!-- echoes the rows and col in the database -->
            <?php echo $tot_row; ?> <br>
            <?php echo $tot_col; ?> <br>
            <p>
            <!-- Creates a form to delete instruments -->
            <form action="deleteFromTable.php" method=POST>
            <table>
                <thead>
                <tr>
                    <th> Delete batch? </th>
                    <?php while ($field = $result->fetch_field()){ ?>
                        <!-- Prints all the names of field as it iterates through -->
                        <td> <?php echo $field->name; ?> </td>
                    <?php } ?>
                </tr>
                </thead>
                <?php for($x = 0; $x < $tot_row; $x++) { 
                        $id = $rows[$x][0];
                        //echo $id . '<br>';
                    // next establishes the checkbox button to toggle what instruments to delete
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
        <?php  if(isset($_SESSION['count'])){ ?>
            <p>You have deleted <?php echo $_SESSION['count'] ?> records </p>
        <?php }
                else{ ?>
                <p>You have deleted nada.</p>
            <?php } ?>
        <?php }

        //testing fnc to see if it works
        result_to_deletable_table($result, $conn, $del_stmt, $rows);
        ?>
        <!-- adding another button to toggle dark mode -->
        <form method=POST>
            <input type="submit" name="toggle_dark_mode" value="Toggle Light/Dark Mode"/>
        </form>

        <!-- adding another button to insert instruments -->
        <form method=POST>
            <input type="submit" name= "insert_ins" value="Insert Instruments" method=POST/>
        </form>
    </html>