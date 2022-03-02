<?php
//Activat errors for development comment for production
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


//Make sure that the content type of the POST request has been set to application/json
$contentType = isset($_SERVER["CONTENT_TYPE"]) ? trim($_SERVER["CONTENT_TYPE"]) : '';
if(strcasecmp($contentType, 'application/json') != 0){
    throw new Exception('Content type must be: application/json');
}

//Receive the RAW post data.
$content = trim(file_get_contents("php://input"));

//Attempt to decode the incoming RAW post data from JSON.
$decoded = json_decode($content, true);

//If json_decode failed, the JSON is invalid.
if(!is_array($decoded)){
    throw new Exception('Received content contained invalid JSON!');
}

//Process the JSON.

$date = new DateTime('now', new DateTimeZone('Europe/Berlin'));
$formatDate = strval(date_format($date, 'd-m-Y H:i:s'));

$decoded += ["DateTime" => $formatDate];

$content = json_encode($decoded);

$filestatus = file_put_contents("plantasticdata.json", $content . ",", FILE_APPEND);

