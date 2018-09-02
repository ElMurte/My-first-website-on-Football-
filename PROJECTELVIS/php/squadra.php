
<?php
session_start();
include '../php/connessionedb.php';
$squadra=$_GET["squadra"];
	$idc=$_GET["idc"];
?>
<!DOCTYPE html>
<html lang=it>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?php echo"$squadra-Easyfootball";?> </title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <link rel="stylesheet" type="text/css" href="../css/body.css">
    <link rel="stylesheet" type="text/css" href="../css/campionato.css">
    <link rel="stylesheet" type="text/css" href="../css/squadra.css">
	<link rel="stylesheet" type="text/css" href="../css/print.css" media="print">
</head>
<body>
<?php
include'../php/header.php';
?>
<main class="content">
    <div id="menucampionato">
	 <?php 
include '../php/connessionedb.php';
$logo="SELECT logo,nome FROM `squadra` WHERE nome='$squadra';";
 $result= $DB->query($logo);
	if($result->num_rows>0){
		while($row=$result->fetch_assoc()){
			echo "
  <img src='../immagini/loghi/".$row["logo"]."' alt='logo ".$row["nome"]."' >";
		};
	};

	?>
<div class="topnav" id="navcamp" >
<a href="#content1" id="news" class="menuHandler current">Notizie</a>
<a href="#content2" id="partite" class="menuHandler">Prossime Partite</a>
<a href="#content3" id="classifica" class="menuHandler">Classifica</a>
</div>
    </div>
    <div id="content1" class="active">
	<h1>Ultime Notizie</h1><br>
       <?php
		include '../php/connessionedb.php';
		$sql="SELECT idnotizia,immagine,titolo FROM notizie where tag COLLATE UTF8_GENERAL_CI LIKE '%$squadra%' OR '%$idc%' ORDER BY datan DESC LIMIT 8;";
		$resultnews= $DB->query($sql);
		if($resultnews->num_rows>0){
		while($row=$resultnews->fetch_assoc()){
			echo"<div class='news'>
        <a href='notizia.php?val=".$row["idnotizia"]."&titolo=".$row["titolo"]."' >
        <span class='imgContainer'>
            <img src='../immagini/news/".$row["immagine"]."' alt='fotonews'>
        </span>
            <h2 class='newsdescr'>".$row["titolo"]."</h2>
        </a>  </div>";
		};
	};
	$DB->close();
	?>
       
    </div>
    
    
    <div id="content2">
	<h1>Partite</h1><br>
        <div class="partite">
            <table title="Ultima partita giocata">
			
					<thead>
					<tr>
							<th></th>
                            <th>Ultima Parita</th>
                            <th></th>
						</tr>
						<tr>
							<th>Casa</th>
                            <th>risultato</th>
                            <th>Ospite</th>
						</tr>
					</thead>
					<tbody>
					<?php
					include '../php/connessionedb.php';
					
				$giornata="SELECT logoc,squadracasa,golcasa,golospite,logoo,squadraospite FROM
(
    SELECT logoc,squadracasa,golcasa,golospite,logoo,squadraospite FROM 
				(SELECT idpartita,logo as logoc,squadracasa,ngiornata,golcasa from (SELECT * FROM `partita` WHERE 
				campionato COLLATE UTF8_GENERAL_CI ='$idc' AND datap<CURRENT_DATE() ORDER BY datap DESC)as parti 
				join `squadra` as sqd WHERE parti.squadracasa=sqd.nome) as casa JOIN
				(SELECT idpartita,logo as logoo,squadraospite,golospite,datap,ora from 
				(SELECT * FROM `partita` WHERE campionato COLLATE UTF8_GENERAL_CI ='$idc'  AND datap<=CURRENT_DATE() 
				ORDER BY datap DESC)as parti join `squadra` as sqd WHERE parti.squadraospite=sqd.nome)as ospite 
				WHERE casa.idpartita=ospite.idpartita ORDER BY datap,ora)as p WHERE p.squadracasa='$squadra' OR p.squadraospite='$squadra' LIMIT 1;";
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
			<table title="prossima partita">
			
					<thead>
					<tr>
							<th></th>
                            <th>Prossima Partita</th>
                            <th></th>
						</tr>
						<tr>
							<th>Casa</th>
                            <th>risultato</th>
                            <th>Ospite</th>
						</tr>
					</thead>
					<tbody>
						<?php
					include '../php/connessionedb.php';
				$giornata="SELECT logoc,squadracasa,datap,ora,logoo,squadraospite FROM
(
				SELECT logoc,squadracasa,datap,ora,logoo,squadraospite FROM 
				(SELECT idpartita,logo as logoc,squadracasa,ngiornata,datap,ora from (SELECT * FROM `partita` WHERE 
				campionato COLLATE UTF8_GENERAL_CI ='$idc' AND datap>CURRENT_DATE() ORDER BY datap ASC LIMIT 10)as parti 
				join `squadra` as sqd WHERE parti.squadracasa =sqd.nome) as casa JOIN
				(SELECT idpartita,logo as logoo,squadraospite from 
				(SELECT * FROM `partita` WHERE campionato ='$idc' AND datap>CURRENT_DATE() 
				ORDER BY datap ASC LIMIT 10)as parti join `squadra` as sqd WHERE parti.squadraospite =sqd.nome)as ospite 
				WHERE casa.idpartita=ospite.idpartita)as p WHERE p.squadracasa='$squadra' OR p.squadraospite='$squadra';";
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
		<h1>Classifica</h1>
				<table title="classifica"> 
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
						<td ><img src='../immagini/loghi/".$row["logo"]."' width='50' height='65' alt='".$row["squadra"]."'> </td>
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
	<?php
include'../javascript/nav.js';
?>
</main>
     
<?php
include'../php/footer.php';
?>
   </body>
</html>