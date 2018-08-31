
<?php
session_start();
$val = $_GET["val"];
?>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Notizia</title>
    <link rel="stylesheet" type="text/css" href="../css/body.css">
    <link rel="stylesheet" type="text/css" href="../css/notizia.css">
</head>
<body>
<header id="header">
<h1><a href="home.php"><img src="../immagini/loghi/logooff.png" alt="logo" ></a> Easyfootball</h1>
    <div id="boxuf">
    <div class="wrap">
        <div class="search">
        <input type="text" class="searchTerm" placeholder="Ricerca Squadre o Campionati">
        <button type="submit" class="searchButton">
        <i class="fa fa-search"></i> 
       </button>
        </div>
    </div>
        <div class=utentelog><div id="registrazione"><?php include '../php/log.php'?></div>
        
        </div>
    </div>
    </header>
    <main class="content">
	<h2 class="succ">
<?php 
	if(isset($_SESSION["carsucc"])) {
   $messsucc=$_SESSION["carsucc"];
    unset($_SESSION["carsucc"]);
	echo"<h2>$messsucc</h2>";
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
include'../php/footer.php'
?>

</body>
</html>