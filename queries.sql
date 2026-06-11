SELECT publisher_name,
       COUNT(*) AS total_reports
FROM reports r
JOIN publishers p
ON r.publisher_id = p.publisher_id
GROUP BY publisher_name;

SELECT AVG(combined_score) AS average_score
FROM verification_scores;

SELECT COUNT(*) AS total_reports
FROM reports;