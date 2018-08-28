<?php
session_start();

	?>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Home</title>
<link rel="stylesheet" type="text/css" href="../css/home1.css">
    <link rel="stylesheet" type="text/css" href="../css/body.css">
</head>
<body>
<?php
include'../php/header.php';
?>
<main class="content">

<div class='principali'>
	<h1>Campionati principali</h1>
	<div class='principale'>


<?php 
include '../php/connessionedb.php';
$logo="SELECT idcampionato,logoc,nome FROM `campionato` WHERE (nome=('Bundesliga'|| 'Serie A'|| 'Liga Santander'||'Premier League'));";
 $result= $DB->query($logo);
	if($result->num_rows>0){
		while($row=$result->fetch_assoc()){
			echo "
			<a href='campionato.php?idc=".$row["idcampionato"]."'>
			<img src='../immagini/loghi/".$row["logoc"]."' alt='logo ".$row["nome"]."' >
			</a> 
			";
		};
	};
	$DB->close();
	?>
	</div>
	</div>
	
	

    <div class="notizie"><h1>Notizie Principali</h1>

    <div class="mainnews">
        <div class="inutile">
		<?php
		include '../php/connessionedb.php';
		$sql="SELECT idnotizia,immagine,titolo FROM `notizie` WHERE (tag COLLATE UTF8_GENERAL_CI LIKE '%bignews%') ORDER BY datan DESC LIMIT 5;";
		$resultnews= $DB->query($sql);
		$row=$resultnews->fetch_assoc();
		
		if($result->num_rows>0){
			echo "<a href='notizia.php?val=".$row["idnotizia"]."'>
		<span class='BimgContainer'>
			<img src='../immagini/news/".$row["immagine"]."' alt='immagine notizia' ></span>
			<span class='newsdescrBig'>".$row["titolo"]."</span>
			</a>
			</div>
			</div>
			<div>";
		while($row=$resultnews->fetch_assoc()){
			echo"<div class='news'>
        <a href='notizia.php?val=".$row["idnotizia"]."' >
        <span class='imgContainer'>
            <img src='../immagini/news/".$row["immagine"]."' alt='immagine notizia'>
        </span>
            <span class='newsdescr'>".$row["titolo"]."</span>
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
include'../php/footer.php'
?>
    
</footer>

</body>
</html>