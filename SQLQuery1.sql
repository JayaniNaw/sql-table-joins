CREATE TABLE employee(  
	ID int PRIMARY KEY NOT NULL,
	Name varchar(30) NOT NULL
)

CREATE TABLE department(
	DeptNo int PRIMARY KEY NOT NULL,
	DeptName varchar(30) NOT NULL
)

ALTER TABLE employee
ADD DeptNo int

ALTER TABLE employee
ADD CONSTRAINT fk_dept_no
FOREIGN KEY (DeptNO)
REFERENCES department(DeptNO); 

INSERT INTO employee (ID,Name) VALUES (5000,'Silly'),(6000,'George'),(7000,'Nancy'),(8000,'Jasmine')


INSERT INTO department VALUES (10,'Accounting'),(20,'Sales'),(30,'Engineering')

SELECT* FROM employee
SELECT* FROM department

---INNER JOIN---
SELECT e.*,d.*
FROM employee e INNER JOIN department d ON e.DeptNo = d.DeptNo

---FULL JOIN---
SELECT e.id, e.Name,d.DeptName
FROM employee e FULL JOIN department d ON e.DeptNo = d.DeptNo

---RIGHT JOIN---selects all the rows from department table and records matches with employee table
SELECT e.Name,d.DeptName
FROM employee e RIGHT JOIN department d ON e.DeptNo = d.DeptNo

---LEFT JOIN---selects all the employees and records matches with department table
SELECT e.Name,d.DeptName
FROM employee e LEFT JOIN department d ON e.DeptNo = d.DeptNo

--Basic JOIN questions
--1. Display the names of employees who belong to a department, together with their department names.
SELECT e.Name,d.DeptName FROM employee e INNER JOIN department d ON e.DeptNo = d.DeptNo

--2. Display every employee and their department name, including employees without a department.
SELECT e.Name, d.DeptName FROM employee e LEFT JOIN department d  ON e.DeptNo = d.DeptNo
--SELECT e.Name, d.DeptName FROM department d RIGHT JOIN employee e  ON e.DeptNo = d.DeptNo

--3. Display every department and its employees, including departments without employees.
SELECT e.Name, d.DeptName FROM employee e RIGHT JOIN department d  ON e.DeptNo = d.DeptNo

--4. Display all employees and all departments, including unmatched records from either table.
SELECT e.Name,d.DeptName FROM employee e FULL JOIN department d ON e.DeptNo = d.DeptNo

--5. Display the names of employees working in the 'sales' department.
SELECT e.Name, d.DeptName FROM employee e INNER JOIN department d ON e.DeptNo = d.DeptNo WHERE d.DeptName = 'Sales'

--6. Find employees who have no matching department.
SELECT e.Name FROM employee e LEFT JOIN  department d ON e.DeptNo = d.DeptNo
WHERE d.DeptNo is NULL

--7. Find departments that have no employees.
SELECT d.DeptName FROM department d LEFT JOIN employee e ON d.DeptNo= e.DeptNo WHERE e.id is NULL

--8. Display only unmatched records from both tables—exclude all matching employee–department pairs.
SELECT e.id,e.Name,d.deptName FROM employee e FULL JOIN department d ON e.DeptNo = d.DeptNo
WHERE d.DeptNo is NULL OR e.id is NUll

--9. Count the employees in each department, including departments with zero employees.
SELECT d.DeptNo,d.DeptName, COUNT(e.id) FROM department d LEFT JOIN employee e ON d.DeptNo = e.DeptNo
GROUP BY d.DeptNo,d.DeptName

--10. Find departments with more than one employee.
SELECT d.DeptNo,d.deptName, COUNT(e.id) as #Employee FROM department d LEFT JOIN employee e ON d.DeptNo = e.DeptNo
GROUP BY d.DeptNo,d.DeptName
HAVING COUNT(e.id) >1
--Remember: WHERE filters individual rows; HAVING filters groups after aggregation.

--11. Find departments with exactly one employee.
SELECT d.DeptNo,d.DeptName,COUNT(e.id) as #Employee FROM department d LEFT JOIN employee e ON d.DeptNo = e.DeptNo
GROUP BY d.DeptNo,d.DeptName
HAVING COUNT(e.id) = 1

--12. Display all departments and their employee counts, ordered from highest to lowest.
SELECT d.DeptNo,d.DeptName,COUNT(e.id) as #Employee FROM department d LEFT JOIN employee e ON d.DeptNo = e.DeptNo
GROUP BY d.DeptNo,d.DeptName
ORDER BY COUNT(e.id) desc

--13. Find pairs of employees who work in the same department. 
--Do not pair an employee with themselves or repeat a pair in reverse order.
SELECT d.DeptNo,d.DeptName, e1.name as Employee1,e2.name as Employee2 FROM employee e1 INNER JOIN department d ON d.DeptNo = e1.DeptNo 
INNER JOIN employee e2 ON e1.DeptNo = e2.DeptNo AND e1.id < e2.id

--14. Display every employee and their department name. Show 'Not assigned' when no matching department exists.
SELECT e.Name, 
	CASE 
		WHEN d.deptName is NULL THEN 'Not assigned'
		ELSE d.deptName
	END AS DeptName
FROM employee e LEFT JOIN department d ON e.DeptNo = d.DeptNo 

--15. Write two queries that produce the same result: one using LEFT JOIN and another using RIGHT JOIN
SELECT d.DeptName,e.Name FROM employee e LEFT JOIN department d ON e.DeptNo = d.DeptNo
SELECT d.DeptName,e.Name FROM department d RIGHT JOIN employee e ON e.DeptNo = d.DeptNo