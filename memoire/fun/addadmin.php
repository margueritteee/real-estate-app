<?php 
error_reporting(0);
include("../connect.php");
$name=$_POST['name'];
$pass=$_POST['pass'];

$sql=" INSERT INTO `admins` (`username`,`password`) VALUES ('$name','$pass')";
$result=$con->query($sql);
if($result){
    echo json_encode("done");
}