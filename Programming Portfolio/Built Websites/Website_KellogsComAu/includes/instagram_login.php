<?php

session_start();
ob_start();

$client_id = 'ENTER CLIENT ID HERE';
$client_secret = 'ENTER CLIENT SECRET HERE';
$redirect_uri = 'http://localhost:8888/includes/instagram_login.php';
$scope = 'basic+likes+comments+relationships';

$url = "https://api.instagram.com/oauth/authorize?client_id=$client_id&redirect_uri=$redirect_uri&scope=$scope&response_type=code";

if(!isset($_GET['code']))
{
    echo '<a href="'.$url.'">Login With Instagram</a>';

}
else
{

$code = $_GET['code'];
$user = array();
$result = array();
$apiData = array(
  'client_id'       => $client_id,
  'client_secret'   => $client_secret,
  'grant_type'      => 'authorization_code',
  'redirect_uri'    => $redirect_uri,
  'code'            => $code
);

$apiHost = 'https://api.instagram.com/oauth/access_token';

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $apiHost);
curl_setopt($ch, CURLOPT_POST, count($apiData));
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($apiData));
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Accept: application/json'));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
$jsonData = curl_exec($ch);
curl_close($ch);

//var_dump($jsonData);
$user[] = json_decode($jsonData,true); 
file_put_contents("../JSON/instagramUser.json",json_encode($user));    
    

// Instagram API
$token = $user[0]['access_token'];
$apiReq = 'https://api.instagram.com/v1/users/self/media/recent/?access_token='.$token;
    
$cP = curl_init();
curl_setopt($cP, CURLOPT_URL, $apiReq);
curl_setopt($cP, CURLOPT_RETURNTRANSFER, true);
curl_setopt($cP, CURLOPT_HTTPHEADER, array('Accept: text/html'));
$result = curl_exec($cP);
curl_close($cP);
$posts = json_decode($result,true); 

    
echo '<pre>';
$embededData = array();
$html = array();
for($i = 0; $i < 20; $i++){    

    $embededData = file_get_contents("https://api.instagram.com/oembed?url=".$posts['data'][$i]['link']);
    $html = json_decode($embededData,true);
    $posts["data"][$i]["htmlData"] = $html["html"];
}
    print_r($embededData);
    print_r($posts["data"]);
echo '</pre>'; 

file_put_contents("../JSON/instagramContent.json",json_encode($posts));
header("Location: ../includes/admin.php?alert=InstagramUpdated");
exit;
}
?>


