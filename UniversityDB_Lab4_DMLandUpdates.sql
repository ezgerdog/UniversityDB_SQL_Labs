INSERT INTO student (ID, name, dept_name, tot_cred)
SELECT ID, name, dept_name, 0
FROM instructor
WHERE ID NOT IN (SELECT ID FROM student);

DELETE FROM student
WHERE tot_cred = 0
  AND ID IN (SELECT ID FROM instructor);

UPDATE instructor
SET salary = 29003 * (
    SELECT COUNT(*)
    FROM teaches
    WHERE teaches.ID = instructor.ID
)
WHERE (SELECT COUNT(*)
       FROM teaches t
       WHERE t.ID = instructor.ID) > 0;

SELECT
    s.ID AS student_id,
    s.name AS student_name,
    c.title AS course_title,
    COUNT(*) AS time_taken,
    s.tot_cred AS total_credits,  
    i.salary AS instructor_salary  
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
LEFT JOIN instructor i ON i.ID = t.ID 
GROUP BY
    s.ID, s.name, c.title, s.tot_cred, i.salary
ORDER BY
    s.ID, c.title;
