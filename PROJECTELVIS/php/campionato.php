<?php
$idc=$_GET["idc"];
?>
<!DOCTYPE html>
<html lang=it>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title>Campionato</title>
    <link rel="stylesheet" type="text/css" href="../css/body.css">
    <link rel="stylesheet" type="text/css" href="../css/campionato.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
    
    <noscript>
    <p><img src="../immagini/immaginivarie/attenzione.png" alt="attenzione">   Per favore attivare javascript sul browser altrimenti il contenuto non è completamente accessibile</p>
    </noscript>
<main class="content">
   
<div id="menucampionato">
    <!-- Load an icon library to show a hamburger menu (bars) on small screens -->
    <?php 
include '../php/connessionedb.php';
$logo="SELECT logoc,nome FROM `campionato` WHERE idcampionato='$idc';";
 $result= $DB->query($logo);
	if($result->num_rows>0){
		while($row=$result->fetch_assoc()){
			echo "
   <div id='campionato'><img src='../immagini/loghi/".$row["logoc"]."' alt='logo ".$row["nome"]."' ></div>";
		};
	};

	?>

<div class="topnav" id="navcamp" >
<a href="#content1" id="news" class="menuHandler current">Notizie</a>
<a href="#content2" id="partite" class="menuHandler">Partite</a>
<a href="#content3" id="classifica" class="menuHandler">Classifica</a>
</div>
    </div>
    <div id="content1" class="active">
	
         <?php
		include '../php/connessionedb.php';
		$sql="SELECT idnotizia,immagine,titolo FROM `notizie` WHERE (tag COLLATE UTF8_GENERAL_CI LIKE '%$idc%') ORDER BY datan DESC LIMIT 4;";
		$resultnews= $DB->query($sql);
		if($result->num_rows>0){
		while($row=$resultnews->fetch_assoc()){
			echo"<div class='news'>
        <a href='notizia.php?val=".$row["idnotizia"]."' >
        <span class='imgContainer'>
            <img src='../immagini/news/".$row["immagine"]."' alt='fotonews'>
        </span>
            <span class='newsdescr'>".$row["titolo"]."</span>
        </a>  </div>";
		};
	};
	$DB->close();
	?>
  
    </div>
    
    <div id="content2">
        <div class="partite" lang="it">
            <table>
					<thead>
                        <tr>
							<th></th>
                        
						
                            <th>Ultima giornata</th>
                           
							
							<th></th>
						</tr>
						<tr>
							<th>Casa</th>
							
							<th>Risultato</th>
                            
							
                            <th>Ospite</th>						
						</tr>
					</thead>
					<tbody>
					<?php
					include '../php/connessionedb.php';
				$giornata="SELECT logoc,squadracasa,golcasa,golospite,logoo,squadraospite FROM 
				(SELECT idpartita,logo as logoc,squadracasa,ngiornata,golcasa from (SELECT * FROM `partita` WHERE 
				campionato COLLATE UTF8_GENERAL_CI ='$idc' AND datap<=CURRENT_DATE() ORDER BY datap DESC LIMIT 10)as parti 
				join `squadra` as sqd WHERE parti.squadracasa=sqd.nome) as casa JOIN
				(SELECT idpartita,logo as logoo,squadraospite,golospite,datap,ora from 
				(SELECT * FROM `partita` WHERE campionato COLLATE UTF8_GENERAL_CI ='$idc' AND datap<=CURRENT_DATE() 
				ORDER BY datap DESC LIMIT 10)as parti join `squadra` as sqd WHERE parti.squadraospite=sqd.nome)as ospite 
				WHERE casa.idpartita=ospite.idpartita ORDER BY datap,ora;";
				 $result= $DB->query($giornata);
					if($result->num_rows>0){
						while($row=$result->fetch_assoc()){
							echo "
							 <tr>
                        <td><img src='../immagini/loghi/".$row["logoc"]."' alt='".$row["squadracasa"]."'>  </td>
                       
                        <td>".$row["golcasa"]." : ".$row["golospite"]."</td>
                       
                        <td> <img src='../immagini/loghi/".$row["logoo"]."' alt='".$row["squadraospite"]."'></td>
                        </tr>
							";
		};
	};
	$DB->close();
					?>
					
                       
                    </tbody>
            </table>
        </div>
        <div class="prossime">
            <table>
              
					<thead>
                         <tr>
							<th></th>
                           
                            <th>Prossima giornata</th>
                           
                            <th></th>
						</tr>
                        <tr>    
							<th>Casa</th>
						
                            <th>ora</th>
							
                            <th>Ospite</th>
						</tr>
					</thead>
					<tbody>
										<?php
					include '../php/connessionedb.php';
				$giornata="SELECT logoc,squadracasa,datap,ora,logoo,squadraospite FROM 
				(SELECT idpartita,logo as logoc,squadracasa,ngiornata,datap,ora from (SELECT * FROM `partita` WHERE 
				campionato COLLATE UTF8_GENERAL_CI ='$idc' AND datap>CURRENT_DATE() ORDER BY datap ASC LIMIT 10)as parti 
				join `squadra` as sqd WHERE parti.squadracasa =sqd.nome) as casa JOIN
				(SELECT idpartita,logo as logoo,squadraospite from 
				(SELECT * FROM `partita` WHERE campionato ='$idc' AND datap>CURRENT_DATE() 
				ORDER BY datap ASC LIMIT 10)as parti join `squadra` as sqd WHERE parti.squadraospite =sqd.nome)as ospite 
				WHERE casa.idpartita=ospite.idpartita;";
				 $result= $DB->query($giornata);
					if($result->num_rows>0){
						while($row=$result->fetch_assoc()){
							echo "
							 <tr>
                        <td><img src='../immagini/loghi/".$row["logoc"]."' alt='".$row["squadracasa"]."'>  </td>
                       
                        <td> ".$row["datap"]." ".$row["ora"]."</td>
                        
                        <td> <img src='../immagini/loghi/".$row["logoo"]."' alt='".$row["squadraospite"]."'> </td>
                        </tr>
							";
		};
	};
	$DB->close();
					?>
                    </tbody>
            </table>
        </div>
        </div>
      
    
    <div id="content3">
         <div class="wrapper">
                    <h1>Classifica</h1>
				<table>
					<thead>
						<tr>
							<th>Pos</th>
							<th>Squadra</th>
							<th>G</th>
							<th>V</th>
							<th>P</th>
							<th>S</th>
							<th>Punti</th>
							<th>+/-</th>
							<th>DR</th>
						</tr>
					</thead>
					<tbody>
					<?php
					include '../php/connessionedb.php';
					$pos=1;
			$ciao="
