
<?php
session_start();
$val = $_GET["val"];
if(isset($_GET["titolo"]))
$titolo = $_GET["titolo"];
else 
if(isset($_POST["titolo"]))
$titolo=$_POST["titolo"];
?>
<!DOCTYPE html>
<a href="#contprinc" class="nonvedente">Vai al contenuto</a>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?php echo"".$titolo."";?> Easyfootball</title>
    <link rel="stylesheet" type="text/css" href="./css/body.css">
    <link rel="stylesheet" type="text/css" href="./css/notizia.css">
	<link rel="stylesheet" type="text/css" href="./css/print.css" media="print"> 
</head>
<body>
<?php
require_once("./php/header.php");
?>
    <main id="contprinc" class="content">
	<h2 class='messnews'>
<?php 

	if(isset($_SESSION["carsucc"])) {
   $messsucc=$_SESSION["carsucc"];
    unset($_SESSION["carsucc"]);
	echo"$messsucc";
	}
	
?>	</h2>
    <?php 
require_once("./php/connessionedb.php");
$notizia="SELECT titolo,immagine,articolo FROM `notizie` WHERE idnotizia='$val';";
 $result= $DB->query($notizia);
 
	if($result->num_rows>0){
		while($row=$result->fetch_assoc()){
			echo "
			 <div class='titolon' title='titolo notizia'><h1>".$row["titolo"]."</h1></div>
    <div class='imgn'><img src='./immagini/news/".$row["immagine"]."' alt='immagine notizia' ></div>
<div class='articolo' title='articolo'><p>".$row["articolo"]."</p>
    </div>
			";
		};
	};
	$DB->close();
	?>
  </main>
   
  
<?php
require_once("./php/footer.html");
?>

</body>
</html>