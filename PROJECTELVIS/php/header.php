<header id="header">
<h1><a href="home.php"><img src="../immagini/loghi/logooff.png" alt="logo Easyfootball"></a> Easyfootball</h1>
    <div id="boxuf">
    <div class="wrap">
        <div class="search">
            <form action="search.php" method="get"> 
        <input type="text" class="searchTerm" placeholder="Ricerca Squadre o Campionati" name="query" title="Barra Ricerca">
        <button type="submit" class="searchButton" value="search" title="Bottone Ricerca" onsubmit="<a href='search.php?query='$query'</a>" >
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