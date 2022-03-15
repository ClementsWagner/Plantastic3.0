<?php
    require_once 'ManageMetadata.php';

    if($_SERVER['REQUEST_METHOD'] == "POST" and isset($_POST['mac-value']) and isset($_POST['name-value']))
    {
        changeName($_POST["mac-value"], $_POST['name-value']);
    }

?>
<html>
    <head>
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <div class="topnav">
            <a href="/Status.php"><img src="/images/Logo-small.png"></a>
            <a href="/Notification.php"><img class="navbar-icon" src="/images/email-icon.png"></a>
            <a href="/stats.html"><img class="navbar-icon" src="/images/status-icon.png"></a>
            <a href="/Naming.php"><img class="navbar-icon" src="/images/naming-icon.png"></a>
        </div>
        <div>
            <table>
                <tr>
                    <th>MAC</th>
                    <th>Name</th>
                </tr>
                <?php 
                    $metadata = getMetadata();
                    foreach($metadata as $entry){
                        echo '<tr>';
                        echo '<td>' . $entry['mac'] . '</td>';
                        ?>
                            <td>
                            <form action="Naming.php" method="post" name="name">
                                <input class="name-field" type="text" name="name-value" value="<?php print($entry["name"]); ?>"/>
                                <input type="hidden" name="mac-value" value="<?php print($entry["mac"]); ?>"/>
                            </form>
                        </td>
                        <?php
                        echo '</tr>';
                    }
                ?>
            </table>
        </div>
    </body>
</html>