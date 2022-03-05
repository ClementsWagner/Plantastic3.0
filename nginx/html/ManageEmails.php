<?php

if($_SERVER['REQUEST_METHOD'] == "POST" and isset($_POST['add']))
{
    addEmail($_POST['email']);
}

if($_SERVER['REQUEST_METHOD'] == "GET" and isset($_GET['email']))
{
    removeEmail($_GET['email']);
}


function getEmails(){
    $emailString = file_get_contents('emails.csv');
    if($emailString==""){
        $emailList = [];
    }
    else{
        $emailList = explode(';', $emailString);
    }

    return $emailList;
}

function getNumberOfEmails(){
    return count(getEmails());
}

function addEmail($email){
    $numberOfEmails = getNumberOfEmails();
    if($numberOfEmails==0){
        file_put_contents('emails.csv', $email, FILE_APPEND);
    }
    else{
        file_put_contents('emails.csv', ';' . $email, FILE_APPEND);
    }
    
}

function removeEmail($del_email){
    $emailList = getEmails();
    if (($key = array_search($del_email, $emailList)) !== false) {
        unset($emailList[$key]);
    }
    $emailString = "";
    foreach($emailList as $email){
        $emailString = $emailString . $email . ';';
    }
    file_put_contents('emails.csv', substr($emailString,0,-1));
}

?>