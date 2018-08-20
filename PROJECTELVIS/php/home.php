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
<header id="header">
<h1><a href="home.php"><img src="../immagini/loghi/logooff.png" alt="logo"></a> Easyfootball</h1>
    <div id="boxuf">
    <div class="wrap">
        <div class="search">
            <form action="search.php" method="get"> 
        <input type="text" class="searchTerm" placeholder="Ricerca Squadre o Campionati" name="query">
        <button type="submit" class="searchButton" value="search" onsubmit="<a href='search.php?query='$query'</a>" >
        <i class="fa fa-search"></i> 
       </button>
            </form>
        </div>
    </div>
        <div class=utentelog><div id="registrazione">
		<?php include '../php/log.php'?>
		</div>
        </div>
    </div>
	
    </header>
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
        <div>
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
<footer id="footer">
        <h3>Chi Siamo</h3>
    <li>
       <a href=""> <ul>L'Azienda</ul></a>
        <a href=""><ul>Lavora con noi</ul></a>
        <a href=""><ul>Contatti</ul></a>
    </li>
   <div id="motto"> 
       <span>&copy; EasyFootball-Because football is much then just a sport.</span>
    </div>
    
</footer>

</body>
</html>