<?php
$connect = new mysqli('localhost','root','','projectdb');

if($connect){

}
else{
    echo "Connection Failed!";
    exit();
}
