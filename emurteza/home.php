<?php
session_start();
?>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Home Easyfootball</title>
<link rel="stylesheet" type="text/css" href="./css/print.css" media="print">
<link rel="stylesheet" type="text/css" href="./css/home1.css">
<link rel="stylesheet" type="text/css" href="./css/body.css">
</head>
<body>
<?php
require_once("./php/header.php");
?>
<main id="contprinc" class="content">

<div class='principali'>
	<h1>Campionati principali</h1>
	<div class='principale'>


<?php 
require_once("./php/connessionedb.php");
$logo="SELECT idcampionato,logoc,nome FROM `campionato` WHERE (nome=('Bundesliga'|| 'Serie A'|| 'Liga Santander'||'Premier League'));";
 $result= $DB->query($logo);
	if($result->num_rows>0){
		while($row=$result->fetch_assoc()){
			echo "
			<a href='campionato.php?idc=".rawurlencode($row["idcampionato"])."' title='".rawurlencode($row["nome"])."'>
			<img src='./immagini/loghi/".$row["logoc"]."' title='".$row["nome"]."' alt='logo ".$row["nome"]."' >
			</a> 
			";
		};
	};
	?>
	</div>
	</div>
	
	

    <div class="notizie"><h1>Notizie Principali</h1>

    <div class="mainnews" >
        <div class="inutile">
		<?php
		require_once("./php/connessionedb.php");
		$sql="SELECT idnotizia,immagine,titolo FROM `notizie` WHERE (tag COLLATE UTF8_GENERAL_CI LIKE '%bignews%') ORDER BY datan DESC LIMIT 5;";
		$resultnews= $DB->query($sql);
		$row=$resultnews->fetch_assoc();
		
		if($resultnews->num_rows>0){
			echo "<a href='./notizia.php?val=".$row["idnotizia"]."&titolo=".rawurlencode($row["titolo"])."' title='".$row["titolo"]."'>
		<span class='BimgContainer'>
			<img src='./immagini/news/".$row["immagine"]."' alt='immagine notizia' ></span>
			<h2 class='newsdescrBig'>".$row["titolo"]."</h2>
			</a>
			</div>
			</div>
			<div class='varie'>";
		while($row=$resultnews->fetch_assoc()){
			echo"<div class='news' title='".$row["titolo"]."'>
        <a href='./notizia.php?val=".$row["idnotizia"]."&titolo=".rawurlencode($row["titolo"])."' >
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
	<br><br>
	<footer class="barranotizie"><a href="notizie.php">Vedi Altre Notizie</a></footer>
    </main>
<?php
require_once("./php/footer.html");
?>

</body>
</html>