<?php
    $header = "Racket Fury PSVR Box Leagues";
    include ("scripts/includes/head.php");
?>

<body>
    <div class=wrapper>
        <div class="box a" id="headerGradient">
            <div class="box b" id="logo"><img src="images/logo.png" alt="">
            </div> 
            <div class="box c" id="headerText">
                <h1 id="mainTitle">Racket Fury PSVR Leagues & Friendlies</h1>
                <br>
            </div>
            <div class="box d" id="subHeaderText">
                <h3 id="subheadingText">A non-profit community website for players
                        of Racket Fury VR on Playstation VR</h3>        
            </div>                       
        </div>
        
        <div class="box e" id="navbarGradient">
            <div class="box f" id="navbarLinks">
                <?php
                    include ("scripts/includes/nav_links.html");
                ?>
            </div>
            <div class="box g">
                Sign In/Out
            </div>
        </div>

        <div class="box h" id="welcomeText">
            <div class="box i" id="welcomeHeader">
                <h2>
                    <?php
                        $myfile = fopen("text_blocks/welcome_heading.txt", "r") or die("Unable to open file!");
                        echo fread($myfile,filesize("text_blocks/welcome_heading.txt"));
                        fclose($myfile);
                    ?> 
                </h2>                
            </div>
            <div class="box j" id="welcomeBody">
                    <?php
                        $myfile = fopen("text_blocks/welcome_body.txt", "r") or die("Unable to open file!");
                        echo fread($myfile,filesize("text_blocks/welcome_body.txt"));
                        fclose($myfile);
                    ?> 
            </div>
        </div>

        <div class="box k" id="newsGradient">
            <div class="box l" id="newsHeader">
                <h2>News</h2>                
            </div>
            <div class="box m" id="newsBody">
                    <?php
                        $myfile = fopen("text_blocks/news_body.txt", "r") or die("Unable to open file!");
                        echo fread($myfile,filesize("text_blocks/news_body.txt"));
                        fclose($myfile);
                    ?> 
            </div>
            <div class="box n" id="winnersHeader">
                <h2>Last Season Winners!</h2>                
            </div>
            <div class="box o" id="winnersBody">congratulations to all winners of their divisions!</div>
            <div class="box p" id="winners">
                    <?php
                        $myfile = fopen("text_blocks/winners.txt", "r") or die("Unable to open file!");
                        echo fread($myfile,filesize("text_blocks/winners.txt"));
                        fclose($myfile);
                    ?> 
            </div>
        </div>
        

        <div class="box q">
            <div id="reg">Regiser your PSN ID and country server to join the leagues</div>
            <button type="button" id="regBtn" onclick="document.location.href='pages/register.php'">Register</button>
        </div>

        <div class="box r">
            <div id="joinLg">Join a division/league</div>
            <button id="joinLgBtn">Join Leagues</button>
        </div>

        <div class="box s">
            <div id="playerDb"> Find a player on your server</div>
            <button id="playerDbBtn">Find player</button>
        </div>

        <div class="box t">
            <div id="lgResults">League Results</div>
            <button id="lgResultsBtn">League Results</button>
        </div>

        <div class="box u">
            <div id="matchResults">Enter your match results</div>
            <button id="matchReslutsBtn">Submit</button>
        </div>

        <div class="box jv">
            <div id="profile">Your Profile and History</div>
            <button id="profileBtn">Profile</button>
        </div>

    </div>





</body>
</html>