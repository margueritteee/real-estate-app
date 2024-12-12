<?php 
error_reporting(0);
include("../connect.php");
$name=$_POST['name'];
$pass=$_POST['pass'];

$sql="SELECT * FROM `users` WHERE `username`='$name' AND `password` ='$pass'";
$res=$con->query($sql);
$count=$res->num_rows;

if($count>0){
    $sql="SELECT * FROM `users` WHERE username='$name' ";
    $res=$con->query($sql);
    while($row=$res->fetch_assoc()){
        $data[]=$row;
    }
    echo json_encode(array("result"=>$data));

}else{
    echo json_encode(array("result"=>"not here"));
}

?>
