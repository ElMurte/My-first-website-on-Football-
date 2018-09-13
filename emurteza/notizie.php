<?php
session_start();
if(isset($_GET["idc"]))
$idc=$_GET["idc"];
	?>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Notizie Easyfootball</title>
<link rel="stylesheet" type="text/css" href="./css/print.css" media="print"> 
<link rel="stylesheet" type="text/css" href="./css/campionato.css">
<link rel="stylesheet" type="text/css" href="./css/body.css">
<link rel="stylesheet" type="text/css" href="./css/notizie.css">
</head>
<body>
<?php
require_once("./php/header.php");
?>
<main id="contprinc" class="content">
<div class="notizie">
<h1>Notizie Principali</h1>
			<div class='varie'>
		<?php
		require_once("./php/connessionedb.php");
		$sql="SELECT idnotizia,immagine,titolo FROM `notizie` WHERE (tag COLLATE UTF8_GENERAL_CI LIKE '%bignews%') ORDER BY datan DESC LIMIT 20;";
		if(isset($idc)){
			$sql="SELECT idnotizia,immagine,titolo FROM `notizie` WHERE (tag COLLATE UTF8_GENERAL_CI LIKE '%".$idc."%') ORDER BY datan DESC LIMIT 20;";
		}
		$resultnews= $DB->query($sql);
	
		if($resultnews->num_rows>0){
		while($row=$resultnews->fetch_assoc()){
			echo"<div class='news' title='".$row["titolo"]."'>
        <a href='notizia.php?val=".$row["idnotizia"]."&titolo=".rawurlencode($row["titolo"])."' >
        <span class='imgContainer'>
            <img src='./immagini/news/".$row["immagine"]."' alt='immagine notizia'>
        </span>
            <h2 class='newsdescr'>".$row["titolo"]."</h2>
        </a>
        </div>";
		};
	};
	$DB->close();
	?>
	
    </div>
	
    </div>

</main>
<?php
require_once("./php/footer.html");
?>

</body>
</html>