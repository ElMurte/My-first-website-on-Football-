<?php 
	if (isset($_SESSION["username"])) {
   // logged in
   echo "<div id='logout' title='Logout'> <a href='./php/sessionend.php'>Logout</a> </div>";
   echo "<div id='amministrazione' title='amministrazione'> <a href='./admin.php'>amministrazione</a> </div>";
 } else {
   // not logged in
   echo "<div id='login' title='Login'> <a href='./login.php'>Login</a> </div>";
 }
 ?>