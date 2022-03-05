<?php 
		require ('ManageEmails.php');
		if($_SERVER['REQUEST_METHOD'] == "GET" and isset($_GET['remove']))
		{
			echo 'removed';
			removeEmail($_GET['email']);
		}
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
    	<input type="text" name="email" />
		<input type="submit" value="Add" name="add" />
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
