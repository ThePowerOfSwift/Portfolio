<?php
session_start();
ob_start();

$client_id = 'ENTER CLIENT ID HERE';
$client_secret = 'ENTER CLIENT SECRET HERE';
$redirect_uri = 'http://localhost:8888/includes/instagram_login.php';
$scope = 'basic+likes+comments+relationships';

$url = "https://api.instagram.com/oauth/authorize?client_id=$client_id&redirect_uri=$redirect_uri&scope=$scope&response_type=code";

$ch = curl_init($url);
//curl_setopt($ch, CURLOPT_HTTPHEADER, array('Accept: application/json'));
//curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_exec($ch);
curl_close($ch);

//var_dump($jsonData);
$user = json_decode($jsonData); 


//print_r($user);
var_dump($ch);
exit;

?>