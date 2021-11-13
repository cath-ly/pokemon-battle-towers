<!-- what type of inserts do we want to allow? -->


<?php 
// start of insert _ table
//will show error if not cooperating
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

//was informed that we need header to not have confirm resend tings
//header("Location: {$_SERVER['REQUEST_URI']}", true, 303);

?>
<p>Select a Table to Insert Values Into:
    <!-- Using default action (this page). -->
    <form method=POST>
        <input type=text name=table placeholder='Enter table...'/>
        <input type=submit value='Select Table'/>
    </form>
</p>

<?php
if(array_key_exists('table', $_POST)){
    //checking if the user is logged in right?
    //have to create session? and then alter data for specific unit?
    //authorization?

    /*
    $config = parse_ini_file('/home/Takrak/mysql.ini');
    $dbname = 'instrument_rentals';
    $conn = new mysqli(
                $config['mysqli.default_host'],
                $config['mysqli.default_user'],
                $config['mysqli.default_pw'],
                $dbname); 
    //$query = ();
    if ($conn->connect_errno){
        echo "Error: Failed to make a MySQL connection,
        here is why: ". "<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
    } else {
        echo "Connected Successfully!" . "<br>";
        echo "YAY!" . "<br>";
    }*/
    header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
    exit();
}
//method is get, prepare statement, bind, and execute
?>