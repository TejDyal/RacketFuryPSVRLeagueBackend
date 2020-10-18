<?php

if (isset($_POST['loginBtn'])) {
    $loginEmail = filter_var($_POST['loginEmail'], FILTER_SANITIZE_EMAIL);

    $_SESSION['loginEmail'] = $loginEmail;
    $loginPwd = md5($_POST['loginPwd']);
    //echo $loginEmail;
    //echo $loginPwd;

    $queryResult = mysqli_query($conn, "SELECT * FROM player where Email = '$loginEmail' AND pwd = '$loginPwd'");
    //print_r($queryResult);
    $checkLoginQuery = mysqli_num_rows($queryResult);
    //echo $checkLoginQuery;

    if($checkLoginQuery == 1) {
        $row = mysqli_fetch_array($queryResult);
        $username = $row['PSN_id'];

        $_SESSION['username'] = $username;
        header("Location: ..\index.php");
        exit();
    }
    else {
        array_push($errorArray, "Email or password is incorrect<br>");
    }
    
}
