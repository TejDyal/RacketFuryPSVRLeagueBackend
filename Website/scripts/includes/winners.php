<?php
                    $sqlwinners = "call rf_league_db.winners(true, false, 1, 1)";
                    $resultwinners = mysqli_query($conn, $sqlwinners);
                    if (mysqli_num_rows($resultwinners) > 0) {
                         while($row = mysqli_fetch_assoc($resultwinners)) {
                             echo  '<span class="winner divsn">' . "Division " . $row["Division_id"] . "</span><br>" . 
                             '<span class="winner psn"><a href="pages\profile.php?profile_id=' . 
                             $row["PSN_id"] . '">' . $row["PSN_id"] . "</a></span><br><br>";                             
                        } 
                    } else {
                    echo "0 results";
                    }
                ?>