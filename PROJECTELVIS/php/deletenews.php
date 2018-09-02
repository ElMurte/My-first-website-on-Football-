<?php
session_start();
if (!isset($_SESSION["username"])){
  header("Location: ../php/login.php");
}

	?>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Home</title>

    <link rel="stylesheet" type="text/css" href="../css/body.css">
	<link rel="stylesheet" type="text/css" href="../css/deletenews.css">
</head>
<body>
<?php
include'../php/header.php';
?>
<main class="content">
<h1>Seleziona o cerca una notiza da eliminare</h1>
<form method="get" action="deletenews.php">
<input type="text" name="keyword" placeholder="Inserire una parola chiave"/>
<input type="submit" value="Cerca"/>
</form><br>
 <table>
  					<thead>
                        <tr>
                            <th>Titolo Notizia</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
					<?php
					include '../php/connessionedb.php';
				$query="SELECT idnotizia, titolo from notizie order by datan DESC;";
					if(isset($_GET["keyword"])){
				$query="SELECT idnotizia, titolo from notizie WHERE titolo OR tag COLLATE UTF8_GENERAL_CI like '%".$_GET["keyword"]."%';";
					}
				 $result= $DB->query($query);
					if($result->num_rows>0){
						while($row=$result->fetch_assoc()){
							echo "
							 <tr>
                        <td><a href='notizia.php?val=".$row["idnotizia"]."'>".$row["titolo"]."</a> </td>
                       
                        <td>
						<form method=\"POST\" action=\"deleten.php\">
						<input type=\"hidden\" name=\"idNotizia\" value=".$row["idnotizia"].">
						<input type=\"submit\" value=\"Elimina\"/>
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
                            <th>Fine Notizie</th>
							<th></th>
						</tr>
					</tfoot>
</table> 

</main>
<?php
include'../php/footer.php'
?>
    
</footer>

</body>
</html>