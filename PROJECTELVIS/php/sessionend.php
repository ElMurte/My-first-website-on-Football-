<?php
// remove all session variables
session_start();
session_unset($_SESSION['username']);
// destroy the session 
session_destroy();
header("Location: ../php/login.php");
?>