<<<<<<< HEAD
<?php
include 'db.php';

$data = json_decode(file_get_contents("php://input"), true);

$stmt = $conn->prepare("
    INSERT INTO reports (
        headline,
        body,
        publisher_id,
        writer_name,
        release_date,
        shares_count,
        response_count,
        reactions_count,
        reference_link
    ) VALUES (?, ?, ?, ?, NOW(), ?, ?, ?, ?)
");

$stmt->bind_param(
    "ssissiis",
    $data['headline'],
    $data['body'],
    $data['publisher_id'],
    $data['writer_name'],
    $data['shares_count'],
    $data['response_count'],
    $data['reactions_count'],
    $data['reference_link']
);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false]);
}

$stmt->close();
$conn->close();
=======
<?php
include 'db.php';

$data = json_decode(file_get_contents("php://input"), true);

$stmt = $conn->prepare("
    INSERT INTO reports (
        headline,
        body,
        publisher_id,
        writer_name,
        release_date,
        shares_count,
        response_count,
        reactions_count,
        reference_link
    ) VALUES (?, ?, ?, ?, NOW(), ?, ?, ?, ?)
");

$stmt->bind_param(
    "ssissiis",
    $data['headline'],
    $data['body'],
    $data['publisher_id'],
    $data['writer_name'],
    $data['shares_count'],
    $data['response_count'],
    $data['reactions_count'],
    $data['reference_link']
);

if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false]);
}

$stmt->close();
$conn->close();
>>>>>>> b7234eb0a4607a1b3be541d729ec896dce1dc0f3
?>