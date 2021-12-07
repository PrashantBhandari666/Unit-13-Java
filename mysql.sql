/*----------------------
Creating Database
-----------------------*/
CREATE DATABASE MMC;

/*----------------------
Creating Tables
-----------------------*/
CREATE TABLE student (
    StudentID int,
    FirstName varchar(255),
    LastName varchar(255),
    RollNo int,
    City varchar(255)
);

CREATE TABLE teacher (
    TeacherID int,
    FirstName varchar(255),
    LastName varchar(255),
    Salary int,
    PRIMARY KEY (teacherID)
);

/*-------------------------
Inserting Records to Tables
--------------------------*/
INSERT INTO student VALUES (4, "Sachin", "Bhattrai", 67, "Chandragadi"); 
INSERT INTO student (StudentID, FirstName, LastName, RollNo, City) VALUES (1, "Prashant", "Bhandari", 39, "Birtamode"); 
INSERT INTO student (StudentID, FirstName, LastName, RollNo, City) VALUES (2, "Rakesh", "Oli", 33, "Chandragadi"); 
INSERT INTO student (StudentID, FirstName, LastName, RollNo, City) VALUES (3, "Bibas", "Gautam", 44, "Bhadrapur");   
INSERT INTO student (StudentID, FirstName, LastName, RollNo) VALUES (5, "Tina", "Jha", 66);

INSERT INTO teacher VALUES (1, "Sunil" ,"Sharma",80000);
INSERT INTO teacher (TeacherID, FirstName, LastName, Salary) VALUES (2, "Krishna", "Acharya",50000);
INSERT INTO teacher (TeacherID, FirstName, LastName) VALUES (3, "Ridip", "Khanal");

/*-------------------------
Updating Records in Tables
--------------------------*/
UPDATE student SET FirstName="Yugesh" WHERE StudentID=2;
UPDATE student SET LastName="Bhandari" WHERE StudentID=5;

UPDATE teacher SET Salary="90000" WHERE TeacherID=3;

/*-------------------------
Deleting Records in Tables
--------------------------*/
DELETE FROM student WHERE StudentID=3;

DELETE FROM teacher  WHERE FirstName="Ridip";

/*-------------------------
Selecting Records in Tables
--------------------------*/
SELECT * FROM student;
SELECT StudentId, FirstName, LastName FROM student;
SELECT * FROM student WHERE RollNo=39; 

SELECT * FROM teacher WHERE Salary=50000;
SELECT * FROM teacher WHERE Salary BETWEEN 60000 AND 100000;

/*----------------------
Deleting Table
-----------------------*/
DROP TABLE student;
DROP TABLE teacher;

/*----------------------
Deleting Database
-----------------------*/
DROP DATABASE MMC;


