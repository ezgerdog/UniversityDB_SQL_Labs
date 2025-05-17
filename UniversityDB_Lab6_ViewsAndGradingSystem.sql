CREATE OR ALTER VIEW NonOverriddenFails AS
SELECT *
FROM takes
WHERE grade = 'F' 
AND ID NOT IN (
    SELECT ID
    FROM takes
    WHERE grade IN ('A', 'B', 'C', 'D')
);
GO
SELECT ID, COUNT(*) AS F_Grade_Count
FROM NonOverriddenFails
GROUP BY ID
HAVING COUNT(*) >= 2;

CREATE TABLE GradePoints (
    grade CHAR(1) PRIMARY KEY,
    point DECIMAL(8,2)
); 

INSERT INTO GradePoints (grade, point) VALUES
('A', 10),
('B', 8),
('C', 6),
('D', 4),
('F', 0);

SELECT 
    s.ID,
    AVG(gp.point) AS CPI
FROM 
    student s
LEFT JOIN 
    takes t ON s.ID = t.ID
LEFT JOIN 
    GradePoints gp ON t.grade = gp.grade
GROUP BY 
    s.ID;