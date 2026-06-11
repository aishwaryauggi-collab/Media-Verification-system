<<<<<<< HEAD


CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(255) NOT NULL UNIQUE,
    trust_rating DECIMAL(5,2) NOT NULL,
    region VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE alert_terms (
    term_id INT AUTO_INCREMENT PRIMARY KEY,
    term VARCHAR(100) NOT NULL UNIQUE,
    weight INT NOT NULL
);

CREATE TABLE reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    headline TEXT NOT NULL,
    body LONGTEXT NOT NULL,
    publisher_id INT NOT NULL,
    writer_name VARCHAR(255),
    release_date DATETIME,
    shares_count INT DEFAULT 0,
    response_count INT DEFAULT 0,
    reactions_count INT DEFAULT 0,
    reference_link VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE report_term_tracking (
    tracking_id INT AUTO_INCREMENT PRIMARY KEY,
    report_id INT NOT NULL,
    term_id INT NOT NULL,
    frequency_count INT DEFAULT 1,
    FOREIGN KEY (report_id) REFERENCES reports(report_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (term_id) REFERENCES alert_terms(term_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE verification_scores (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    report_id INT NOT NULL,
    headline_score DECIMAL(5,2),
    publisher_risk DECIMAL(5,2),
    spread_score DECIMAL(5,2),
    combined_score DECIMAL(5,2),
    status_label ENUM('Reliable', 'Questionable', 'Misleading'),
    reviewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (report_id) REFERENCES reports(report_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO publishers (publisher_name, trust_rating, region) VALUES
('Global News Network', 0.96, 'International'),
('Verified Press', 0.94, 'Europe'),
('Buzz Flash Media', 0.22, 'Unknown'),
('Trend Storm Daily', 0.18, 'Unknown');

INSERT INTO alert_terms (term, weight) VALUES
('unbelievable', 8),
('hidden truth', 9),
('viral secret', 8),
('must see', 7),
('exclusive leak', 8),
('mystery', 6),
('instant cure', 10);

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
) VALUES
(
    'Unbelievable Hidden Truth Revealed Today!',
    'This viral secret is spreading rapidly across the internet...',
    3,
    'Anonymous Reporter',
    NOW(),
    38000,
    1400,
    7600,
    'http://buzzflash.example/article1'
),
(
    'Verified Press releases annual policy report',
    'Detailed report covering international developments...',
    2,
    'Editorial Team',
    NOW(),
    900,
    180,
    600,
    'http://verifiedpress.example/article2'
),
(
    'Exclusive Leak: Mystery Device Changes Everything!',
    'A hidden truth about revolutionary technology has surfaced...',
    4,
    'Trend Reporter',
    NOW(),
    52000,
    2100,
    11000,
    'http://trendstorm.example/article3'
),
(
    'Global News Network covers climate summit outcomes',
    'World leaders discuss environmental policies and future actions...',
    1,
    'Senior Correspondent',
    NOW(),
    1800,
    320,
    950,
    'http://globalnews.example/article4'
),
(
    'Must See: Instant Cure for Common Illness Goes Viral',
    'Social media users are rapidly sharing claims of a medical breakthrough...',
    3,
    'Health Insider',
    NOW(),
    61000,
    3400,
    15000,
    'http://buzzflash.example/article5'
),
(
    'Verified Press reports on economic market stability',
    'Experts provide insights into recent financial developments...',
    2,
    'Finance Editor',
    NOW(),
    1300,
    240,
    700,
    'http://verifiedpress.example/article6'
),
(
    'Mystery Event Sparks Global Speculation',
    'Online communities debate shocking new developments...',
    4,
    'Digital Trends Analyst',
    NOW(),
    47000,
    1950,
    9800,
    'http://trendstorm.example/article7'
);

INSERT INTO verification_scores (
    report_id,
    headline_score,
    publisher_risk,
    spread_score,
    combined_score
)
VALUES
(1, 40, 80, 90, 45),
(2, 90, 95, 85, 90),
(3, 35, 20, 95, 30),
(4, 95, 96, 80, 92),
(5, 25, 15, 98, 20),
(6, 92, 94, 88, 91),
(7, 30, 25, 90, 35);

CREATE VIEW content_review_dashboard AS
SELECT
    r.report_id,
    r.headline,
    p.publisher_name,
    p.trust_rating,
    r.shares_count,
    r.response_count,
    v.combined_score,
    v.status_label
FROM reports r
JOIN publishers p ON r.publisher_id = p.publisher_id
LEFT JOIN verification_scores v ON r.report_id = v.report_id;




DELIMITER $$

CREATE TRIGGER trg_verification_status_before_insert
BEFORE INSERT ON verification_scores
FOR EACH ROW
BEGIN
    IF NEW.combined_score >= 80 THEN
        SET NEW.status_label = 'Reliable';
    ELSEIF NEW.combined_score >= 50 THEN
        SET NEW.status_label = 'Questionable';
    ELSE
        SET NEW.status_label = 'Misleading';
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_verification_status_before_update
BEFORE UPDATE ON verification_scores
FOR EACH ROW
BEGIN
    IF NEW.combined_score >= 80 THEN
        SET NEW.status_label = 'Reliable';
    ELSEIF NEW.combined_score >= 50 THEN
        SET NEW.status_label = 'Questionable';
    ELSE
        SET NEW.status_label = 'Misleading';
    END IF;
END$$

DELIMITER ;
DELIMITER $$

CREATE TABLE verification_audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    report_id INT,
    score DECIMAL(5,2),
    status_label VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER trg_audit_verification
AFTER INSERT ON verification_scores
FOR EACH ROW
BEGIN
    INSERT INTO verification_audit_log (
        report_id,
        score,
        status_label
    )
    VALUES (
        NEW.report_id,
        NEW.combined_score,
        NEW.status_label
    );
END$$

=======


CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(255) NOT NULL UNIQUE,
    trust_rating DECIMAL(5,2) NOT NULL,
    region VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE alert_terms (
    term_id INT AUTO_INCREMENT PRIMARY KEY,
    term VARCHAR(100) NOT NULL UNIQUE,
    weight INT NOT NULL
);

CREATE TABLE reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    headline TEXT NOT NULL,
    body LONGTEXT NOT NULL,
    publisher_id INT NOT NULL,
    writer_name VARCHAR(255),
    release_date DATETIME,
    shares_count INT DEFAULT 0,
    response_count INT DEFAULT 0,
    reactions_count INT DEFAULT 0,
    reference_link VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE report_term_tracking (
    tracking_id INT AUTO_INCREMENT PRIMARY KEY,
    report_id INT NOT NULL,
    term_id INT NOT NULL,
    frequency_count INT DEFAULT 1,
    FOREIGN KEY (report_id) REFERENCES reports(report_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (term_id) REFERENCES alert_terms(term_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE verification_scores (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    report_id INT NOT NULL,
    headline_score DECIMAL(5,2),
    publisher_risk DECIMAL(5,2),
    spread_score DECIMAL(5,2),
    combined_score DECIMAL(5,2),
    status_label ENUM('Reliable', 'Questionable', 'Misleading'),
    reviewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (report_id) REFERENCES reports(report_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO publishers (publisher_name, trust_rating, region) VALUES
('Global News Network', 0.96, 'International'),
('Verified Press', 0.94, 'Europe'),
('Buzz Flash Media', 0.22, 'Unknown'),
('Trend Storm Daily', 0.18, 'Unknown');

INSERT INTO alert_terms (term, weight) VALUES
('unbelievable', 8),
('hidden truth', 9),
('viral secret', 8),
('must see', 7),
('exclusive leak', 8),
('mystery', 6),
('instant cure', 10);

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
) VALUES
(
    'Unbelievable Hidden Truth Revealed Today!',
    'This viral secret is spreading rapidly across the internet...',
    3,
    'Anonymous Reporter',
    NOW(),
    38000,
    1400,
    7600,
    'http://buzzflash.example/article1'
),
(
    'Verified Press releases annual policy report',
    'Detailed report covering international developments...',
    2,
    'Editorial Team',
    NOW(),
    900,
    180,
    600,
    'http://verifiedpress.example/article2'
),
(
    'Exclusive Leak: Mystery Device Changes Everything!',
    'A hidden truth about revolutionary technology has surfaced...',
    4,
    'Trend Reporter',
    NOW(),
    52000,
    2100,
    11000,
    'http://trendstorm.example/article3'
),
(
    'Global News Network covers climate summit outcomes',
    'World leaders discuss environmental policies and future actions...',
    1,
    'Senior Correspondent',
    NOW(),
    1800,
    320,
    950,
    'http://globalnews.example/article4'
),
(
    'Must See: Instant Cure for Common Illness Goes Viral',
    'Social media users are rapidly sharing claims of a medical breakthrough...',
    3,
    'Health Insider',
    NOW(),
    61000,
    3400,
    15000,
    'http://buzzflash.example/article5'
),
(
    'Verified Press reports on economic market stability',
    'Experts provide insights into recent financial developments...',
    2,
    'Finance Editor',
    NOW(),
    1300,
    240,
    700,
    'http://verifiedpress.example/article6'
),
(
    'Mystery Event Sparks Global Speculation',
    'Online communities debate shocking new developments...',
    4,
    'Digital Trends Analyst',
    NOW(),
    47000,
    1950,
    9800,
    'http://trendstorm.example/article7'
);

INSERT INTO verification_scores (
    report_id,
    headline_score,
    publisher_risk,
    spread_score,
    combined_score
)
VALUES
(1, 40, 80, 90, 45),
(2, 90, 95, 85, 90),
(3, 35, 20, 95, 30),
(4, 95, 96, 80, 92),
(5, 25, 15, 98, 20),
(6, 92, 94, 88, 91),
(7, 30, 25, 90, 35);

CREATE VIEW content_review_dashboard AS
SELECT
    r.report_id,
    r.headline,
    p.publisher_name,
    p.trust_rating,
    r.shares_count,
    r.response_count,
    v.combined_score,
    v.status_label
FROM reports r
JOIN publishers p ON r.publisher_id = p.publisher_id
LEFT JOIN verification_scores v ON r.report_id = v.report_id;




DELIMITER $$

CREATE TRIGGER trg_verification_status_before_insert
BEFORE INSERT ON verification_scores
FOR EACH ROW
BEGIN
    IF NEW.combined_score >= 80 THEN
        SET NEW.status_label = 'Reliable';
    ELSEIF NEW.combined_score >= 50 THEN
        SET NEW.status_label = 'Questionable';
    ELSE
        SET NEW.status_label = 'Misleading';
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_verification_status_before_update
BEFORE UPDATE ON verification_scores
FOR EACH ROW
BEGIN
    IF NEW.combined_score >= 80 THEN
        SET NEW.status_label = 'Reliable';
    ELSEIF NEW.combined_score >= 50 THEN
        SET NEW.status_label = 'Questionable';
    ELSE
        SET NEW.status_label = 'Misleading';
    END IF;
END$$

DELIMITER ;
DELIMITER $$

CREATE TABLE verification_audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    report_id INT,
    score DECIMAL(5,2),
    status_label VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER trg_audit_verification
AFTER INSERT ON verification_scores
FOR EACH ROW
BEGIN
    INSERT INTO verification_audit_log (
        report_id,
        score,
        status_label
    )
    VALUES (
        NEW.report_id,
        NEW.combined_score,
        NEW.status_label
    );
END$$

>>>>>>> b7234eb0a4607a1b3be541d729ec896dce1dc0f3
DELIMITER ;