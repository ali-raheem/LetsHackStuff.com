<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<title>Secure Login</title>
</head>
<body>
<?PHP
if(isset($_POST['username']) && isset($_POST['password'])){
$username = mysql_real_escape_string($_POST['username']);
$password = $_POST['password'];
$hash = hash( 'sha512', $username.$password);
$query = "INSERT INTO users VALUES (NULL, '$username', '$hash');";
require_once('mysql.php');
$result = mysql_query($query);
mysql_close();
?>
<p>Added <?$username?> to the databse. <a href='index.php'>Login Here!</a></p>
<?PHP
}else{
?>
<form action='#' method='POST'>
<table>
<tr><td>Username:</td><td><input type='text' name='username'/></td></tr>
<tr><td>Password:</td><td><input type='text' name='password'/></td></tr>
<tr><td></td><td><input type='submit' value='Register!'/></td></tr>
</table>
</form>

<?PHP
}
?>
</body>
</html>
