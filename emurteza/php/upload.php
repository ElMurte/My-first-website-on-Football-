<?php
session_start();
require_once("./connessionedb.php");
$target_dir = "../immagini/news/";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
// Check if image file is a actual image or fake image
if(isset($_POST["submit"])) {
	
    $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);//script per evitare il caricamento
    if($check !== false) {
   //il file è un immagine?!
        $uploadOk = 1;
    } else {
        $_SESSION["imgfl"]="Il file non è un immagine o file troppo grande";
        $uploadOk = 0;
    }//check se il file esiste
// la dimensione
if ($_FILES["fileToUpload"]["size"] > 500000) {
    $_SESSION["imgfl"]="file troppo grande(dimensione massima 500Kb)";
    $uploadOk = 0;
}
// il formato
if($imageFileType != "jpg" && $imageFileType != "jpeg" ) {
    $_SESSION["imgfl"]="l'immagine non rispetta i formati richiesti(jpg,jpeg)";
	$uploadOk = 0;
}
}
//controllo se il file presenta qualche tipo di errore
if ($uploadOk == 0) {
    $_SESSION["messagefil"]="Errore,File non caricato";
	header("Location: ../admin.php");
// if everything is ok, try to upload file

}
		if (file_exists($target_file)) {
							$sql="INSERT INTO notizie (datan ,titolo,immagine,articolo,tag) VALUES (?,?,?,?,?)";
							   $stmt = mysqli_prepare($DB,$sql);
							   $user = mysqli_real_escape_string($DB,$stmt);
								$datcur=date('Y-m-d H:i:s');
								$stmt->bind_param("sssss",$datcur,$_POST["titolo"],$_FILES["fileToUpload"]["name"],$_POST["contenutonews"],$_POST["tagnotizia"]);
								
								if($stmt->execute()===TRUE){
									move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file); 
								$ultima="SELECT idnotizia,titolo FROM `notizie` Order by datan DESC limit 1";
								$row = $DB->query($ultima);
								$resultultima=$row->fetch_assoc();
								$getString = http_build_query(array ( 'val'=>$resultultima["idnotizia"],'titolo'=>$resultultima["titolo"]));
								$_SESSION["carsucc"]="La notizia è stato caricato con successo";
									header("Location: ../notizia.php?$getString");
									
								}
								else{
										$_SESSION["messagefil"]="Notizia già presente";
										header("Location: ../admin.php");
									}
		}
else{ 
    if(move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) 
		{ 
	
	
	   $sql="INSERT INTO notizie (datan ,titolo,immagine,articolo,tag) VALUES (?,?,?,?,?)";
	   $stmt = mysqli_prepare($DB,$sql);
	   $user = mysqli_real_escape_string($DB,$stmt);
		$datcur=date('Y-m-d H:i:s');
		$stmt->bind_param("sssss",$datcur,$_POST["titolo"],$_FILES["fileToUpload"]["name"],$_POST["contenutonews"],$_POST["tagnotizia"]);
		$stmt->execute();
		$ultima="SELECT idnotizia FROM `notizie` Order by datan DESC limit 1";
		$row = $DB->query($ultima);
		$resultultima=$row->fetch_assoc();
		$getString = http_build_query(array ( 'val'=>$resultultima["idnotizia"],'titolo'=>$resultultima["titolo"]));
			$_SESSION["carsucc"]="La notizia è stato caricato con successo";
			header("Location: ../notizia.php?$getString");
			$DB->close();
		}
		
    }

?>