<?php 
error_reporting(0);
include("../connect.php");
$id=$_POST['id'];
$name=$_POST['name'];
$pass=$_POST['pass'];

if(empty($name) && empty($pass)){
    echo json_encode("null");
}else if ( !empty($name) ){
    $sql="UPDATE admins SET 
    username='$name'
    WHERE adminid=$id";
    $result=$con->query($sql);
    if($result){
        echo json_encode("done");
    }
}
else if( !empty($pass) ){
    $sql="UPDATE admins SET 
    password='$pass'
    WHERE adminid=$id";
    $result=$con->query($sql);
    if($result){
        echo json_encode("done");
    }
}
else{
$sql="UPDATE admins SET 
username='$name',
password='$pass'
WHERE adminid=$id";
$result=$con->query($sql);
if($result){
    echo json_encode("done");
}
}

