<?PHP
session_start();
require_once('mysql.php');
$username = mysql_real_escape_string($_POST['uname']);
$query = "SELECT hash FROM users WHERE `username` = '$username';";
$hash = mysql_result(mysql_query($query), 0);

$otp = $_POST['otp'];
$challenge = $_SESSION['challenge'];

$resp = substr(hash('sha512', $hash.$challenge),0,10);
if($otp == $resp){
	echo "You're in!";
}else{
	echo "Fail!";
}

unset($_SESSION['code']);
$_SESSION['username'] = $username;
mysql_close()
?>

