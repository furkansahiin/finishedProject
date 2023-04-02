<?php
// Create connection
include '../conn.php';

$userEmail = $_POST['email'];
$userPassword = md5($_POST['password']);

$query = "SELECT * FROM users WHERE (username = '$userEmail' OR email = '$userEmail') AND password = '$userPassword'";

$result = mysqli_query($connection, $query);
if ($result->num_rows > 0) {
    // user exists
    $userRecord = array();
    while ($row = $result->fetch_assoc()) {
        $userRecord[] = $row;
    }
    echo json_encode(array(
        "success" => true,
        "userData" => $userRecord[0],
        )
    );
} else {
    // user does not exist
    echo json_encode(array("success" => false));
}
?>