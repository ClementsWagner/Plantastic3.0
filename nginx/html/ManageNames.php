<?php

function changeName($mac, $name){
    $naming = getNaming();
    $count = 0;
    foreach($naming as $key => $value){
        if($value["mac"]==$mac){
            $naming[$count]["name"] = $name;
        }
        $count++;
    }
    file_put_contents("metadata.json", json_encode($naming));
}

function getName(){

}

?>