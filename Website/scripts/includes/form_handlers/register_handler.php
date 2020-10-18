<?php

//declaring variables to prevent errors and hacking
$psn = $email = $confirmEmail = $enterLeague = $password = $confirmPwd = $dateOfReg = "";
$errorArray = array();
$serverNames = array();

//fetch Racket Fury server list from db to show on form
$result = mysqli_query($conn, "SELECT Server_id, serverName FROM server");
if (mysqli_num_rows($result) > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
        array_push($serverNames, $row["serverName"]);
    }
}


//validating inputs on form and prepping the values before sending to DB
if (isset($_POST['regBtn'])) {

    $psn = strip_tags($_POST['psn']);
    $psn = str_replace(' ', '', $psn);

    // According to Playstation site, Each Online ID must contain between three and 16 characters, and can consist of letters, numbers, hyphens (-) and underscores (_).
    $psnCheck = mysqli_query($conn, "SELECT PSN_id FROM player WHERE PSN_id = '$psn'");
    $numRows = mysqli_num_rows($psnCheck);

    if ($numRows > 0) {
        array_push($errorArray, "this PSN ID aready exists<br>");
    } else 
    if (preg_match("/[^a-zA-Z0-9\-_]/", $psn) || strlen($psn) < 3 || strlen($psn) > 16) {
        array_push($errorArray, "Invalid PSN ID<br>");
    }


    $serverNameSelected = $_POST['server'];

    if ($_POST['email'] != null) {
        $email = $_POST['email'];
        $confirmEmail = $_POST['confirmEmail'];

        if ($email == $confirmEmail) {
            if (filter_var($email, FILTER_VALIDATE_EMAIL)) {

                $emailCheck = mysqli_query($conn, "SELECT Email FROM player WHERE Email = '$email'");
                $numRows = mysqli_num_rows($emailCheck);

                if ($numRows > 0) {
                    array_push($errorArray, "this email aready exists<br>");
                } else {
                    $email = filter_var($email, FILTER_VALIDATE_EMAIL);
                }
            } else {
                array_push($errorArray, "email is not a valid email format<br>");
            }
        } else {
            array_push($errorArray, "emails don't match<br>");
        }
    }




    $enterLeague = $_POST['enterLeague'];

    $selfRatingStr = $_POST['selfRating'];
    switch ($selfRatingStr) {
        case "Good":
            $selfRating = 1;
            break;
        case "Average":
            $selfRating = 2;
            break;
        case "Beginner":
            $selfRating = 3;
            break;
        default:
            $selfRating = 2;
    }


    $password = strip_tags($_POST['password']);
    $confirmPwd = strip_tags($_POST['confirmPwd']);

    if ($password != $confirmPwd) {
        array_push($errorArray, "passwords don't match<br>");
    } else {
        if (preg_match("/[^a-zA-Z0-9]/", $password)) {
            array_push($errorArray, "password can only contain English characters or numbers<br>");
        } else {
            if (strlen($password) < 5 || strlen($password) > 25) {
                array_push($errorArray, "password length must be between 5 and 25 characters<br>");
            }
        }
    }


    // on no errors after sbmitting form, prep other information before sending to DB
    if (empty($errorArray)) {

        $dateOfReg = date("Y-m-d");

        //encrypt password
        $password = md5($password);

        // assign a default profile pic
        do {
            $pics = scandir("assets/images/profile_pics/defaults/");
            $rand = rand(2, count($pics) - 1);
            $profilePic = $pics[$rand];
        } while (!preg_match("/\.png$/i", $profilePic));

        //match server id rom DB for the servername selected
        $result = mysqli_query($conn, "SELECT Server_id FROM server WHERE serverName = ('$serverNameSelected')");
        $row = mysqli_fetch_assoc($result);
        $serverId = $row["Server_id"];

        //submit form data to DB
        if (preg_match("/[@]/", $email)) {
            $result = mysqli_query($conn, "INSERT INTO player (`PSN_id`, `Email`, `activeInLeague`, `enterInNextLeague`, `selfRating`, `Server_id`, `dateRegistered`, `pwd`, `profilePic`) VALUES ('$psn','$email', '0', '$enterLeague', '$selfRating', '$serverId', '$dateOfReg', '$password', '$profilePic')");
        } else {
            $result = mysqli_query($conn, "INSERT INTO player (`PSN_id`, `activeInLeague`, `enterInNextLeague`, `selfRating`, `Server_id`, `dateRegistered`, `pwd`, `profilePic`) VALUES ('$psn', '0', '$enterLeague', '$selfRating', '$serverId', '$dateOfReg', '$password', '$profilePic')");
        }


        /*  if (!$result) {
            print_r(mysqli_error_list($conn));
        } else {
            echo "Success";
        } */

        if ($enterLeague == 1) {
            if (preg_match("/[@]/", $email)) {
                array_push($errorArray, "<span style = 'color: #F54E05'>Registration complete! You have been entered into next league and will be notified of your division and league commencement within two days before it starts</span><br>");
            } else {
                // TODO  Debug why this part is never executed

                array_push($errorArray, "<span style = 'color: #F54E05'>Registration complete! You have been entered into next league.  As you have not given an email address, please check back within two days of the league starting to see the players in your divison and arrange league matches with them. Or update your profile anytime before then to add your email address. </span><br>");
                echo "enter next league but no email";
            }
        } else {
            array_push($errorArray, "<span style = 'color: #F54E05'>Registration complete! You selected not to be entered into next league but you can change your mind anytime upto three days before it starts.  In the meantime, you can arrange friendly matches with players on this site's database</span><br>");
        }
        echo $errorArray[0];

        //reset all variables
        $vars = array_keys(get_defined_vars());
        foreach ($vars as $var) {
            unset(${"$var"});
        }

        header("Location: ../index.php");
        exit;
    }
}
