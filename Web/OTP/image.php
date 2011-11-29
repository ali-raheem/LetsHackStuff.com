<?php
header("Content-type: image/png");
session_start();
$string = $_SESSION['challenge'];
$font  = 20;
$len = 10;
$width  = imagefontwidth($font) * $len;
$height = imagefontheight($font);
$image = imagecreatetruecolor ($width,$height);
$white = imagecolorallocate ($image,255,255,255);
$black = imagecolorallocate ($image,0,0,0);
imagefill($image,0,0,$white);
imagestring ($image,$font,0,0,$string,$black);
imagepng ($image);
imagedestroy($image);
?>
