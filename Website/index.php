<?php
    $header = "Racket Fury PSVR Box Leagues";
    include ("scripts/includes/head.php");
    include ("scripts/config/config.php");
?>

<body>
    <div class=wrapper>
        <div class="box headerbar" id="headerGradient">
            <div class="box b" id="logo"><img src="images/logo.png" alt="">
            </div> 
            <div class="box c" id="headerText">Racket Fury PSVR Leagues & Friendlies
            </div>
            <div class="box d" id="subHeaderText">A non-profit community website for players
                        of Racket Fury VR on Playstation VR
            </div>                       
        </div>
        
        <div class="box navbar" id="navbarGradient">
            <?php
                include ("scripts/includes/nav_links.html");
            ?>            
            <div class="box f">
                Sign In/Out
            </div>
        </div>

        <div class="box g" id="welcomeText">
            <div class="box h" id="welcomeHeader">
                    <?php
                        $myfile = fopen("text_blocks/welcome_heading.txt", "r") or die("Unable to open file!");
                        echo fread($myfile,filesize("text_blocks/welcome_heading.txt"));
                        fclose($myfile);
                    ?> 
            </div>
            <div class="box i" id="welcomeBody">
                    <?php
                        $myfile = fopen("text_blocks/welcome_body.txt", "r") or die("Unable to open file!");
                        echo fread($myfile,filesize("text_blocks/welcome_body.txt"));
                        fclose($myfile);
                    ?> 
            </div>
        </div>

        <div class="box j" id="newsGradient">
            <div class="box m" id="winnersHeader">
                <br>Last Season<br>Winners!
            </div>
            <div class="box n" id="winnersBody">congratulations to all winners of their divisions!</div>
            <div class="box o" id="winners">
                    <?php
                        include("scripts\includes\connect_db.php");
                        include("scripts\includes\winners.php");
                    ?> 
            </div>
        </div>
        

        <div class="box p" id="reg">          
            <button class="bigButton" type="button" id="regBtn" 
                onclick="document.location.href='scripts/includes/form_handlers/register_handler.php'">
                    <span class="buttonHeading">Register</span><br>
                    <span class="buttonSubText">to play in Leagues<br>and receive updates</span><br><br>
                    <span class="buttonFooterText">(PSN ID, Country server and<br>Email address required)</span>
            </button>
        </div>

        <div class="box q" id="login">          
            <button class="bigButton" type="button" id="loginBtn" 
                onclick="document.location.href='scripts/includes/form_handlers/login_handler.php'">                    
                    <span class="buttonSubText">Already registered?</span><br>
                    <span class="buttonHeading">Sign In</span>
            </button>
        </div>        

        <div class="box r"><br>Not Ready to register yet? No problem</div>

        <div class="box s" id="playerDb">          
            <button class="bigButton" type="button" id="playerDbBtn" 
                onclick="document.location.href='pages/playersDB.php'">
                    <span class="buttonHeading">Find</span><br>
                    <span class="buttonHeading">Players</span>
            </button>
        </div>     

        <div class="box t"><br>Latest global league match results</div>

        <!-- TODO use javascript to make number of rows dynamic -->
        <div class="box u">
                    <span class="tableHeader h1">Date</span>
                    <span class="tableHeader h2">Server</span>
                    <span class="tableHeader h3">Season</span>
                    <span class="tableHeader h4">Div</span>
                    <span class="tableHeader h5">Players</span>
                    <span class="tableHeader h6">Score</span>
                
                <?php
                    include("scripts\includes\connect_db.php");
                    include("scripts\includes\latest_match_results.php");
                ?>
        </div>
    </div>
</body>
</html>