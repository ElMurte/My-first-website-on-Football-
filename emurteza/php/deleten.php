<?php 
if(isset($_POST["idNotizia"]))
{
	require_once("./connessionedb.php");
	
	$sqld="DELETE FROM notizie WHERE idnotizia='".$_POST["idNotizia"]."';";
	$nomen="SELECT immagine FROM notizie  WHERE idnotizia='".$_POST["idNotizia"]."'";
	
	$row = $DB->query($nomen);
	$immnews=$row->fetch_assoc();
	$numero="select COUNT(immagine) as numero FROM notizie  WHERE immagine='".$immnews["immagine"]."'";
	$row1 = $DB->query($numero);
	$numero1=$row1->fetch_assoc();
	$numerof=$numero1["numero"];
	$dir='./immagini/news/';
	$uno='1';
	$file=$dir.$immnews["immagine"];
			if (is_file($file) &&(file_exists($file))&&($numerof==$uno)) //se la news in questiona è "unica"
				{
					unlink($file);
					if ($DB->query($sqld) === TRUE) {
					
					$_SESSION["deln"]="notizia eliminata con successo";
					header("Location: ../deletenews.php");
					} 
						else{
							$_SESSION["errdeln"]="Errore nel eliminare la notizia ";
							//header("Location: ./php/admin.php");
						}
				}
			
		//elimino solo dal DB
			else{
				if ($DB->query($sqld) === TRUE) {
					$_SESSION["deln"]="notizia eliminata con successo";
					header("Location: ../deletenews.php");
					}
					else{
						$_SESSION["errdeln"]="Errore nel eliminare la notizia ";
						header("Location: ../admin.php");
						}			
				}	
}				
?>