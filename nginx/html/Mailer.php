<?php
require ('PHPMailer-master/src/PHPMailer.php');
require ('PHPMailer-master/src/SMTP.php');
require ('PHPMailer-master/src/Exception.php');


function sendEmail($recipient, $subject, $content){
    $mail = new \PHPMailer\PHPMailer\PHPMailer();
    $mail->IsSMTP();  // Telling the class to use SMTP  
    
    $mail->SMTPAuth = true;
    $mail->SMTPSecure = "ssl";
    $mail->Host     = "smtp.gmail.com"; // SMTP server
    $mail->Username = "plantasticnotifier@gmail.com"; // "The account"
    $mail->Password = getPassword(); // "The password"
    $mail->Port = 465; // "The port"
    $mail->Subject  = $subject; // "The subject"
    $mail->Body     = $content; // "The message."
    $mail->WordWrap = 100; // "The lenght of the text."  
    $mail->addAddress($recipient);

    $mail->Send()
    $_POST = array();
}



function getPassword(){
    $password = file_get_contents("GmailPassword.txt");
    return $password;
}
?>