<?php 
error_reporting(0);
include("../connect.php");
$name=$_POST['name'];

$sql=" INSERT INTO `category` (`name`) VALUES ('$name')";
$result=$con->query($sql);
if($result){
    echo json_encode("done");
}