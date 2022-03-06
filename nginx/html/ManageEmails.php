<?php

$emailErr = "";

if($_SERVER['REQUEST_METHOD'] == "POST" and isset($_POST['add']))
{
    if(!isEmailDistinct($_POST['email'])){
        $emailErr = "This email already exists!";
    }
    else if(!isEmailValid($_POST['email'])){
        $emailErr = "Please enter a valid email!";
    }
    else{
        addEmail($_POST['email']);
        $_POST = array();
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

function isEmailValid($email){
    if(strpos($email, '@')){
        $splitMail = explode('@', $email);
        if(count($splitMail) == 2 and strpos($splitMail[1], '.')){
            return true;
        }
        else{
            return false;
        }
    }else{
        return false;
    }
}

function isEmailDistinct($email){
    $emailList = getEmails();
    $distinct = true;
    foreach($emailList as $var){
        if($email == $var){
            $distinct = false;
        }
    }
    return $distinct;
}

?>