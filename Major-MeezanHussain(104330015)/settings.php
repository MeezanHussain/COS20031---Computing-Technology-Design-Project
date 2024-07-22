<?php
    // Database configuration
    $host = "feenix-mariadb.swin.edu.au";
    $user = "cos20031_56"; 
    $pswd = "HCFEyNZ7ZP"; 
    $dbnm = "cos20031_56_db";

    // Create connection
    $conn = new mysqli($host, $user, $pswd, $dbnm);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
?>
