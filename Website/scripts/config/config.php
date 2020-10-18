<?php

// Create connection to db

//TODO find out how to connect to the db without showing the password inside the php code or how to hide the php code from front end user.

ob_start(); //Turns on output buffering...code efficiency practice
session_start();
$timeZone = date_default_timezone_set("UTC");  // players will be arranging matches from different time zones so best maker UTC a reference

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
