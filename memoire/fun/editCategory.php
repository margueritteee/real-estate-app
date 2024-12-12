<?php 
error_reporting(0);
include("../connect.php");
$id=$_POST['id'];
$name=$_POST['name'];

$sql="UPDATE category SET 
name='$name'
WHERE id=$id";
$result=$con->query($sql);
if($result){
    echo json_encode("done");
}
