<<<<<<< HEAD
<?php
$db_path = __DIR__ . '/media_verification.db';

try {
    $conn = new PDO('sqlite:' . $db_path);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
=======
<?php
$db_path = __DIR__ . '/media_verification.db';

try {
    $conn = new PDO('sqlite:' . $db_path);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
>>>>>>> b7234eb0a4607a1b3be541d729ec896dce1dc0f3
?>