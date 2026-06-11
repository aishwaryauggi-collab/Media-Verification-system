<?php
$db_path = __DIR__ . '/media_verification.db';

try {
    // Create SQLite database connection
    $conn = new PDO('sqlite:' . $db_path);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Drop existing tables if they exist
    $conn->exec("DROP TABLE IF EXISTS report_term_tracking");
    $conn->exec("DROP TABLE IF EXISTS verification_scores");
    $conn->exec("DROP TABLE IF EXISTS reports");
    $conn->exec("DROP TABLE IF EXISTS alert_terms");
    $conn->exec("DROP TABLE IF EXISTS publishers");

    // Create tables
    $conn->exec("
    CREATE TABLE publishers (
        publisher_id INTEGER PRIMARY KEY AUTOINCREMENT,
        publisher_name VARCHAR(255) NOT NULL UNIQUE,
        trust_rating DECIMAL(3,2) NOT NULL,
        region VARCHAR(100),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
    ");

    $conn->exec("
    CREATE TABLE alert_terms (
        term_id INTEGER PRIMARY KEY AUTOINCREMENT,
        term VARCHAR(100) NOT NULL UNIQUE,
        weight INTEGER NOT NULL
    )
    ");

    $conn->exec("
    CREATE TABLE reports (
        report_id INTEGER PRIMARY KEY AUTOINCREMENT,
        headline TEXT NOT NULL,
        body LONGTEXT NOT NULL,
        publisher_id INTEGER NOT NULL,
        writer_name VARCHAR(255),
        release_date DATETIME,
        shares_count INTEGER DEFAULT 0,
        response_count INTEGER DEFAULT 0,
        reactions_count INTEGER DEFAULT 0,
        reference_link VARCHAR(500),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
    )
    ");

    $conn->exec("
    CREATE TABLE report_term_tracking (
        tracking_id INTEGER PRIMARY KEY AUTOINCREMENT,
        report_id INTEGER NOT NULL,
        term_id INTEGER NOT NULL,
        frequency_count INTEGER DEFAULT 1,
        FOREIGN KEY (report_id) REFERENCES reports(report_id),
        FOREIGN KEY (term_id) REFERENCES alert_terms(term_id)
    )
    ");

    $conn->exec("
    CREATE TABLE verification_scores (
        score_id INTEGER PRIMARY KEY AUTOINCREMENT,
        report_id INTEGER NOT NULL,
        headline_score DECIMAL(5,2),
        publisher_risk DECIMAL(5,2),
        spread_score DECIMAL(5,2),
        combined_score DECIMAL(5,2),
        status_label VARCHAR(50),
        reviewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (report_id) REFERENCES reports(report_id)
    )
    ");

    // Insert sample data
    $conn->exec("
    INSERT INTO publishers (publisher_name, trust_rating, region) VALUES
    ('Global News Network', 0.96, 'International'),
    ('Verified Press', 0.94, 'Europe'),
    ('Buzz Flash Media', 0.22, 'Unknown'),
    ('Trend Storm Daily', 0.18, 'Unknown')
    ");

    $conn->exec("
    INSERT INTO alert_terms (term, weight) VALUES
    ('unbelievable', 8),
    ('hidden truth', 9),
    ('viral secret', 8),
    ('must see', 7),
    ('exclusive leak', 8),
    ('mystery', 6),
    ('instant cure', 10)
    ");

    $conn->exec("
    INSERT INTO reports (headline, body, publisher_id, writer_name, release_date, shares_count, response_count, reactions_count, reference_link)
    VALUES
    ('Unbelievable Hidden Truth Revealed Today!', 'This viral secret is spreading rapidly across the internet...', 3, 'Anonymous Reporter', datetime('now'), 38000, 1400, 7600, 'http://buzzflash.example/article1'),
    ('Verified Press releases annual policy report', 'Detailed report covering international developments...', 2, 'Editorial Team', datetime('now'), 900, 180, 600, 'http://verifiedpress.example/article2'),
    ('Exclusive Leak: Mystery Device Changes Everything!', 'A hidden truth about revolutionary technology has surfaced...', 4, 'Trend Reporter', datetime('now'), 52000, 2100, 11000, 'http://trendstorm.example/article3'),
    ('Global News Network covers climate summit outcomes', 'World leaders discuss environmental policies and future actions...', 1, 'Senior Correspondent', datetime('now'), 1800, 320, 950, 'http://globalnews.example/article4'),
    ('Must See: Instant Cure for Common Illness Goes Viral', 'Social media users are rapidly sharing claims of a medical breakthrough...', 3, 'Health Insider', datetime('now'), 61000, 3400, 15000, 'http://buzzflash.example/article5'),
    ('Verified Press reports on economic market stability', 'Experts provide insights into recent financial developments...', 2, 'Finance Editor', datetime('now'), 1300, 240, 700, 'http://verifiedpress.example/article6'),
    ('Mystery Event Sparks Global Speculation', 'Online communities debate shocking new developments...', 4, 'Digital Trends Analyst', datetime('now'), 47000, 1950, 9800, 'http://trendstorm.example/article7')
    ");

    // Insert verification scores for reports
    $conn->exec("
    INSERT INTO verification_scores (report_id, headline_score, publisher_risk, spread_score, combined_score, status_label)
    VALUES
    (1, 2.5, 8.0, 8.5, 6.3, 'Misleading'),
    (2, 8.5, 1.0, 3.0, 7.5, 'Reliable'),
    (3, 1.5, 8.5, 9.2, 6.4, 'Misleading'),
    (4, 8.8, 0.5, 2.0, 8.0, 'Reliable'),
    (5, 0.5, 7.8, 9.5, 5.9, 'Questionable'),
    (6, 8.5, 0.8, 2.5, 7.8, 'Reliable'),
    (7, 2.0, 8.2, 8.8, 6.3, 'Misleading')
    ");

    echo "Database initialized successfully!";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
