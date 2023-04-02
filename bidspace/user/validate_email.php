<?php

include '../conn.php';

$userEmail = $_POST['email'];

$query = "SELECT * FROM users WHERE email ='$userEmail'";
$result = $connection -> query($query);

if($result -> num_rows > 0) {
    // Email already exists
    echo json_encode(array("emailfound" => true));
    
} else {
    // Email does not exist
    echo json_encode(array("emailfound" => false));
}

?>