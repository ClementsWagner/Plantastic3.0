<?php
    require ('Mailer.php');
    require_once ('ManageMetadata.php');
    include_once ('ManageStatus.php');

    function notifyUser($dataSet, $oldStatus){
        $newStatus = getStatus($dataSet["mac"]);
        $lastSent = new DateTime(getLastSendDate($dataSet["mac"]));
        $currentTime = new DateTime('now');
        $diff = getTimeDifferenceInHours($lastSent, $currentTime);
        if($newStatus!="good"){
            if(($oldStatus!="bad" && $newStatus=="bad")) {
                if($diff>24 || ($oldStatus!="bad" && $newStatus=="bad")){
                    $subject = 'Eine Ihrer Pflanzen benoetigt fuersorge!';
                
                    $hum = $dataSet['humidity'];
                    $temp =  $dataSet['temperature'];
                    $light = $dataSet['light'];
            
                    $text = getEmailBody(getHumidityStatus($hum), getLightStatus($light), getTemperatureStatus($temp),getName($dataSet["mac"]));
                    sendEmails($subject, $text);
            
                    echo $text;
                    changeLastSendDate($dataSet["mac"], $currentTime->format('Y-m-d H:i:s'));
                }
            } 
        }
    }

    function getEmailBody($hum, $light, $temp, $name){
        $text = 'Bitte kuemmern Sie sich um Ihre Pflanze Sie hat ';
        if($hum){
            $text = $text . 'zu wenig Wasser';
        }
        if($light){
            if($hum){
                $text = $text . ', ';    
            }
            $text = $text . 'zu wenig Licht';
        }
        if($temp){
            if($hum||$light){
                $text = $text . ' und ';
            }
            $text = $text . 'eine zu niedrige Temperatur';
        }
        $text = $text . "!\n";
        $text = $text . 'Pflanze: ' . $name;
        return $text;
    }


    function getTimeDifferenceInHours($start, $end){
        $diff = $start->diff($end);

        $hours = $diff->h;
        $hours = $hours + ($diff->days*24);

        return $hours;
    }
?>