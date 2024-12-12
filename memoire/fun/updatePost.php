<?php

error_reporting(0);

include("../connect.php");
$title = $_POST['title'];
$description = $_POST['description'];
$category_name = $_POST['category_name'];
$rooms_number = $_POST['rooms_number'];
$price = $_POST['price'];
$number = $_POST['number'];
$address = $_POST['address'];
$author = $_POST['author'];
$commune = $_POST['commune'];

$image = $_FILES['img']['name'];
$uploadDir = 'C:/xampp/htdocs/memoire/uploads/'; 
$imagePath = $uploadDir . basename($image); 

$tmp_name = $_FILES['img']['tmp_name'];

move_uploaded_file($tmp_name, $imagePath);

$db->query("UPDATE  `post_table` SET title='$title', 
description='$description',
category_name='$category_name' ,
rooms_number='$rooms_number',
price='$price',
number='$number',
address='$address',
author='$author',
commune='$commune',
img='$image',
");
