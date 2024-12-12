<?php 

include("../connect.php");
$username-$_POST['query'];

$sql="SELECT * FROM users WHERE username LIKE '%username%'";
$res=$con->query($sql);
while($row=$res->fetch_assoc()){
    $data[]=$row;
}
echo json_encode($data);