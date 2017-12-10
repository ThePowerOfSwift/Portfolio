<?php


$host           = 'localhost';
$username       = 'root';
$password       = 'root';
$db             = 'website_kellogscomau';


    //Create a connection
    $conn = mysqli_connect($host, $username, $password, $db);

//Check Connection
if (!$conn){
    die("Connection Failed" . mysqli_connect_error());
} else {
//    echo "success";
}

?>