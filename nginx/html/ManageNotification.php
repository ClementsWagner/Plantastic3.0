<?php
    require ('Mailer.php');
    

    function notifyUser($dataSet){
        $lastSent = new DateTime(getLastSendDate($dataSet["mac"]));
        $currentTime = new DateTime('now');
        $diff = getTimeDifferenceInHours($lastSent, $currentTime);
        if($diff>24){
            $subject = 'Eine Ihrer Pflanzen benoetigt fuersorge!';
        
            $hum = ($dataSet['humidity']>600);
            $temp =  ($dataSet['temperature']<0);
            $light = ($dataSet['light']<10);
    
            $text = getEmailBody($hum, $light, $temp);
            sendEmails($subject, $text);
    
            echo $text;
            changeLastSendDate($dataSet["mac"], $currentTime->format('Y-m-d H:i:s'));
        }
    }

    function getEmailBody($hum, $light, $temp){
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
        $text = $text . '!';
        return $text;
    }


    function getTimeDifferenceInHours($start, $end){
        $diff = $start->diff($end);

        $hours = $diff->h;
        $hours = $hours + ($diff->days*24);

        return $hours;
    }
?>