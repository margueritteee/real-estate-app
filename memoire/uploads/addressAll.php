<?php 
error_reporting(0);
include("../connect.php");
$sql = "SELECT * FROM `address`";
$result=$con->query($sql);
while($row=$result->fetch_assoc()){
    $data[]=$row;
}
echo json_encode($data);
?>


