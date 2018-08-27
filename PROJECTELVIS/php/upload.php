<?php
session_start();
include '../php/connessionedb.php';
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
if (file_exists($target_file)) {
     $_SESSION["imgfl"]="Immagine già presente";
    $uploadOk = 0;
	
}


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
	header("Location: ../php/admin.php");
// if everything is ok, try to upload file

}
else{ 
    if(move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) { 
	$_SESSION["carsucc"]="Il file ". basename( $_FILES["fileToUpload"]["name"]). " è stato caricato con successo";
	$getString = http_build_query(array ( 'val'=>$_POST["idnot"]));}
	   $sql="INSERT INTO notizie (idnotizia,datan ,titolo,immagine,articolo,tag) VALUES (?,?,?,?,?,?)";
	   $stmt = mysqli_prepare($DB,$sql);
	   $user = mysqli_real_escape_string($DB,$stmt);
		$datcur=date('Y-m-d H:i:s');
		$stmt->bind_param("ssssss",$_POST["idnot"],$datcur,$_POST["titolo"],$_FILES["fileToUpload"]["name"],$_POST["contenutonews"],$_POST["tagnotizia"]);
		$stmt->execute();
			header("Location: ../php/notizia.php?$getString");
    }

?>