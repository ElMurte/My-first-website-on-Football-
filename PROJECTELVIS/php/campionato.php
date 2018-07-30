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
<h1><a href="home.php"><img src="../immagini/loghi/logooff.png" alt="logo" lang="it"></a> Easyfootball</h1>
    <div id="boxuf">
    <div class="wrap">
        <div class="search">
        <input type="text" class="searchTerm" placeholder="Ricerca Squadre o Campionati">
        <button type="submit" class="searchButton">
        <i class="fa fa-search"></i> 
       </button>
        </div>
    </div>
        <div class=utentelog><div id="registrazione"><div id="login"> <a href="login.html">Login/Registati</a> </div></div>
        
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
		$sql="SELECT idnotizia,immagine,titolo FROM `notizie` WHERE (tag LIKE '%$idc%') ORDER BY datan DESC LIMIT 4;";
		$resultnews= $DB->query($sql);
		if($result->num_rows>0){
		while($row=$resultnews->fetch_assoc()){
			echo"<div class='news'>
        <a href='notizia.php?val=".$row["idnotizia"]."' >
        <span class='imgContainer'>
            <img src='../immagini/news/".$row["immagine"]."' alt='fotonews'>
        </span>
            <span class='newsdescr'>".$row["titolo"]."</span>
        </a>
        </div>";
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
                            <th></th>
                            <th>Giornata 1</th>
                            <th></th>
                            <th></th>
						</tr>
						<tr>
							<th>Casa</th>
							<th>GC</th>
                            <th></th>
							<th>GO</th>
                            <th>Ospite</th>
						</tr>
					</thead>
					<tbody>
                        <tr>
                        <td><img src="../immagini/loghi/Milan.png">  </td>
                        <td>4</td>
                        <td> : </td>
                        <td>7</td>
                        <td> <img src="../immagini/loghi/Juventus.png"> </td>
                        </tr>
                    </tbody>
            </table>
        </div>
        <div class="prossime">
            <table>
              
					<thead>
                         <tr>
							<th></th>
                            <th></th>
                            <th>prossima giornata</th>
                            <th></th>
                            <th></th>
						</tr>
                        <tr>    
							<th>Casa</th>
							<th>GC</th>
                            <th></th>
							<th>GO</th>
                            <th>Ospite</th>
						</tr>
					</thead>
					<tbody>
                        <tr>
                        <td><img src="../img/loghi/Milan.png">  </td>
                        <td>1</td>
                        <td> : </td>
                        <td>1</td>
                        <td> <img src="../img/loghi/Juventus.png"> </td>
                        </tr>
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
							<th>Posizione</th>
							<th>Squadra</th>
							<th>Punti</th>
							<th>+/-</th>
						</tr>
					</thead>
					<tbody>
						<tr>
                <td class="rank">1</td>
                <td class="team">Spain</td>
                <td class="points">1460</td>
                <td class="up-down">0</td>
              </tr>
              
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