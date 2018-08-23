<?php
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
        $_SESSION["imgfl"]="Il file non è un immagine";
        $uploadOk = 0;
    }// Check if file already exists
if (file_exists($target_file)) {
     $_SESSION["imgfl"]="Immagine già presente";
    $uploadOk = 0;
	
}


// Check file size
if ($_FILES["fileToUpload"]["size"] > 500000) {
    $_SESSION["imgfl"]="file troppo grande(dimensione massima 500Kb)";
    $uploadOk = 0;
}
// Allow certain file formats
if($imageFileType != "jpg" && $imageFileType != "jpeg" ) {
    $_SESSION["imgfl"]="l'immagine non rispetta i formati richiesti(jpg,jpeg)";
	$uploadOk = 0;
}
}
// Check if $uploadOk is set to 0 by an error
if ($uploadOk == 0) {
    $_SESSION["messagefil"]="File non caricato";
	header("Location: ../php/admin.php");
// if everything is ok, try to upload file
}
else{ $sql="INSERT INTO notizie (idnotizia,datan ,titolo,immagine,articolo,tag) VALUES (?,?,?,?,?,?)";
$stmt = mysqli_prepare($DB,$sql);
$stmt->bind_param("ssssss",$_POST["idnot"],date('Y-m-d H:i:s'),$_POST["titolo"],$_FILES["fileToUpload"]["name"],$_POST["contenutonews"],$_POST["tagnotizia"]);
$stmt->execute();
   if(move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)&&(mysqli_query($DB, $sql))) {
        $_SESSION["carsucc"]="Il file ". basename( $_FILES["fileToUpload"]["name"]). " è stato caricato con successo";
		$getString = http_build_query(array ( 'val'=>$_POST["idnot"]
                                     ));
			header("Location: ../php/notizia.php?$getString");
    }
}
?>