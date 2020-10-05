<?php
    $header = "Resgiter into the Players Database";
    include ("../scripts/includes/head.php");
    include ("../scripts/includes/nav_links.html");

    require '../scripts/config/config.php';
    require '../scripts/includes/form_handlers/register_handler.php';
    require '../scripts/includes/form_handlers/login_handler.php';
?>

<body>
    <!-- Login Form -->
    <form action="register.php" method="POST">
        <div class="box logina" id="loginEmail">
            <label for="loginEmail">Email:</label>
            <input type="email" name="loginEmail" placeholder="Email address" value = "<?php 
                if(isset($_SESSION['loginEmail'])) {
                    echo $_SESSION['loginEmail'];
                } ?>" required>
        </div>

        <div class="box loginb" id="loginPwd">
            <label for="loginPwd">Password:</label>
            <input type="password" name="loginPwd" placeholder="Password" required>
        </div>

        <div class="box logc" id="loginSubmit">
            <input type="submit" name="loginBtn" value="Log In">
        </div>

        <?php
            if(in_array("Email or password is incorrect<br>", $errorArray)) {
                echo "Email or password is incorrect<br>";
            }
        ?>
    </form>

    <!-- Registration Form -->
    <form action="register.php" method="POST">
        <div class="box rega"><label for="psn">What is your PSN ID?</label>
            <input type="text" name="psn" value="<?php echo $psn ?>" required>
            <?php
            if (in_array("Invalid PSN ID<br>", $errorArray)) echo "Invalid PSN ID<br>";
            else if (in_array("this PSN ID aready exists<br>", $errorArray)) echo "this PSN ID aready exists<br>"
            ?>
            <!-- TODO: need code here to test if player already exists on db (DONE), and if so, test if has a login. If no login, then continue with form.  If user has a login then go to login form. (Login form yet to be implemented) -->
        </div>

        <!-- this is a dropdown select list cycles through the servers list array -->
        <div class="box regb" id="serverSelect">
            <label for="server">Select your local server:</label>
            <select name="server" required>
                <?php
                foreach ($serverNames as $server) {
                ?>
                    <option value="<?php echo $server; ?>" <?php if (isset($_POST['server']) && $_POST['server'] == $server)
                                                                echo 'selected= "selected"' ?>><?php echo $server; ?> </option>
                <?php
                }
                ?>
            </select>
        </div>

        <div class="box regc" id="email">
            <label for="email">Your email address (optional but recommended)</label>
            <input type="email" name="email" placeholder="Email address (optional)" value="<?php echo $email ?>">
        </div>

        <div class="box regd" id="confirmEmail">
            <label for="confirmEmail">Confirm your email</label>
            <input type="email" name="confirmEmail" placeholder="Confirm Email" value="<?php echo $confirmEmail ?>">
            <?php
            if (in_array("this email aready exists<br>", $errorArray)) echo "this email aready exists<br>";
            else if (in_array("email is not a valid email format<br>", $errorArray)) echo "email is not a valid email format<br>";
            else if (in_array("emails don't match<br>", $errorArray)) echo "emails don't match<br>";
            ?>
        </div>

        <div class="box rege" id="enterLeague">
            <label for="enterLeague">Would you like to enter yourself into next season's league? </label>
            <select name="enterLeague" required>
                <option value=1 <?php if (isset($_POST['enterLeague']) && $_POST['enterLeague'] == 1)
                                    echo 'selected= "selected"' ?>>Yes please!</option>
                <option value=0 <?php if (isset($_POST['enterLeague']) && $_POST['enterLeague'] == 0)
                                    echo 'selected= "selected"' ?>>Not right now, but maybe later!</option>
            </select>
        </div>

        <div class="box regf" id="selfRating">
            <label for="selfRating">How do you rate your playing ability?</label>
            <select name="selfRating" required>
                <option value="Beginner" <?php if (isset($_POST['selfRating']) && $_POST['selfRating'] == 'Beginner')
                                                echo 'selected= "selected"' ?>>Beginner!</option>
                <option value="Average" <?php if (isset($_POST['selfRating']) && $_POST['selfRating'] == 'Average')
                                            echo 'selected= "selected"' ?>>Average</option>
                <option value="Good" <?php if (isset($_POST['selfRating']) && $_POST['selfRating'] == 'Good')
                                            echo 'selected= "selected"' ?>>Good</option>


            </select>
        </div>

        <div class="box regg" id="password">
            <label for="password">Create a password</label>
            <input type="password" name="password" required>
        </div>

        <div class="box regh" id="confirmPwd">
            <label for="confirmPwd">Confirm your new password</label>
            <input type="password" name="confirmPwd" required>
            <?php
            if (in_array("passwords don't match<br>", $errorArray)) echo "passwords don't match<br>";
            else if (in_array("password can only contain English characters or numbers<br>", $errorArray)) echo "password can only contain English characters or numbers<br>";
            else if (in_array("password length must be between 5 and 25 characters<br>", $errorArray)) echo "password length must be between 5 and 25 characters<br>";
            ?>
        </div>

        <div class="box regi" id="submit">
            <label for="submit">Submit Form</label>
            <input type="submit" name="regBtn" value="register">
        </div>

    </form>


</body>

</html>