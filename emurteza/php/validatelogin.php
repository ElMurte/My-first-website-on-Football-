<?php
// Start the session
session_start();
require_once("./connessionedb.php");
$user = $_POST["username"];
$pass = $_POST["userpass"];
$sqll ="SELECT username,password,squadrapref FROM utente WHERE username ='$user' AND password='$pass';";
$result=$DB->query($sqll);
$row=$result->fetch_assoc();
$user = mysqli_real_escape_string($DB,$user);
$pass= mysqli_real_escape_string($DB,$pass);

		if(	$row["username"]==$user && $row["password"]==$pass	)
		{
			$_SESSION["username"] = "$user";
			$_SESSION[logsucc]="Login effettuato con successo";
//$getString = http_build_query(array ( 'squadra'=>$row["squadrapref"],'idc'=>$row1["campionato"]));
			$DB->close();
			header("Location: ../admin.php");
		}
	else
	{
		$_SESSION["logerror"]="nome utente o password sbagliata";
		$DB->close();
		header("Location: ../login.php");
	}
?>