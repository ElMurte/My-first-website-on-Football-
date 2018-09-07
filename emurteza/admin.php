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

<title>Amministrazione Easyfootball</title>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="./css/body.css">
    <link rel="stylesheet" type="text/css" href="./css/admin.css">
	<link rel="stylesheet" type="text/css" href="./css/print.css" media="print"> 
</head>
<body>
<?php
require_once("./php/header.php");
?>
    
<main id="contprinc" class="content">
<br>
  	<span class="succ">
<?php 

	if(isset($_SESSION["logsucc"])) {
   $error=$_SESSION["logsucc"];
    unset($_SESSION["logsucc"]);
	echo"<h2>$error</h2>";
	}
?>	</span><br>
<span class="errnews">
								<?php
						 if(isset($_SESSION["messagefil"])) {
						   $mess=$_SESSION["messagefil"];
							unset($_SESSION["messagefil"]);
							echo"$mess";
							}echo"<br>";
								if(isset($_SESSION["imgfl"])) {
							   $mess1=$_SESSION["imgfl"];
								unset($_SESSION["imgfl"]);
								echo"$mess1";
								}
						 ?></span><br>
    <h1>Aministrazione Dati</h1>
			<div class="admin">
					<div class="insertNews">
						<h2>AGGIUNGI notizia</h2>
                        <form action="./php/upload.php" method="post" enctype="multipart/form-data">
                            Seleziona l'immagine da caricare:
                            <input type="file" name="fileToUpload" id="fileToUpload" title="file da caricare" required><br>

					
										 <br>
										  
                      
                                     <label for="titolo">titolo notizia:</label><br>
                                     <input type="text" placeholder="max 70 caratteri" title="compila questo campo con un titolo" name="titolo" id="titolo"maxlength="70" required><br>
									 
                                             <label for="contenutonotizia">contenuto:</label><br>
                                             <textarea name="contenutonews" title="contenuto della notizia" id="contenutonotizia" rows="7" cols="50"required></textarea><br>
                                          
                                            <label for="tag">tag:</label><br>
                                             <textarea placeholder="serieA,Premier League,bignews..." title="tag per linkare" name="tagnotizia" id="tag" required></textarea>
                            <br>
							<input type="submit" value="Inserisci" name="submit"><br>
									</form>
								
					</div><br>
				
                            <div class="del">                             
								<h2>Per eliminare una notizia &rarr;<a href="deletenews.php">clicca qui</a></h2>
                            </div>
							</div>
</main>
    
    <?php
require_once("./php/footer.html");
?>
   </body>
</html>