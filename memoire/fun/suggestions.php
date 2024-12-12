<?php 
error_reporting(0);
include("../connect.php"); 
$sql="SELECT * FROM users";
$res=$con->query($sql);
while($row=$res->fetch_assoc()){
    $data[]=$row;
}
echo json_encode($data);