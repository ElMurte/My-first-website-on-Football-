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
        <div class=utentelog><div id="registrazione">
		<?php include '../php/log.php'?>
		</div>
        
        </div>
    </div>
	
    </header>
    
<main class="content">
<span class="errormessage"><?php 
if(isset($_SESSION["message"])) {
    echo $_SESSION["message"];
    unset($_SESSION["message"]);
}
?></span>
    <h1>Aministrazione Dati</h1>
			<div class="admin">
					<div class="insertNews">
						<h3>AGGIUNGI notizia</h3>
                        <form action="upload.php" method="post" enctype="multipart/form-data">
                            Seleziona l'immagine da caricare:
                            <input type="file" name="fileToUpload" id="fileToUpload" required><br>

							<label for="id-not">id notizia:</label><br>
                                         <input type="text" placeholder="ex(not0000007)"name="idnot" id="idnot" required><br>
										 <br>
										  
                      
                                     <label for="titolo">titolo notizia:</label><br>
                                     <input name="titolo" id="titolo" required><br>
									 
                                             <label for="contenuto-news">contenuto:</label><br>
                                             <input name="contenutonews" id="contenutonews" required><br>
                                          
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
                                    <input type="text" name="elimnews" id="elimnews"><br></br>
                                    <input type="submit" name="submitd" value="elimina">
                                </form>	
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