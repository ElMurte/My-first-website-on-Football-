<?php 
if(isset($_POST["idNotizia"]))
{
	include '../php/connessionedb.php';
	
	
	$nomen="SELECT immagine FROM notizie  WHERE idnotizia='".$_POST["idNotizia"]."'";
	$row = $DB->query($nomen);
	$immnews=$row->fetch_assoc();
	$dir='../immagini/news/';
	$file=$dir.$immnews["immagine"];
		if (is_file($file) &&(file_exists($file)) && unlink($file)) 
		{
			$sqld="DELETE FROM notizie WHERE idnotizia='".$_POST["idNotizia"]."';";
			if ($DB->query($sqld) === TRUE) {
			
			$_SESSION["deln"]="notizia eliminata con successo";
			header("Location: ../php/deletenews.php");
			} else {
				echo "Errore nell'eliminazione ";
			}
		}else{
			$_SESSION["errdeln"]="Errore nel eliminare la notizia ";
			//header("Location: ../php/admin.php");
		}
			
}
		
		
?>