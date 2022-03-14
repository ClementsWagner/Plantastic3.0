<?php
    require('ManageNames.php');

    function setStatus($mac, $status){
        $statuses = getStatuses();
        $count = 0;
        foreach($statuses as $key => $value){
            if($value["mac"]==$mac){
                $statuses[$count]["status"] = $status;
            }
            $count++;
        }
        file_put_contents("status.json", json_encode($statuses));
    }

    function getStatuses(){
        $statusJson = file_get_contents('status.json');
        $status = json_decode($statusJson, true);
        return $status;
    }
?>