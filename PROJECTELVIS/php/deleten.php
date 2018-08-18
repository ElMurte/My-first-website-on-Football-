<?php 
if(isset($_POST["submitd"]))
		{include '../php/connessionedb.php';
			$sqld="DELETE FROM notizie  WHERE idnotizia='".$_POST["elimnews"]."'";
			$stmt = mysqli_prepare($DB,$sqld);
			$stmt->execute();
						if (mysqli_query($DB, $sqld)) {
						echo "notizia eliminata con successo";
						} else {
						echo "Error: " . $sqld . "<br>" . mysqli_error($DB);
						}
		}
?>