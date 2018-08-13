<!DOCTYPE html>
<html>	
    <head>
<meta charset="UTF-8">  
<title>Login</title>
<link rel="stylesheet" type="text/css" href="../css/body.css">
<link rel="stylesheet" type="text/css" href="../css/login.css">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <script>
       $('.message a').click(function(){
   $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
});    
    </script>
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
        <div class=utentelog><div id="registrazione"><div id="login"> <a href="login.php">Login/Registati</a> </div></div>
        </div>
    </div>
	
    </header>
    
    
<main class="content">
   <div class="login-page">
  <div class="form">
    <form method="POST" class="register-form">
      <input type="text" placeholder="nome" name="user" required>
      <input type="password" placeholder="password" name="pass" required>
      <input type="text" placeholder="email address" name="email" required>
        <input type="text" placeholder="squadrapreferita" name="squadra" required>
      <button>create</button>
      <p class="message">Già registrato?<a href="#">Sign In</a></p>
    </form>
    <form method="POST" class="login-form" action="validatelogin.php">
      <input type="text" placeholder="username" name="username" required>
      <input type="password" placeholder="password" name="userpass" required>
      <button type="submit" name="login" >login</button>
      <p class="message">Non registrato? <a href="#">Create an account</a></p>
    </form>
        <script>
       $('.message a').click(function(){
   $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
});    
    </script>
  </div>
       
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