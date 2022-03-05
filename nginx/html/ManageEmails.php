<?php

$emailErr = "";

if($_SERVER['REQUEST_METHOD'] == "POST" and isset($_POST['add']))
{
    if(isEmailValid($_POST['email'])){
        addEmail($_POST['email']);
    }
    else{
        $emailErr = "Please enter a valid email!";
    }
    
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
    $emailList = getEmails();
    $numberOfEmails = count($emailList);
    $exists = false;
    foreach($emailList as $var){
        if($email == $var){
            $exists = true;
        }
    }
    if(!$exists){
        if($numberOfEmails==0){
            file_put_contents('emails.csv', $email, FILE_APPEND);
        }
        else{
            file_put_contents('emails.csv', ';' . $email, FILE_APPEND);
        }
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

function isEmailValid($email){
    if(strpos($email, '@')){
        return true;
    }else{
        return false;
    }
}

?>