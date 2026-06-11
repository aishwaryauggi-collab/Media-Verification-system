<<<<<<< HEAD
SELECT publisher_name,
       COUNT(*) AS total_reports
FROM reports r
JOIN publishers p
ON r.publisher_id = p.publisher_id
GROUP BY publisher_name;

SELECT AVG(combined_score) AS average_score
FROM verification_scores;

SELECT COUNT(*) AS total_reports
=======
SELECT publisher_name,
       COUNT(*) AS total_reports
FROM reports r
JOIN publishers p
ON r.publisher_id = p.publisher_id
GROUP BY publisher_name;

SELECT AVG(combined_score) AS average_score
FROM verification_scores;

SELECT COUNT(*) AS total_reports
>>>>>>> b7234eb0a4607a1b3be541d729ec896dce1dc0f3
FROM reports;