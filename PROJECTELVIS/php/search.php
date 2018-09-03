<?php
// Start the session
session_start();
?>
<?php
include '../php/connessionedb.php';
 $query=false;
   if (isset($_GET['query']))
	   $query = $_GET['query']; 
    // gets value sent over search form
    ?>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Risultati ricerca Easyfootball</title>
     <link rel="stylesheet" type="text/css" href="../css/search.css">
	 <link rel="stylesheet" type="text/css" href="../css/body.css">
</head>
<body>
<?php
include'./header.php';
?>
<main class="content">
<div class="searched">
<h1>Risultati ricerca:</h1><br>
	<?php
    
     
    if(strlen($query)>= 2){ // se la parola cercate ha almeno 2 caratteri
         
		 $query = mysqli_real_escape_string($DB,$query);
      

        $result="SELECT idcampionato,logoc as logo,nome FROM `campionato` 
		where nome COLLATE UTF8_GENERAL_CI LIKE '%$query%'";
		$result1="SELECT logo,nome,campionato FROM `Squadra` where nome COLLATE UTF8_GENERAL_CI LIKE '%$query%' ";
         $rawresults=$DB->query($result);
			$rawresults1=$DB->query($result1);
         
    if((($rawresults)->num_rows > 0)||((($rawresults1)->num_rows > 0))){
             if(($rawresults)->num_rows > 0){
			   while($row=$rawresults->fetch_assoc()){

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
	<?php
include'./footer.php';
?>
</body>
</html>