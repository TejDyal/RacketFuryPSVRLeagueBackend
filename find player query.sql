-- find a player --

use rf_league_db;
select PSN_id, serverName, standard
from player p
JOIN server ON p.Server_Server_id = server.Server_id
where server.serverName='Europe' AND standard='Medium';
-- in html/php dropdown boxes will be presented to select server and standard