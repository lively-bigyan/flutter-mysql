<?php
include 'conn.php';

$username=$_POST['username'];
$email=$_POST['email'];
$password=$_POST['password'];

$queryResult=$connect->query("SELECT * FROM login WHERE username='".$username."', email='".$email."', password='".$password."'");

$result=array();

while ($fetchData=$queryResult->fetch_assoc()){
    $result[]=$fetchData;
}
echo json_encode($result);
