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
        $metadata[$index]["status"] = "bad";
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

function getIndexOfEntry($mac){
    $count = 0;
    $metadata = getMetadata();
    foreach($metadata as $key => $value){
        if($value["mac"]==$mac){
            break;
        }
        $count++;
    }
    return $count;
}

function changeName($mac, $name){
    $metadata = getMetadata();
    $count = getIndexOfEntry($mac);
    $metadata[$count]["name"] = $name;
    file_put_contents("metadata.json", json_encode($metadata));
}

function getName($mac){
    $metadata = getMetadata();
    $count = getIndexOfEntry($mac);
    return $metadata[$count]["name"];
}

function changeStatus($mac, $status){
    $metadata = getMetadata();
    $count = getIndexOfEntry($mac);
    $metadata[$count]["status"] = $status;
    file_put_contents("metadata.json", json_encode($metadata));
}

function getStatus($mac){
    $metadata = getMetadata();
    $count = getIndexOfEntry($mac);
    return $metadata[$count]["status"];
}

function changeLastSendDate($mac, $date){
    $metadata = getMetadata();
    $count = getIndexOfEntry($mac);
    $metadata[$count]["last-sent"] = $date;
    file_put_contents("metadata.json", json_encode($metadata));
}

function getLastSendDate($mac){
    $metadata = getMetadata();
    $count = getIndexOfEntry($mac);
    return $metadata[$count]["last-sent"];
}

?>