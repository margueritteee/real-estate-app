<?php 

include("../connect.php");
$name=$_POST['name'];
$list=array();
$result=$con->query("SELECT * FROM post_table WHERE commune='$name'");
if($result){
    while($row=$result->fetch_assoc()){
        $list[]=$row;}
}
echo json_encode($list);
