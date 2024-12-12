<?php
error_reporting(0);
include("../connect.php"); 

$id = $_POST['id'];

// Step 1: Retrieve the image filename
$sql = "SELECT img FROM post_table WHERE id = '$id'";
$result = $con->query($sql);
if ($row = $result->fetch_assoc()) {
    $imageName = $row['img'];
    $uploadDir = 'C:/xampp/htdocs/memoire/uploads/';
    $imagePath = $uploadDir . basename($imageName);

    // Step 2: Delete the image file if it exists
    if (file_exists($imagePath)) {
        unlink($imagePath);
    }

    // Step 3: Delete the database record
    $sql = "DELETE FROM post_table WHERE id = '$id'";
    $result = $con->query($sql);
    if ($result) {
        echo json_encode("done");
    } else {
        echo json_encode("error deleting record");
    }
} else {
    echo json_encode("post not found");
}
?>
