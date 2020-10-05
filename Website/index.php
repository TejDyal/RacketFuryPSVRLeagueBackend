<?php
    $header = "Racket Fury PSVR Box Leagues";
    include ("scripts/includes/head.php");
?>

<body>
    <div class=wrapper>
        <?php
            include ("scripts/includes/nav_links.html");
        ?>

        <div class="box b" id="title"> Racket Fury PSVR Box Leagues</div>
        <div class="box c" id="subtitle1">A Racket Fury Non Profit Community Fan Website</div>

        <div class="box d" id="summary">Contact other PSN players to arrange friendly mataches and/or join in
            fortnightly Leagues divided into divisions of up to 7 players each where you play against other of similar
            standard so that you always have the opportunity to win your division, regardless of your standard! </div>

        <div class="box e">
            <div id="reg">Regiser your PSN ID and country server to join the leagues</div>
            <button type="button" id="regBtn" onclick="document.location.href='pages/register.php'">Register</button>
        </div>

        <div class="box f">
            <div id="joinLg">Join a division/league</div>
            <button id="joinLgBtn">Join Leagues</button>
        </div>

        <div class="box g">
            <div id="playerDb"> Find a player on your server</div>
            <button id="playerDbBtn">Find player</button>
        </div>

        <div class="box h">
            <div id="lgResults">League Results</div>
            <button id="lgResultsBtn">League Results</button>
        </div>

        <div class="box i">
            <div id="matchResults">Enter your match results</div>
            <button id="matchReslutsBtn">Submit</button>
        </div>

        <div class="box j">
            <div id="profile">Your Profile and History</div>
            <button id="profileBtn">Profile</button>
        </div>

    </div>





</body>
</html>