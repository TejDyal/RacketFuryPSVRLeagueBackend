                <?php
                    $sql = "call rf_league_db.latestMatches(true, false, false, 0, 0, 10)";
                    $result = mysqli_query($conn, $sql);
                    if (mysqli_num_rows($result) > 0) {
                         while($row = mysqli_fetch_assoc($result)) {
                             echo '<span class="table d1">' . $row["datePlayed"] . "</span>" . 
                             '<span class="table d2">' . $row["ServerName"] . "</span>" . 
                             '<span class="table d3">' . $row["Season_id"] . "</span>" . 
                             '<span class="table d4">' . $row["Division_id"] . "</span>" . 
                             '<span class="table d5"><a href="pages\profile.php?profile_id=' . 
                                $row["p1_PSN"] . '">' . $row["p1_PSN"] . "</a></span>" . 
                             '<span class="table d6">' . " vs " . "</span>" . 
                             '<span class="table d7"><a href="pages\profile.php?profile_id=' . 
                                $row["P2_PSN"] . '">' . $row["P2_PSN"] . "</a></span>" . 
                             '<span class="table d8">' . $row["P1_score"] . "</span>" . 
                             '<span class="table d9">' . " - " . "</span>" . 
                             '<span class="table d10">' . $row["p2_score"] . "</span>";
                             
                        } 
                    } else {
                    echo "0 results";
                    }
                ?>