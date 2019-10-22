<?php
include 'conn.php';
$name=$_POST['name'];
$crime=$_POST['crime'];
$dateofcrime=$_POST['dateofcrime'];
$image_url=$_POST['image_url'];
$conn->query("INSERT into user_details values('".$name."','".$crime."','".$dateofcrime."','".$image_url."')");
?>