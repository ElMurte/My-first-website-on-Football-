<?php 
if(isset($_POST["idNotizia"]))
{
	include '../php/connessionedb.php';
	
	$sqld="DELETE FROM notizie WHERE idnotizia='".$_POST["idNotizia"]."';";
	$nomen="SELECT immagine FROM notizie  WHERE idnotizia='".$_POST["idNotizia"]."'";
	
	$row = $DB->query($nomen);
	$immnews=$row->fetch_assoc();
	$numero="select COUNT(immagine) as numero FROM notizie  WHERE immagine='".$immnews["immagine"]."'";
	$row1 = $DB->query($numero);
	$numero1=$row->fetch_assoc();
	$numerof=$numero1["numero"];
	$dir='../immagini/news/';
	$file=$dir.$immnews["immagine"];
	if($numerof===1)
			{if (is_file($file) &&(file_exists($file)) && unlink($file)) //se la news in questiona è "unica"
				{
					
					if ($DB->query($sqld) === TRUE) {
					
					$_SESSION["deln"]="notizia eliminata con successo";
					header("Location: ../php/deletenews.php");
					} 
						else{
							$_SESSION["errdeln"]="Errore nel eliminare la notizia ";
							//header("Location: ../php/admin.php");
						}
				}
			}
		//elimino solo dal DB
			else{
				if ($DB->query($sqld) === TRUE) {
					$_SESSION["deln"]="notizia eliminata con successo";
					header("Location: ../php/deletenews.php");
					}
					else{
						$_SESSION["errdeln"]="Errore nel eliminare la notizia ";
						header("Location: ../php/admin.php");
						}			
				}	
}				
?>