<?php

function addMac($mac){
    if(!macExists($mac)){
        $naming = getNaming();
        $newName["mac"] = $mac;
        $newName["name"] = $mac;
        array_push($naming, $newName);
        file_put_contents("status.json", json_encode($naming));
    }
}

function addName($mac, $name){
    $naming = getNaming();
    $count = 0;
    foreach($naming as $key => $value){
        if($value["mac"]==$mac){
            $naming[$count]["name"] = $name;
        }
        $count++;
    }
    file_put_contents("status.json", json_encode($naming));
}

function macExists($mac){
    $exists = false;
    $naming = getNaming();
    foreach($naming as $name){
        if($name["mac"]==$mac){
            $exists = true;
        }
    }
    return $exists;
}

function getNaming(){
    $namingJson = file_get_contents('status.json');
    $naming = json_decode($namingJson, true);
    return $naming;
}

function getName(){

}

?>