<?php 
error_reporting(0);
include("../connect.php");
$id=$_POST['id'];
$name=$_POST['name'];
$number=$_POST['number'];
$password=$_POST['password'];

if(empty($name) && empty($number)&& empty($password)){
    echo json_encode("null");
}else if ( !empty($name) ){
    $sql="UPDATE users SET 
    username='$name'
    WHERE userid=$id";
    $result=$con->query($sql);
    if($result){
        echo json_encode("done");
    }
}
else if( !empty($number) ){
    $sql="UPDATE users SET 
    number='$number'
    WHERE userid=$id";
    $result=$con->query($sql);
    if($result){
        echo json_encode("done");
    }
}
else if( !empty($password) ){
    $sql="UPDATE users SET 
    password='$password'
    WHERE userid=$id";
    $result=$con->query($sql);
    if($result){
        echo json_encode("done");
    }
}
else{
$sql="UPDATE users SET 
username='$name',
number='$number'
password='$password'
WHERE userid=$id";
$result=$con->query($sql);
if($result){
    echo json_encode("done");
}
}

