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
<form method="get" action="deletenews.php">
<input type="text" name="keyword" placeholder="Inserire una parola chiave"/>
<input type="submit" value="Cerca"/>
</form>
 <table>
  					<thead>
                        <tr>
                            <th>Titolo</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
					<?php
					include '../php/connessionedb.php';
				$query="SELECT idnotizia, titolo from notizie order by datan DESC;";
					if(isset($_GET["keyword"])){
				$query="SELECT idnotizia, titolo from notizie WHERE titolo COLLATE UTF8_GENERAL_CI like '%".$_GET["keyword"]."%';";
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
	};
	$DB->close();
					?>
					<tfoot>
					<tr>
                            <th>Titolo</th>
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