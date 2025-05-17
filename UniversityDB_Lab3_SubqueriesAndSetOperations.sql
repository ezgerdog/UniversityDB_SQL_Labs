SELECT 
    MAX(enrollment) AS max_enrollment, 
    MIN(enrollment) AS min_enrollment
FROM (
    SELECT COUNT(ID) AS enrollment
    FROM takes
    GROUP BY course_id, sec_id, semester, year
) AS enrollments;
SELECT course_id, sec_id, semester, year, COUNT(ID) AS enrollment
FROM takes 
GROUP BY course_id, sec_id, semester, year
HAVING COUNT(ID) = (
    SELECT MAX(enrollment)
    FROM (
        SELECT COUNT(ID) AS enrollment
        FROM takes
        GROUP BY course_id, sec_id, semester, year
    ) AS max_enroll
);

SELECT s.course_id, s.sec_id, s.semester, s.year, 
       (SELECT COUNT(*) 
        FROM takes t
        WHERE t.course_id = s.course_id AND t.year = s.year) AS enrollment
FROM section s;

SELECT s.course_id, s.sec_id, s.semester, s.year, COUNT(t.ID) AS enrollment
FROM section s
LEFT JOIN takes t 
    ON s.course_id = t.course_id 
    AND s.sec_id = t.sec_id 
    AND s.semester = t.semester 
    AND s.year = t.year
GROUP BY s.course_id, s.sec_id, s.semester, s.year;

SELECT *
FROM course
WHERE course_id LIKE 'CS-1%';

SELECT DISTINCT i.ID, i.name
FROM instructor i
WHERE NOT EXISTS (
    SELECT c.course_id
    FROM course c
    WHERE c.course_id LIKE 'CS-1%'
    EXCEPT
    SELECT t.course_id
    FROM teaches t
    WHERE t.ID = i.ID
);

SELECT i.ID, i.name
FROM instructor i
JOIN teaches t 
    ON i.ID = t.ID
WHERE t.course_id LIKE 'CS-1%'
GROUP BY i.ID, i.name
HAVING COUNT(DISTINCT t.course_id) = (
    SELECT COUNT(DISTINCT course_id)
    FROM course
    WHERE course_id LIKE 'CS-1%'
);
