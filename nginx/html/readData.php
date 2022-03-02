<?php

$content = file_get_contents("plantasticdata.json");
echo "[" . substr($content,0,-1) . "]";

?>
