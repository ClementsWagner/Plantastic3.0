<?php
    require ('ManageNames.php');

?>
<html>
    <head>
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <div class="topnav">
            <a href="/"><img src="/images/Logo-small.png"></a>
            <a href="/Notification.php"><img class="navbar-icon" src="/images/email-icon.png"></a>
            <a href="/Status.php"><img class="navbar-icon" src="/images/status-icon.png"></a>
            <a href="/Naming.php"><img class="navbar-icon" src="/images/naming-icon.png"></a>
        </div>
        <div>
            <table>
                <tr>
                    <th>MAC</th>
                    <th>Name</th>
                </tr>
                <?php 
                    $naming = getNaming();
                    foreach($naming as $name){
                        echo '<tr>';
                        echo '<td>' . $name['mac'] . '</td>';
                        echo '<td>' . $name['name'] . '</td>';
                        echo '</tr>';
                    }
                ?>
            </table>
        </div>
    </body>
</html>