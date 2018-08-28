<?php
if (session_status() == PHP_SESSION_ACTIVE) {
  header("Location: ../php/admin.php");
}

session_start();
if (isset($_SESSION["username"])){
  header("Location: ../php/admin.php");
}
?>
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
    
<?php
include'../php/header.php';
?>
    
    
<main class="content">
   <div class="login-page">
  <div class="form">
  
    <form method="POST" class="login-form" action="validatelogin.php">
      <input type="text" placeholder="username" name="username" required>
      <input type="password" placeholder="password" name="userpass" required>
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

        <script>
       $('.message a').click(function(){
   $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
});    
    </script>
  </div>
       
</div>
 
</main>
<?php
include'../php/footer.php';
?>
</body>
        
</html>