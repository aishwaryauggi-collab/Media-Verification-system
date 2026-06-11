<?php
header("Content-Type: application/json");

include 'db.php';

$sql = "
SELECT
    r.report_id,
    r.headline,
    p.publisher_name,
    p.trust_rating,
    r.shares_count,
    v.combined_score,
    v.status_label
FROM reports r
JOIN publishers p ON r.publisher_id = p.publisher_id
LEFT JOIN verification_scores v ON r.report_id = v.report_id
";

$result = $conn->query($sql);
$reports = $result->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($reports);
?>
