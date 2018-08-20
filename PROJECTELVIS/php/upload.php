<?php

$target_dir = "../immagini/news/";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
// Check if image file is a actual image or fake image
if(isset($_POST["submit"])) {
	include '../php/connessionedb.php';

$sql="INSERT INTO notizie (idnotizia,datan ,titolo,immagine,articolo,tag) VALUES (?,?,?,?,?,?)";
$stmt = mysqli_prepare($DB,$sql);
$stmt->bind_param("ssssss",$_POST["idnot"],date('Y-m-d H:i:s'),$_POST["titolo"],$_FILES["fileToUpload"]["name"],$_POST["contenutonews"],$_POST["tagnotizia"]);
$stmt->execute();

if (mysqli_query($DB, $sql)) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql . "<br>" . mysqli_error($DB);
}
    $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
    if($check !== false) {
        echo "Il file è un immagine" . $check["mime"] . ".";
        $uploadOk = 1;
    } else {
        echo "Il file non è un immagine";
        $uploadOk = 0;
    }// Check if file already exists
if (file_exists($target_file)) {
    echo "Immagine già presente";
    $uploadOk = 0;
}


// Check file size
if ($_FILES["fileToUpload"]["size"] > 500000) {
    echo "file troppo grande";
    $uploadOk = 0;
}
// Allow certain file formats
if($imageFileType != "jpg" && $imageFileType != "jpeg" ) {
    echo "Sono amessi solo file JPG e JPEG";
    $uploadOk = 0;
}
// Check if $uploadOk is set to 0 by an error
if ($uploadOk == 0) {
    echo "File non caricato";
	header("Location: ../php/admin.php");
// if everything is ok, try to upload file
} else {
    if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
        echo "Il file ". basename( $_FILES["fileToUpload"]["name"]). " è stato caricato";
		$getString = http_build_query(array ( 'val'=>$_POST["idnot"]
                                     ));
			header("Location: ../php/notizia.php?$getString");
    }

	else {
        echo "Errore nel caricamento del file";
    }
}
}
if(isset($_POST["submitd"]))
		{
			$sqld="DELETE FROM notizie  WHERE idnotizia='".$_POST["elimnews"]."'";
			
						if (mysqli_query($DB, $sqld)) {
						echo "New record created successfully";
						} else {
						echo "Error: " . $sql . "<br>" . mysqli_error($DB);
						}
		}

?>