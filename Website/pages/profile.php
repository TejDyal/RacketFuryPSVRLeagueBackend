<?php
  if (isset($_GET['profile_id']))
  {
    $profile_id = $_GET['profile_id'];
  } else {
    $profile_id = "nobody";
  }
  echo $profile_id
?>
