<?php 
	if (isset($_SESSION["username"])) {
   // logged in
   echo "<div id='logout'> <a href='sessionend.php'>Logout</a> </div>";
   echo "<div id='amministrazione'> <a href='admin.php'>amministrazione</a> </div>";
 } else {
   // not logged in
   echo "<div id='login'> <a href='login.php'>Login</a> </div>";
 }
 ?>