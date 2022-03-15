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
    <script type="text/JavaScript">

        function timedRefresh(timeoutPeriod) {
            setTimeout("location.reload(true);",timeoutPeriod);
        }

    </script>
</head>
<body onload="JavaScript:timedRefresh(300000);">
    <?php 
        
    ?>
</body>
</html>