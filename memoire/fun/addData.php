<?php 
error_reporting(0);
include("../connect.php");
$name=$_POST['name'];
$number=$_POST['number'];
$password=$_POST['password'];

$sql=" INSERT INTO `users` (`username`,`number`,`password`) VALUES ('$name','$number','$password')";
$result=$con->query($sql);
if($result){
    echo json_encode("done");
}