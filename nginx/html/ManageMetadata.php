<?php 

function getMetadata(){
    $metadataJson = file_get_contents('metadata.json');
    $metadata = json_decode($metadataJson, true);
    if($metadata == NULL){
        $metadata = array();
    }
    return $metadata;
}

function addMetadataEntry($mac){
    if(!macExists($mac)){
        $metadata = getMetadata();
        
        $index = count($metadata);

        $metadata[$index]["mac"] = $mac;
        $metadata[$index]["name"] = $mac;
        $metadata[$index]["status"] = "good";
        $metadata[$index]["last-sent"] = "1970-01-01 00:00:00";
        
        file_put_contents("metadata.json", json_encode($metadata));
    }
}

function macExists($mac){
    $exists = false;
    $metadata = getMetadata();
    foreach($metadata as $entry){
        if($entry["mac"]==$mac){
            $exists = true;
        }
    }
    return $exists;
}


function changeName($mac, $name){
    $naming = getMetadata();
    $count = 0;
    foreach($naming as $key => $value){
        if($value["mac"]==$mac){
            $naming[$count]["name"] = $name;
        }
        $count++;
    }
    file_put_contents("metadata.json", json_encode($naming));
}

?>