<?php 

include("../connect.php");
$title = $_POST['query'];

$sql = "SELECT * FROM post_table WHERE title LIKE ?";
$stmt = $con->prepare($sql);
$searchPattern = '%' . $title . '%';
$stmt->bind_param("s", $searchPattern);
$stmt->execute();
$result = $stmt->get_result();

$data = array();
while($row = $result->fetch_assoc()){
    $data[] = $row;
}
echo json_encode($data);
