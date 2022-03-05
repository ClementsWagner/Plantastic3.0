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
    $emailList = explode(';', $emailString);
    return $emailList;
}

function getNumberOfEmails(){
    return getEmails().count();
}

function addEmail($email){
    file_put_contents('emails.csv', $email.';', FILE_APPEND);
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
    file_put_contents('emails.csv', $emailString);
}

?>