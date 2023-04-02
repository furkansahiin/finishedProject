// Verileri sorgula
$sql = "SELECT * FROM images";
$result = mysqli_query($conn, $sql);

// Verileri JSON formatında döndür
if (mysqli_num_rows($result) > 0) {
  $response["images"] = array();
  while($row = mysqli_fetch_assoc($result)) {
    $image = array();
    $image["id"] = $row["id"];
    $image["image_path"] = $row["image_path"];

    array_push($response["images"], $image);
  }
  echo json_encode($response);
} else {
  echo "0 results";
}
