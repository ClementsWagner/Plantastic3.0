<?php






function getPassword(){
    $password = file_get_contents("GmailPassword.txt");
    return $password;
}


?>