<?php
    require ('Mailer.php');

    function notifyUser($dataSet){
        $subject = 'Eine Ihrer Pflanzen benoetigt fuersorge!';
        
        $hum = ($dataSet['humidity']>600);
        $temp =  ($dataSet['temperature']<0);
        $light = ($dataSet['light']<10);

        $text = getEmailBody($hum, $light, $temp);
        sendEmails($subject, $text);

        echo $text;
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

?>