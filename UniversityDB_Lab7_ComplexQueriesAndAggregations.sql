/* Easy question 1: List all students with their IDs and names, ordered alphabetically by last name */
SELECT ID, name 
FROM student 
ORDER BY name;

/* Easy question 2: Find all courses offered by the 'Comp. Sci.' department. */
SELECT title 
FROM course 
WHERE dept_name = 'Comp. Sci.';

/* Normal question 1: Count the number of students enrolled in each course.*/
SELECT c.course_id, COUNT(t.ID) AS student_count
FROM course c
LEFT JOIN takes t ON c.course_id = t.course_id
GROUP BY c.course_id;

/* Normal question 2: Find all students who have taken a course taught by an instructor from the 'Computer Science' department. Display the student's name, course ID, and instructor's name.*/
SELECT s.name AS student_name, t.course_id, i.name AS instructor_name
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN teaches te ON t.course_id = te.course_id AND t.sec_id = te.sec_id 
JOIN instructor i ON te.ID = i.ID
JOIN department d ON i.dept_name = d.dept_name
WHERE d.dept_name = 'Computer Science';

/* Hard question: Find instructors who earn more than the average salary in their department. */
SELECT i.ID, i.name, i.salary, i.dept_name
FROM instructor i
WHERE i.salary > (
    SELECT AVG(salary) 
    FROM instructor i2
    WHERE i2.dept_name = i.dept_name
);