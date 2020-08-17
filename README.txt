---------------CONTENTS---------------

ABOUT THE PROJECT
    What is this Project?
    Why is this project needed?
    If there are not many players online, is there enough demand for this project?
    How will this league be made known to Racket Fury PSVR owners?
    How will the leagues work?
    What if a player doesn't want to enter leagues but wants to just arrange friendlies?


CODING IMPLEMENTATION
    Priority features and functions to implement for this project:
    Additional features for future:
    Backend Main Github Files and their description:
    Front End Main Github files and their description:



---------------ABOUT THE PROJECT---------------



---------------What is this project?---------------

This is a non profit, no ads community website passion project for Racket Fury PSVR online PSN players to connect with other online PSVR players and arrange friendly or league matches together.  In addition to providing a database of PSN players, the project also establishes a "Box style" league system, divided into divisions of up to 7 players each, that gives all standard of players an opportunity to enter and become a winner of their own division.  Every season lasts for 3 weeks and a new season starts a few days after.  This gives all players a new fresh start to win in their division.  Aside from the leagues, players can  just utilise the database of players to arrange friendly sessions if they don't wish to enter leagues.  



---------------Why is this project needed?---------------

The virtual reality game, Racket Fury on Playstation VR (PSVR) is arguably the most realistic simulation of playing table tennis with other players online.  When players find a game online, the physical energy exerted is close to playing the real sport and serves as a great fitness activity that has the added incentive of competition. 

However, the game lacks competitive features such as leaderboard, leagues, tournaments and a record of matches played.  There is little incentive for players to play online and it is evident that there is a lack of players going online.  Furthermore, the online play feature was a very late update, that arrived a year after the release of the game. That means many owners are unaware of the online feature. 

The developers of the game are a small team and are no longer focussed on providing updates for the PSVR version at least for the foreseeable future.  They are now focussed, understandably, on the more substantial userbase of the Oculus Quest version.  So this project hopefully fills that gap to serve the RF community

---------------If there are not many players online, is there enough demand for this project?---------------

Likely, there is.  Though how much is an uncertainty.   On the Racket Fury PSN community groups, there are around 60 players who have posted asking for a game with anyone.  There have also been a further 40 players expressing interest on the Reddit PSVR subforum.  The problem with PSN game communities is that Sony Playstation has deactivated the smartphone app PSN community messaging service, so communication can only be done via the PS4 console UI which is not easy to do without a keyboard.   This project aims to deliver an easier communication method without users needing to enter any personal email or comms details.  

However, it is developed by a small team who are now focussed on the more substantial user base of the Oculus Quest.  The and is unlikely to receive version which gets more regular updates and established leaderboard and tournaments.  




---------------How will this league be made known to Racket Fury PSVR owners?---------------

Will post announcement of project going live through 

1. Reddit PSVR subforum
2. AVFoums PSVR forum
3. Message all PSN users on the Racket Fury PSN communities groups.  

A accompanying social media accounts will also be setup.




---------------How will the leagues work?---------------

Each world server (eg Europe, Japan, USA etc) will have a league that runs in consecutive seasons,  each season lasting for 3 weeks.  It is not practical to have a worldwide league as playing opponents on different servers to their own results in too much lag for the game to be playable.  However, there may be a pairing of servers that have sufficiently low lag but this needs to be test. For instance, it is possible for servers USA East and USA West to have sufficiently low ping rate for plays from both servers to play each other, so can be combined as one league. 

The league is divided into divisions, where each division contains up to 7 players of a similar standard.  Each player plays one match against all other players in their division before the season ends.  A win rewards the player 3 points, losing a game rewards the player 1 point, a draw rewards both players 2 points.  Points are not rewarded for unplayed games, nor to any player that forfeits a game.  If a player forfeits a game, the opponent will be rewarded 3 points. 

League matches are played in a best out of five games format.  In other words, the winner of a league match is the first player to win 3 games.  The games won is recorded onto the league database via a match results entry form on the website. If for some valid reason, the match was not completed and could not be resumed on another day, then the match must be recorded as a draw.   Players will be encouraged to record their match using the PS4's game quick recording facility (actioned by double-clicking the share button on the move controller.  Double-clicking the share button again after the match will end the recording) in case disputes occur on the number of games won.  Players will be advised to set the default recording length to maximum one hour on the PS4 Settings Menu as the default length is probably 15 minutes.  Players will also be advised to keep the video recordings of a match for at least 3 days after results submission giving time for the opponent to dispute. 

At the end of every season, the top two players with the most points in each division promote up a division (except for the top division) and bottom two demotes to lower-division (except for lowest division).  If the 2nd and 3rd highest points are equal, then 2nd place is determined by who played the most matches.  If number of matches played is also equal, then 2nd place is determined by whoever has the larger game won-lost game difference.   So if player A games were as follows:

Match 1: won 3-1, rewarded 3 points
Match 2: won 3-1, rewarded 3 points
Match 3: lost 2-3, rewarded 1 point
Match 4: won 3-0, rewarded 3 points

and Player B:

Match 1: won 3-2, rewarded 3 points
Match 2: won 3-1, rewarded 3 points
Match 3: draw, rewarded 2 points
Match 4: draw, rewarded 2 points

both have 10 points, both played 4 matches but player A has the larger games difference (11-5=6) compared to Player B (6-3). So Player A takes the second place and promotes to next division in the next season.  The same principle applies to the players at the bottom of the division. 

In the event that the 2nd and 3rd place have same points, played the same number of games and have the same game difference, then in this exceptional circumstance, top 3 players will promote to the next division and bottom 3 players of that division will be demoted. 

Unlike video game leaderboards, this structure rewards players of all standards the opportunity to be a winner in their own division as the aim is to match players of a similar standard.   All division winners at the end of every season will be posted onto the website and on social media such as Facebook.

The first season will not be perfect in grouping similar standards but as the seasons continue and players get promoted/demoted, players will, by nature of the box league structure, progress to the appropriate division of their playing standard.




---------------What if a player doesn't want to enter leagues but wants to just arrange friendlies?---------------

Anyone can use the Player database to find a player that is on their server.  Players who register will include their PSN ID, server and initial self-assessed standard (Good, intermediate and Beginner).  This is all the information needed to register on the database.  On registering, players will be recommended to also submit their email address (private) so that the league organiser can send notifications of the new season start dates and announcements of the end of season results. 


---------------CODING IMPLEMENTATION---------------

The relational database of the league and players structure will be designed using MySQL Workbench.  PHP will be the chosen language to query the database at the backend.  HTML5, CSS, CSS Grid, and Javascript will be used for frontend development.   All languages will be learnt via www.Udemy.com courses and www.W3Schools.com.  


---------------Priority features and functions to implement for this project:---------------



Store all-league and player information into a relational database.

Show league current status and results history

Show Player standings in current divisions

Show Players match history and positions through seasons

Show players DB specific to the requested server.

User form for registering their profile.

User form for entering match results.



---------------Additional features for future:---------------

Internal messaging system to challenge players.

Players can record their non-league matches results.




---------------Backend Main Github Files and their description:---------------

EER relational DB model diagram (created in MySQL Workbench):
(in pdf)  rf_league_db.pdf 
(MySQL  Workbench file)  Racket Fury League Model V2.mwb

Forward engineered MySQL script (the creation of the dB):
rf_league_db_forward engineer.sql



---------------Front End Main Github files and their description:---------------
(NOTE: Front END is very underdeveloped but this is a skeletal structure of the intended result.)

Main home page showing links and buttons to the site's features.

index.html  








