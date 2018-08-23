<?php 
if(isset($_POST["submitd"]))
		{include '../php/connessionedb.php';
			$sqld="DELETE FROM notizie  WHERE idnotizia='".$_POST["elimnews"]."'";
			$nomen="SELECT immagine FROM notizie  WHERE idnotizia='".$_POST["elimnews"]."'";
			$row = $DB->query($nomen);
			$immnews=$row->fetch_assoc();
			$dir='./';
			$file=$immnews["immagine"];
var_dump($file);
$stmt = mysqli_prepare($DB,$sqld);
		$stmt->execute();
    if ((file_exists($file))&&(mysqli_query($DB, $sqld))) {
        unlink($file);
		$_SESSION["deln"]="notizia eliminata con successo";
		header("Location: ../php/admin.php");
    } else {
       $_SESSION["errdeln"]="Errore nel eliminare la notizia ";
		header("Location: ../php/admin.php");
	}
			
		}
		
		
?>