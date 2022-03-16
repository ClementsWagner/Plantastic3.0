<?php 
    require_once "ManageMetadata.php";

    if($_SERVER['REQUEST_METHOD'] == "GET" and isset($_GET['status']))
    {
        echo json_encode(getMetadata());
    }

    function getPlantStatus($dataset){
        $status = "good";
        $hum = getHumidityStatus($dataset['humidity']);
        $temp =  getTemperatureStatus($dataset['temperature']);
        $light = getLightStatus($dataset['light']);

        if($hum){
            if($dataset['humidity']>600 || $dataset['humidity']<400){
                $status = "bad";
            }
            else if($status != "bad"){
                $status = "ok";
            }
        }
        if($temp){
            if($dataset['temperature']<0){
                $status = "bad";
            }else if($status != "bad"){
                $status = "ok";
            }
        }

        return $status;
    }

    function getHumidityStatus($humidity){
        return ($humidity>500||$humidity<300);
    }

    function getTemperatureStatus($temp){
        return ($temp<4);
    }

    function getLightStatus($light){
        return ($light<10);
    }
?>