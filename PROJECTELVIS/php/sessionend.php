<?php
// remove all session variables
session_start();
unset($_SESSION['username']);
// destroy the session 
header("Location: ../php/login.php");
?>