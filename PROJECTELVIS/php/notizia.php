
<?php
session_start();
$val = $_GET["val"];
if(isset($_GET["titolo"]))
$titolo = $_GET["titolo"];
else $titolo=$_POST["titolo"];
?>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?php echo"".$titolo."";?>Easyfootball</title>
    <link rel="stylesheet" type="text/css" href="../css/body.css">
    <link rel="stylesheet" type="text/css" href="../css/notizia.css">
</head>
<body>
<?php
include './header.php';
?>
    <main class="content">
	<h2 class='messnews'>
<?php 

	if(isset($_SESSION["carsucc"])) {
   $messsucc=$_SESSION["carsucc"];
    unset($_SESSION["carsucc"]);
	echo"$messsucc";
	}
	
?>	</h2>
    <?php 
include '../php/connessionedb.php';
$notizia="SELECT titolo,immagine,articolo FROM `notizie` WHERE idnotizia='$val';";
 $result= $DB->query($notizia);
 
	if($result->num_rows>0){
		while($row=$result->fetch_assoc()){
			echo "
			 <div class='titolon'><h1>".$row["titolo"]."</h1></div>
    <div class='imgn'><img src='../immagini/news/".$row["immagine"]."' alt='immagine notizia' ></div>
<div class='articolo'><p>".$row["articolo"]."</p>
    </div>
			";
		};
	};
	$DB->close();
	?>
  </main>
   
  
<?php
include'./footer.php'
?>

</body>
</html>