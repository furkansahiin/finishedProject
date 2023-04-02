<?php 

// Create connection
include '../conn.php';


// post
$userName = $_POST['username'];
$userEmail = $_POST['email'];
$userPassword = md5($_POST['password']);

// sql
$sql = "INSERT INTO users SET username = '$userName', email = '$userEmail', password = '$userPassword', created_at = NOW(), is_admin = 0";

// query

$result = mysqli_query($connection, $sql);

if($result) {
    echo json_encode(array('status' => true));
} else {
    echo json_encode(array('status' => false));
}