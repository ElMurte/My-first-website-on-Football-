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
    if (file_exists($file)) {
        unlink($file);
    } else {
        // File not found.
    }
			$stmt = mysqli_prepare($DB,$sqld);
			$stmt->execute();
						if (mysqli_query($DB, $sqld)) {
						echo "notizia eliminata con successo";
						} else {
						echo "Error: " . $sqld . "<br>" . mysqli_error($DB);
						}
		}
		
?>