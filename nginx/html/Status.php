<html>
    <head>
        <link rel="stylesheet" href="style.css">
        <script>
            function showData(){
                var xmlHttp = new XMLHttpRequest();
                xmlHttp.onreadystatechange = function(){
                    if(this.readyState == 4 && this.status == 200){
                        var data = JSON.parse(this.responseText);
                        buildStatusContainer(data);
                    }
                }
                xmlHttp.open("GET", "ManageStatus.php?status", true);
                xmlHttp.send();
            }

            function buildStatusContainer(data){
                let container = "";
                data.forEach(element => container += `<div class="status-container">${element["name"]} <img src="images/${element["status"]}-smiley.png" class="status-image"/></div>`);
                document.getElementById("status-container").innerHTML = container;
            }

        </script>
    </head>
    <body onLoad="setInterval(showData, 2000)">
        <div class="topnav">
            <a href="/Status.php"><img src="/images/Logo-small.png"></a>
            <a href="/Notification.php"><img class="navbar-icon" src="/images/email-icon.png"></a>
            <a href="/stats.html"><img class="navbar-icon" src="/images/status-icon.png"></a>
            <a href="/Naming.php"><img class="navbar-icon" src="/images/naming-icon.png"></a>
        </div>
        <div id="status-container">
            
        </div>
        <script type="text/javascript">
			showData();
			setInterval(showData, 2000);
			</script>
    </body>
</html>