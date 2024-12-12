<?php 
error_reporting(0);
include("../connect.php");
$name = $_POST['name'];
$pass = $_POST['pass'];
$number = $_POST['number'];
$email = $_POST['email'];
$stmt = $con->prepare("SELECT * FROM users WHERE username=?");
$stmt->bind_param("s", $name);
$stmt->execute();
$result = $stmt->get_result();
$count = $result->num_rows;

if ($count > 0) {
    echo json_encode(array("result" => "already"));
} else {
    $stmt = $con->prepare("INSERT INTO users(username, number, email, password) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $name, $number, $email, $pass);
    $res = $stmt->execute();

    if ($res) {
        echo json_encode(array("result" => "done"));
    }
}
