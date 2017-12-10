<?php
$jsonFB = array();
$jsonSC = array();
$jsonTwitter = array();
$jsonInsta = array();
//Save Facebook data to JSON file
if($_POST['data']) {
    $jsonFB[] = json_decode($_POST['data']);
    file_put_contents("../JSON/socialContent.json",json_encode($jsonFB)); 
} else {
    echo "No Facebook Data";
}
//Save Soundcloud data to JSON file
if($_POST['SC']) {
    $jsonSC[] = json_decode($_POST['SC']);
    file_put_contents("../JSON/soundContent.json",json_encode($jsonSC)); 
} else {
    echo "No SoundCloud Data";
}
//Save Soundcloud data to JSON file
if($_POST['Twitter']) {
    $jsonTwitter[] = json_decode($_POST['Twitter']);
    file_put_contents("../JSON/twitterContent.json",json_encode($jsonTwitter)); 
    echo json_decode($_POST['Twitter']);
} else {
    echo "No Twitter Data";
}
//Save InstagramHtml data to JSON file
if($_POST['instaHtml']) {
    $jsonInsta[] = json_decode($_POST['Twitter']);
    file_put_contents("../JSON/twitterContent.json",json_encode($jsonTwitter)); 
    echo json_decode($_POST['instaHtml']);
} else {
    echo "No Instagram Data";
}
?>