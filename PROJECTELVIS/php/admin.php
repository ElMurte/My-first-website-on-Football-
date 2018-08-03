<?PHP
require_once("./include/membersite_config.php");
if(!$fgmembersite->CheckLogin())
{

    $fgmembersite->RedirectToURL("login.php");

    exit;
?>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
        <div class=utentelog><div id="registrazione"><div id="login"> <a href="login.html">Login/Registati</a> </div></div>
        
        </div>
    </div>
	
    </header>
    
<main class="content">

    <h1>Aministrazione Dati</h1>
			<div class="admin">
					<div class="insertNews">
						<h3>AGGIUNGI notizia</h3>
                        <form action="upload.php" method="post" enctype="multipart/form-data">
                            Seleziona l'immagine da caricare:
                            <input type="file" name="fileToUpload" id="fileToUpload">
                            <br></br>
                            <input type="submit" value="Upload Image" name="submit">
                        </form>
                         <br></br>
                                <form>
                                     <label for="titolo">titolo notizia:</label><br>
                                     <input name="titolo" id="titolo">
                                    </form>
                                      <form>
                                         <label for="nome-img">nome immagine caricata:</label><br>
                                         <input name="nome-img" id="immagine">
                                        </form>
                                            <form>
                                             <label for="contenuto-news">contenuto:</label><br>
                                             <input name="contenuto-news" id="contenuto">
                                            </form>
                                            <label for="tag-notizia">tag</label><br>
                                             <input type="text" name="tag-notizia" id="tag">
                                            </form>
                            <br></br>
							<button type="submit" name="inserisci">Inserisci</button>
					</div>
				
                            <div class="del">
                                <h3>ELIMINA notizia</h3>
                                <form method="POST" action="">
                                    <label for="elimnews">id della notizia da eliminare:</label>
                                    <input type="text" name="elimnews" id="news"><br></br>
                                    <button type="submit" name="submit">Delete</button>
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