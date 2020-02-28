/* 2.1 Write the correct SQL statement to create the following table:
Spartans Table – include details about all the Spartans on this course. Separate Title, 
First Name and Last Name into separate columns, and include University attended, 
course taken and mark achieved. Add any other columns you feel would be appropriate. 
IMPORTANT NOTE: For data protection reasons do NOT include date of birth in this exercise. */

DROP TABLE SPARTANS;

CREATE TABLE SPARTANS (

SpartaID INT IDENTITY(1,1),
LastName VARCHAR(20) NOT NULL,
FirstName VARCHAR(20) NOT NULL,
Title VARCHAR(4),
Age VARCHAR(3),
City VARCHAR(20) DEFAULT 'London',
[Univeristy Attended] VARCHAR(100),
[University Course] VARCHAR(50),
Mark VARCHAR(3)
PRIMARY KEY (SpartaID)
)




-- 2.2 Write SQL statements to add the details of the Spartans in your course to the table you have created. 

INSERT INTO SPARTANS (LastName, FirstName, Title, Age, [Univeristy Attended], [University Course], Mark)
VALUES 
('Harris', 'Elliot', 'Mr.', '23', 'Canterbury Christ Church University', 'History', '2:2'), 
('Jahromi', 'Mahan', 'Mr.', '23', 'Portsmouth University', 'Math', '2:1'),
('Davenport', 'Zack', 'Mr.', '24', 'University Of East Anglia', 'Film and Television', '2:2'),
('Hovell', 'James', 'Mr.', '23', 'Portsmouth University', 'Math', '1st'),
('Ayyaz', 'Abdullah', 'Mr.', '25', 'Westminster University', 'Business Economics', '2:1'),
('Monterio', 'Kevin', 'Mr.', '23', 'CADS Business School', 'MTF', '2:2')


SELECT * FROM SPARTANS 

-- 3.1 List all Employees from the Employees table and who they report to. No Excel required. (5 Marks)




-- 3.2 List all Suppliers with total sales over $10,000 in the Order Details table. Include the Company Name from the Suppliers Table and present as a bar chart as below: (5 Marks)
 




-- 3.3 List the Top 10 Customers YTD for the latest year in the Orders file. Based on total value of orders shipped. No Excel required. (10 Marks)





-- 3.4 Plot the Average Ship Time by month for all data in the Orders Table using a line chart as below. (10 Marks)
