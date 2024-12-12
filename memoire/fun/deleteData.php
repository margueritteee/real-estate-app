<?php 
error_reporting(0);
include("../connect.php"); 
$id=$_POST['id'];
$sql="DELETE FROM users WHERE userid='$id'";
$result=$con->query($sql);
if($result){
    echo json_encode("done");
}
