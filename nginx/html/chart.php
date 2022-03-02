<?php

$jsonArray = "[" . file_get_contents("plantasticdata.json") . "]";


$sensorData = json_decode($jsonArray, true);

?>
<script type="text/javascript">
console.log(<?php echo $jsonArray ?>);
</script>
