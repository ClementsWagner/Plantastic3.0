<?php 
    require ('ManageMetadata.php');
    require ('ManageStatus.php');
?>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <meta http-equiv="refresh" content="5">
    <script type="text/JavaScript">

        function timedRefresh(timeoutPeriod) {
            setTimeout("location.reload(true);",timeoutPeriod);
        }

    </script>
</head>
<body >
    <?php 
        $metadata = getMetadata();
        foreach($metadata as $entry){
            ?>
                <div class="status-container">
                    <?php echo $entry["name"]; ?> <img src="images/<?php print($entry["status"]); ?>-smiley.png" class="status-image"/>
                </div>    
            <?php
        }
    ?>
</body>
</html>