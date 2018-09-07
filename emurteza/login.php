<?php
if (session_status() == PHP_SESSION_ACTIVE) {
  header("Location: ./admin.php");
}

session_start();
if (isset($_SESSION["username"])){
  header("Location: ./admin.php");
}
?>
<!DOCTYPE html>
<html lang="it">	
    <head>
<meta charset="UTF-8">  
<title>Login</title>
<link rel="stylesheet" type="text/css" href="./css/body.css">
<link rel="stylesheet" type="text/css" href="./css/login.css">
<link rel="stylesheet" type="text/css" href="./css/print.css" media="print"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   
</head>
<body>
    
<?php
require_once("./php/header.php");
?>
    
    
<main id="contprinc" class="content">
   <div class="login-page">
  <div class="form">
  
    <form method="POST" class="login-form" action="./php/validatelogin.php">
      <input type="text" placeholder="username" name="username" title="nomeutente"required>
      <input type="password" placeholder="password" name="userpass" title="password"required>
      <button type="submit" name="login" >login</button>
      <p class="message">Solo per moderatori</p>
	  	<span class="error">
<?php 

	if(isset($_SESSION["logerror"])) {
   $error=$_SESSION["logerror"];
    unset($_SESSION["logerror"]);
echo"$error";
	}
?>	</span>
    </form>

  </div>
       
</div>
 
</main>
<?php
require_once("./php/footer.html");;
?>
</body>
        
</html>