<?php
include '../php/connessionedb.php';
 $query=false;
   if (isset($_GET['query']))
	   $query = $_GET['query']; 
    // gets value sent over search form
    ?>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Risultati</title>
     <link rel="stylesheet" type="text/css" href="../css/search.css">
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
        <div class=utentelog><div id="registrazione"><div id="login"> <a href="login.php">Login/Registati</a> </div></div>
        
        </div>
    </div>
	
    </header>
<main class="content">
<div class="searched">
	<?php
    // $min_length = 2; you can set minimum length of the query if you want
     
    if(strlen($query)>= 2){ // if query length is more or equal minimum length then
         
		 $query = mysqli_real_escape_string($DB,$query);
        // makes sure nobody uses SQL injecti

        $result="SELECT idcampionato,logoc as logo,nome FROM `campionato` 
		where nome COLLATE UTF8_GENERAL_CI LIKE '%$query%'";
		$result1="SELECT logo,nome,campionato FROM `Squadra` where nome COLLATE UTF8_GENERAL_CI LIKE '%$query%' ";
         $rawresults=$DB->query($result);
			$rawresults1=$DB->query($result1);
         
    if((($rawresults)->num_rows > 0)||((($rawresults1)->num_rows > 0))){ // if one or more rows are returned do following
             if(($rawresults)->num_rows > 0){
			   while($row=$rawresults->fetch_assoc()){
				// $results = mysql_fetch_array($raw_results) puts data from database into array, while it's valid it does the loop
					echo "<a href='campionato.php?idc=".$row["idcampionato"]."'> <img src='../immagini/loghi/".$row["logo"]."' alt='logo ".$row["nome"]."'>
						</a>
					";
				}
			}
					if(($rawresults1)->num_rows > 0){
							while($row1=$rawresults1->fetch_assoc()){
								echo "<a href='squadra.php?squadra=".$row1["nome"]."&idc=".$row1["campionato"]."'> <img src='../immagini/loghi/".$row1["logo"]."' alt='logo ".$row1["nome"]."'>
						</a>
					";
							}
						}
	}
   else{ // if there is no matching rows do following
            echo "Nessun risultato";
        };
         
    }
    else{ // if query length is less than minimumecho 
	echo"la lunghezza minima per cercare è di 2";
        
    };
?>
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