<?php
// Start the session
session_start();
?>
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
$cam="SELECT campionato from squadra where nome COLLATE UTF8_GENERAL_CI LIKE '$squadra'";
	$camp=$DB->query($cam);
$row1=$camp->fetch_assoc();
		$idc=$row1["campionato"];
		if(	$row["username"]==$user && $row["password"]==$pass	)
		{
// Set session variables
$_SESSION["$user"] = "green";
$_SESSION["$pass"] = "cat";
echo "Session variables are set.";
			header('Location: ../php/squadra.php?squadra=$row["squadrapref"]&idc=$row1["campionato"]');
		}
	else echo"errore,credenziali errate";
	?>