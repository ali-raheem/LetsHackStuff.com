<?PHP
session_start();
$_SESSION['challenge']=substr(md5(mt_rand()), 0, 10);
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<title>Secure Login</title>
</head>
<body>
<?PHP
if(!isset($_SESSION['username'])){
?>
<form action='login.php' method='POST'>
<table>
<tr><td>Username:</td><td><input type='text' name='uname'/></td></tr>
<tr><td>Challenge: </td><td><img src='image.php'/></td></tr>
<tr><td>One time password:</td><td><input type='text' name='otp'/></td></tr>
<tr><td></td><td><input type='submit' value='login!'/></td></tr>
</table>
</form>
<?PHP
}else{
echo 'Hello '.$_SESSION['username'];
}
?>
</body>
</html>
