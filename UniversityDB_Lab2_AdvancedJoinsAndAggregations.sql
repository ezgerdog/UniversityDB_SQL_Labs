Select Title 
From Course 
Where Dept_name = 'Comp. Sci.' And Credits = 3;

Select Distinct Takes.ID 
From Takes
Join Teaches On Takes.Course_id = Teaches.Course_id And Takes.Sec_id = Teaches.Sec_id And Takes.Semester = Teaches.Semester And Takes.Year = Teaches.Year
Join Instructor On Teaches.ID = Instructor.ID
Where Instructor.Name = 'Einstein';

Select Max(Salary) As Highest_salary 
From Instructor;

Select Name 
From Instructor 
Where Salary = (Select Max(Salary) From Instructor);

Select Section.Course_id, Section.Sec_id, Count(Takes.ID) As Enrollment
From Section
Left Join Takes On Section.Course_id = Takes.Course_id And Section.Sec_id = Takes.Sec_id And Section.Semester = Takes.Semester And Section.Year = Takes.Year
Where Section.Semester = 'Fall' And Section.Year = 2017
Group By Section.Course_id, Section.Sec_id;

Select Max(Enrollment) As Max_enrollment
From (
    Select Count(Takes.ID) As Enrollment
    From Section
    Left Join Takes On Section.Course_id = Takes.Course_id And Section.Sec_id = Takes.Sec_id And Section.Semester = Takes.Semester And Section.Year = Takes.Year
    Where Section.Semester = 'Fall' And Section.Year = 2017
    Group By Section.Course_id, Section.Sec_id
) As Subquery;

Select Section.Course_id, Section.Sec_id
From Section
Left Join Takes On Section.Course_id = Takes.Course_id And Section.Sec_id = Takes.Sec_id And Section.Semester = Takes.Semester And Section.Year = Takes.Year
Where Section.Semester = 'Fall' And Section.Year = 2017
Group By Section.Course_id, Section.Sec_id
Having Count(Takes.ID) = (
    Select Max(Enrollment) 
    From (
        Select Count(Takes.ID) As Enrollment
        From Section
        Left Join Takes On Section.Course_id = Takes.Course_id And Section.Sec_id = Takes.Sec_id And Section.Semester = Takes.Semester And Section.Year = Takes.Year
        Where Section.Semester = 'Fall' And Section.Year = 2017
        Group By Section.Course_id, Section.Sec_id
    ) As Subquery
);
