<?php
    $header = "Players Database";
    include ("../scripts/includes/head.php");
    include ("../scripts/includes/nav_links.html");
?>

<body>
    <div class=wrapper>
        <div class="box ab" id="aTitle"> Racket Fury PSVR Box Leagues</div>
        <div class="box ac" id="aSubtitle1">A Racket Fury Non Profit Community Fan Website</div>
        <div class="box ad" id="aLeague">
            <form action="/action_page.php">
                <label for="region">Select a region:</label>
                <select name="region" id="region">
                  <option value="europe">Europe</option>
                  <option value="russia">Russia</option>
                  <option value="asia">Asia</option>
                  <option value="america">America</option>
                </select>
              </form>
        </div>        
    </div>
</body>
</html>