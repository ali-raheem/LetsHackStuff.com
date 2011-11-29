<?PHP
$mysqlHost = 'localhost';
$mysqlDB = 'secure';
$mysqlUser = 'secure_user';
$mysqlPass = 'secure_pass';
mysql_connect($mysqlHost, $mysqlUser, $mysqlPass) or die('could not connect');
mysql_select_db($mysqlDB) or die('could not select db');
?>
