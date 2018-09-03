
<?php

$db_server = "localhost";
$db_user = "emurteza";
$db_password = "Ahr8Iv6Ahh5ienoh";
$db_name = "emurteza";
$DB = new mysqli($db_server, $db_user, $db_password, $db_name);
if($DB->connect_error) die("Connessione al database non riuscita: " . $DB->connect_error);
else 
mysqli_set_charset($DB,"utf8");;
?>