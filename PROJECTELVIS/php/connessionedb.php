
<?php

$db_server = "localhost";
$db_user = "root";
$db_password = "";
$db_name = "definitivo";
$DB = new mysqli($db_server, $db_user, $db_password, $db_name);
if($DB->connect_error) die("Connessione al database non riuscita: " . $DB->connect_error);
else 
mysqli_set_charset($DB,"utf8");;
?>