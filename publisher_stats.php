<<<<<<< HEAD
<?php
include 'db.php';

$sql = "
SELECT publisher_name,
       COUNT(*) AS total_reports
FROM reports r
JOIN publishers p
ON r.publisher_id = p.publisher_id
GROUP BY publisher_name
";

$result = $conn->query($sql);

echo json_encode($result->fetchAll(PDO::FETCH_ASSOC));
=======
<?php
include 'db.php';

$sql = "
SELECT publisher_name,
       COUNT(*) AS total_reports
FROM reports r
JOIN publishers p
ON r.publisher_id = p.publisher_id
GROUP BY publisher_name
";

$result = $conn->query($sql);

echo json_encode($result->fetchAll(PDO::FETCH_ASSOC));
>>>>>>> b7234eb0a4607a1b3be541d729ec896dce1dc0f3
?>