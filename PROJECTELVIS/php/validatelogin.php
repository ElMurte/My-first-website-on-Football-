<?php
include '../php/connessionedb.php';
// Grab User submitted information
$user = $_POST["username"];
$pass = $_POST["userpass"];
$sqll ="SELECT username,password,squadrapref FROM utente WHERE username ='$user' AND password='$pass';";
$result=$DB->query($sqll);
$row=$result->fetch_assoc();
$user = mysqli_real_escape_string($DB,$user);
$pass= mysqli_real_escape_string($DB,$pass);
		if(	$row["username"]==$user && $row["password"]==$pass	)
		{
			header('Location: ../php/squadra.php?squadra=".$row["squadrapref"]."');
		}
	else echo"errore,credenziali errate";
	?>