SELECT logo,squadra,partite,vittorie,pareggi,sconfitte,punti,golf,gols,diff_reti FROM (squadra as sqd
JOIN
(SELECT
    squadra,
    COUNT(squadra) AS partite,
    SUM(IF(punteggio = 3, 1, 0)) AS vittorie,
    SUM(IF(punteggio = 1, 1, 0)) AS pareggi,
    SUM(IF(punteggio = 0, 1, 0)) AS sconfitte,
    SUM(punteggio) AS punti,
    SUM(fatti) AS golf,
    SUM(subiti) AS gols,
    SUM(fatti) - SUM(subiti) AS diff_reti
FROM
    (
    SELECT
        squadracasa AS squadra,
        golcasa AS fatti,
        golospite AS subiti,
        'C' AS dove,
        CASE WHEN golcasa > golospite THEN 3 WHEN golcasa = golospite THEN 1 ELSE 0
END AS punteggio
FROM
    Partita
WHERE
    campionato = '$idc' AND datap < CURRENT_DATE()
UNION ALL
SELECT
    squadraospite AS squadra,
    golospite AS fatti,
    golcasa AS subiti,
    'T' AS dove,
    CASE WHEN golospite > golcasa THEN 3 WHEN golospite = golcasa THEN 1 ELSE 0
END AS punteggio
FROM
    Partita
WHERE
    campionato = '$idc' AND datap < CURRENT_DATE()
) AS tab
GROUP BY
    squadra
ORDER BY
    punteggio,diff_reti
DESC) as sqd2) WHERE sqd.nome = sqd2.squadra ORDER BY punti DESC,diff_reti DESC;";
			 $result= $DB->query($ciao);
						if($result->num_rows>0){
							while($row=$result->fetch_assoc()){
								echo "
				<tr>
						<td>$pos</td>
						<td ><img src='../immagini/loghi/".$row["logo"]."' width='60em' height='75em' alt'".$row["squadra"]."'> </td>
						<td>".$row["partite"]."</td>
						<td>".$row["vittorie"]."</td>
						<td>".$row["pareggi"]."</td>
						<td>".$row["sconfitte"]."</td>
						<td>".$row["punti"]."</td>
						<td>".$row["golf"]."/".$row["gols"]."</td>
						<td>".$row["diff_reti"]."</td>
              </tr>
			  
			";
			$pos=$pos+1;
		};
	}
		else {
    printf("Query failed: %s\n", $DB->error);
	};
	$DB->close();
					?>
              
					</tbody>
				</table>
			</div>
    </div>


</main>
        <script>
    $('.menuHandler').on('click', function() {
        $('a[href="#'+$('.active').attr("id")+'"]').removeClass('current');
        $('.active').removeClass('active').hide();
        $($(this).attr('href')).addClass('active').show();
        $(this).addClass('current');
        return false;
    });

    </script>
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