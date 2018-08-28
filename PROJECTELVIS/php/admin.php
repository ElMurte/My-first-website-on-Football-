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

<title>Notizia</title>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/body.css">
    <link rel="stylesheet" type="text/css" href="../css/campionato.css">
    <link rel="stylesheet" type="text/css" href="../css/admin.css">
	
</head>
<body>
<?php
include'../php/header.php';
?>
    
<main class="content">
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
						<h3>AGGIUNGI notizia</h3>
                        <form action="upload.php" method="post" enctype="multipart/form-data">
                            Seleziona l'immagine da caricare:
                            <input type="file" name="fileToUpload" id="fileToUpload" required><br>

					
										 <br>
										  
                      
                                     <label for="titolo">titolo notizia:</label><br>
                                     <input name="titolo" id="titolo" required><br>
									 
                                             <label for="contenuto-news">contenuto:</label><br>
                                             <textarea name="contenutonews" id="contenutonews" required></textarea><br>
                                          
                                            <label for="tag-notizia">tag:</label><br>
                                             <input type="text" placeholder="seriea,bignews..." name="tagnotizia" id="tag" required>
                            <br></br>
							<input type="submit" value="Inserisci" name="submit"><br>
									</form>
								
					</div>
				
                            <div class="del">
                                <h3>ELIMINA notizia</h3>
                                <form action="deleten.php" method="post" >
                                    <label for="elimnews">id della notizia da eliminare:</label>
                                    <input type="text" name="elimnews" id="elimnews" required><br></br>
                                    <input type="submit" name="submitd" value="elimina">
									<h4><?php 

	if(isset($_SESSION["deln"])) {
   $succ=$_SESSION["deln"];
    unset($_SESSION["deln"]);
	echo"<h4>$succ</h4>";
	}
	else{

	if(isset($_SESSION["errdeln"])) {
   $error1=$_SESSION["errdeln"];
    unset($_SESSION["errdeln"]);
	echo"$error1";
	}
	}
?>	</h4>
                                </form>	
                            </div>
</main>
    
    <?php
include'../php/footer.php'
?>
   </body>
</html>