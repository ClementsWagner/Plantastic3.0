<?php 
		require ('ManageEmails.php');
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
	<div class="email-form">
		<form class="email-input-form" action="Notification.php" method="post" name="add">
			<input class="email-field" type="text" name="email" value="<?php print($currEmail);?>" />
			<input class="add-btn" type="submit" value="Add" name="add" /> <br>
			<span class="error"> <?php echo $emailErr;?></span>
		</form>


		<?php 
			$emailList = getEmails();
			foreach($emailList as $email){
				?>
				<div class="email-card">
					<?php echo $email ?> <a href=<?php echo "Notification.php?email=" . $email ?>><button class="remove-btn">Remove</button></a> <br>
				</div>
		<?php
			}
		?>
	</div>
</body>
</html>
