CREATE TABLE student_club (
    club_id INT PRIMARY KEY,
    club_name NVARCHAR(100) NOT NULL,
    ID varchar(5), 
    i_ID varchar(5),
    founded_year INT CHECK (founded_year > 1900),
    FOREIGN KEY (ID) REFERENCES student(ID)
);

INSERT INTO student_club (club_id, club_name, ID , i_ID, founded_year)
VALUES (1, 'Robotics Club', '00128', '45565' , 2015);

INSERT INTO student_club (club_id, club_name, ID , i_ID, founded_year) 
VALUES (2, 'Math Club', '12345', '10101' , 2011);

SELECT *
FROM student_club
WHERE founded_year > 2010
  AND club_name LIKE '%Robotics%';

SELECT sc.club_name, s.name AS student_name, sc.founded_year
FROM student_club sc
INNER JOIN student s ON sc.ID = s.ID;

SELECT club_id, club_name, founded_year
FROM student_club
WHERE founded_year > (
    SELECT AVG(founded_year)
    FROM student_club
);
