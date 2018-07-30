<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Risultati</title>
     <link rel="stylesheet" type="text/css" href="../css/search.css">
</head>
<body>

<?php
include '../php/connessionedb.php';
 $query=false;
   if (isset($_GET['query']))
	   $query = $_GET['query']; 
    // gets value sent over search form
    
    // $min_length = 2; you can set minimum length of the query if you want
     
    if(strlen($query)>= 2){ // if query length is more or equal minimum length then
         
		 $query = mysqli_real_escape_string($DB,$query);
        // makes sure nobody uses SQL injecti

        $result="SELECT logoc as logo,nome FROM `campionato` 
		where nome COLLATE UTF8_GENERAL_CI LIKE '%$query%' 
		UNION 
		SELECT logo,nome FROM `Squadra` where nome COLLATE UTF8_GENERAL_CI LIKE '%$query%' ";
         $rawresults=$DB->query($result);
        // * means that it selects all fields, you can also write: `id`, `title`, `text`
        // articles is the name of our table
         
        // '%$query%' is what we're looking for, % means anything, for example if $query is Hello
        // it will match "hello", "Hello man", "gogohello", if you want exact match use `title`='$query'
        // or if you want to match just full word so "gogohello" is out use '% $query %' ...OR ... '$query %' ... OR ... '% $query'
         
        if(($rawresults)->num_rows > 0){ // if one or more rows are returned do following
             
           while($row=$rawresults->fetch_assoc()){
            // $results = mysql_fetch_array($raw_results) puts data from database into array, while it's valid it does the loop
             
                echo "<p><h3>".$row['logo']."</h3>".$row['nome']."</p>";
                // posts results gotten from database(title and text) you can also show id ($results['id'])
            }
             
        }
        else{ // if there is no matching rows do following
            echo "Nessun risultato";
        }
         
    }
    else{ // if query length is less than minimumecho "la lunghezza minima per cercare è di 2";
        
    }
?>
    <main class="risultati">
    
    </main>
</body>
</html>