<?php
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
<h1><a href="home.php"><img src="../immagini/loghi/logooff.png" alt="logo" lang="it"></a> Easyfootball</h1>
    <div id="boxuf">
    <div class="wrap">
        <div class="search">
        <input type="text" class="searchTerm" placeholder="Ricerca Squadre o Campionati">
        <button type="submit" class="searchButton">
        <i class="fa fa-search"></i> 
       </button>
        </div>
    </div>
        <div class=utentelog><div id="registrazione"><div id="login"> <a href="login.html">Login/Registati</a> </div></div>
        
        </div>
    </div>
    </header>
    <main class="content">
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
   
  
<footer id="footer" lang="it">
        <h3>Chi Siamo</h3>
    <li>
       <a href=""> <ul>L'Azienda</ul></a>
        <a href=""><ul>Lavora con noi</ul></a>
        <a href=""><ul>Contatti</ul></a>
    </li>
   <div id="motto" lan="en"> 
       <span>&copy; EasyFootball-Because football is much then just a sport.</span>
    </div>
    
</footer>

</body>
</html>