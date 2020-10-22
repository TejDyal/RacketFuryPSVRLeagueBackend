<?php
    mysqli_close($conn);
    $servername = "localhost:3306";
    $username = "Normal User";
    $pwd = "password";
    $db = "rf_league_db";
    $conn = mysqli_connect($servername, $username, $pwd, $db);
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error());
    }
        //     echo "Connected successfully";
?>