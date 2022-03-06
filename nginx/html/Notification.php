<?php 
		require ('ManageEmails.php');
?>

<html>
<head>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<div class="topnav">
		<a href="/"><img src="/images/Logo-small.png"></a>
		<a href="/Notification.php"><img class="navbar-icon" src="/images/email-icon.png"></a>
	</div>

	<form action="Notification.php" method="post" name="add">
    	<input type="text" name="email" value="<?php print($currEmail);?>" />
		<input type="submit" value="Add" name="add" /> <br>
		<span class="error"> <?php echo $emailErr;?></span>
	</form>


	<?php 
		$emailList = getEmails();
		foreach($emailList as $email){
			?>
				<?php echo $email ?> <a href=<?php echo "Notification.php?email=" . $email ?>>Remove</a> <br>
	<?php
		}
	?>
</body>
</html>
