<?php
session_start();
if (!isset($_SESSION["username"])){
  header("Location: ./login.php");
}

	?>
<!DOCTYPE html>
<html lang="it">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>EliminaNews Easyfootball</title>
    <link rel="stylesheet" type="text/css" href="./css/body.css">
	<link rel="stylesheet" type="text/css" href="./css/deletenews.css">
	<link rel="stylesheet" type="text/css" href="./css/print.css" media="print"> 
</head>
<body>
<?php
require_once("./php/header.php");
?>
<main id="contprinc" class="content">
<h1>Seleziona o cerca una notiza da eliminare</h1>
<form method="get" action="./deletenews.php">
<input type="text" name="keyword" placeholder="Inserire una parola chiave o tag" title="Ricerca una notizia"/>
<input type="submit" title="cerca notizia"value="Cerca"/>
</form><br>
 <table title="tabella notizie">
  					<thead>
                        <tr>
                            <th>Inizio Tabella Notizie</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
					<?php
					require_once("./php/connessionedb.php");
				$query="SELECT idnotizia, titolo from notizie order by datan DESC;";
					if(isset($_GET["keyword"])){
				$query="SELECT idnotizia, titolo from notizie WHERE titolo OR tag COLLATE UTF8_GENERAL_CI like '%".$_GET["keyword"]."%';";
					}
				 $result= $DB->query($query);
					if($result->num_rows>0){
						while($row=$result->fetch_assoc()){
							echo "
							 <tr>
                        <td><a href='notizia.php?val=".$row["idnotizia"]."&titolo=".rawurlencode($row["titolo"])."' title='".$row["titolo"]."'>".$row["titolo"]."</a> </td>
                       
                        <td>
						<form method=\"POST\" action=\"./php/deleten.php\">
						<input type=\"hidden\" name=\"idNotizia\" value=".$row["idnotizia"].">
						<input title='elimina notizia' type=\"submit\" value=\"Elimina\"/>
						</form>
						</td>
                        </tr>
							";
		};
	}
	else{
		echo"<h2>nessuna notizia trovata</h2>";
	}
	
	$DB->close();
					?></tbody>
					<tfoot>
					<tr>
                            <th>Fine Tabella Notizie</th>
							<th></th>
						</tr>
					</tfoot>
</table> 

</main>
<?php
require_once("./php/footer.html");
?>
</body>
</html>