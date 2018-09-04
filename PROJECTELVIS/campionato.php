
<?php
session_start();
if(isset($_GET["idc"]))
$idc=$_GET["idc"];
else
	header
?>
<!DOCTYPE html>
<html lang="it">
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="UTF-8">
<title><?php
echo"$idc-Easyfootball"
?></title>
    <link rel="stylesheet" type="text/css" href="./css/body.css">
    <link rel="stylesheet" type="text/css" href="./css/campionato.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<?php
require_once("./php/header.php");
?>
    
    <noscript>
    <p><img src="./immagini/immaginivarie/attenzione.png" alt="attenzione">   Per favore attivare javascript sul browser altrimenti il contenuto non è completamente accessibile</p>
    </noscript>
<main class="content">
   
<div id="menucampionato">
    <!-- Load an icon library to show a hamburger menu (bars) on small screens -->
    <?php 
require_once("./php/connessionedb.php");
$logo="SELECT logoc,nome FROM `campionato` WHERE idcampionato='$idc';";
 $result= $DB->query($logo);
	if($result->num_rows>0){
		while($row=$result->fetch_assoc()){
			echo "
   <div id='campionato'><img src='./immagini/loghi/".$row["logoc"]."'  title='".$row["nome"]."' alt='logo ".$row["nome"]."' > </div>";
		};
	};

	?>

<div class="topnav" id="navcamp" >
<a href="#content1"  title="Notizie "id="news" class="menuHandler current">Notizie</a>
<a href="#content2" title="Partite" id="partite" class="menuHandler">Partite</a>
<a href="#content3" title="Classifica" id="classifica" class="menuHandler">Classifica</a>
</div>
    </div>
	<div>
    <div id="content1" class="active">
	<h1>Ultime Notizie</h1><br>
         <?php
		
		$sql="SELECT idnotizia,immagine,titolo FROM `notizie` WHERE (tag COLLATE UTF8_GENERAL_CI LIKE '%$idc%') ORDER BY datan DESC LIMIT 4;";
		$resultnews= $DB->query($sql);
		if($resultnews->num_rows>0){
		while($row=$resultnews->fetch_assoc()){
			echo"<div class='news' title='".$row["titolo"]."'>
        <a href='notizia.php?val=".$row["idnotizia"]."&titolo=".rawurlencode($row["titolo"])."' >
        <span class='imgContainer'>
            <img src='./immagini/news/".$row["immagine"]."' alt='fotonews'>
        </span>
            <h2 class='newsdescr'>".$row["titolo"]."</h2>
        </a>  </div>";
		};
	};

	?>
  <footer class="barranotizie"><a href="notizie.php?idc=<?php echo"$idc"?>">Vedi Altre Notizie</a></footer>
    </div>
    
    <div id="content2">
	<h1>Partite</h1><br>
        <div class="partite" >
            <table title="Ultima giornata giocata">
					<thead>
                        <tr>
							<th></th>
                        
						
                            <th>Ultima giornata</th>
                           
							
							<th></th>
						</tr>
						<tr>
							<<th title="squadra casa">Casa</th>
                            <th title="risultato">Risultato</th>	
                            <th title="squadra ospite">Ospite</th>					
						</tr>
					</thead>
					<tbody>
					<?php
				
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
                        <td title='squadracasa'><img src='./immagini/loghi/".$row["logoc"]."' alt='".$row["squadracasa"]."'>  </td>
                       
                        <td title='risultato'>".$row["golcasa"]." : ".$row["golospite"]."</td>
                       
                        <td title='squadraospite'> <img src='./immagini/loghi/".$row["logoo"]."' alt='".$row["squadraospite"]."'></td>
                        </tr>
							";
		};
	};
	
					?>
					
                       
                    </tbody>
            </table>
        </div>
        <div class="prossime">
            <table title="Prossima giornata">
              
					<thead>
                         <tr>
							<th></th>
                           
                            <th>Prossima giornata</th>
                           
                            <th></th>
						</tr>
                        <tr>    
							<th title="squadra casa">Casa</th>
						
                            <th title="orario">ora</th>
							
                            <th title="squadra ospite">Ospite</th>
						</tr>
					</thead>
					<tbody>
										<?php
			
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
                        <td title='squadracasa'><img src='./immagini/loghi/".$row["logoc"]."' alt='".$row["squadracasa"]."'>  </td>
                       
                        <td title='orario inizio'> ".$row["datap"]." ".$row["ora"]."</td>
                        
                        <td title='squadraospite'> <img src='./immagini/loghi/".$row["logoo"]."' alt='".$row["squadraospite"]."'> </td>
                        </tr>
							";
		};
	};

					?>
                    </tbody>
            </table>
        </div>
        </div>
      
    
    <div id="content3">
         <div class="wrapper">
                    <h1>Classifica</h1><br>
				<table title="Classifica">
					<thead>
						<tr>
							<th title="posizione">Pos</th>
							<th title="squadra">squadra</th>
							<th title="giocate">G</th>
							<th title="vinttorie">V</th>
							<th title="pareggi">P</th>
							<th title="sconfitte">S</th>
							<th title="punti">Punti</th>
							<th title="fatti e subiti">+/-</th>
							<th title="differenza reti">DR</th>
						</tr>
					</thead>
					<tbody>
					<?php
				
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
    partita
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
    partita
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
						<td title='posizione'>$pos</td>
						<td title='squadra'><img src='./immagini/loghi/".$row["logo"]."' width='50' height='65' alt='".$row["squadra"]."'> </td>
						<td title='giocate'>".$row["partite"]."</td>
						<td title='vittorie'>".$row["vittorie"]."</td>
						<td title='pareggi'>".$row["pareggi"]."</td>
						<td title='sconfitte'>".$row["sconfitte"]."</td>
						<td title='punti'>".$row["punti"]."</td>
						<td title='gol fatti e subiti'>".$row["golf"]."/".$row["gols"]."</td>
						<td title='differenza reti'>".$row["diff_reti"]."</td>
              </tr>
			  
			";
			$pos=$pos+1;
		};
	}
		
	$DB->close();
					?>
              
					</tbody>
				</table>
			</div>
    </div>
	</div>

    <?php
require_once("./javascript/nav.js");
?>

</main>
       
    <?php
require_once("./php/footer.html");
?>

</body>
</html>