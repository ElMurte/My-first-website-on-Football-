<?php
include '../php/connessionedb.php';
// Grab User submitted information
$email = $_POST["username"];
$pass = $_POST["userpass"];
$result ="SELECT username,email,password FROM utente WHERE username = $email";
$row =mysqli$DB->query($result);
mysqli_fetch_array($row);
if($row["username"]==$email && $row["users_pass"]==$pass)
    echo"Loggato con successo";
else
    echo"Mi dispiace, le credenziali inserite non sono valide,riprova";
?>