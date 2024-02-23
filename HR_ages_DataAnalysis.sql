create database HR_Aegis;
use HR_Aegis;
create table StudentInfo( ID int primary key,
 Fname varchar(20),
 Lname varchar(20),
 Dept varchar(10),
Project varchar(10),
Address varchar(20),
DOB date,
Gender varchar(2));
insert into StudentInfo values(1,"Sanjay","Mehra",
"Admin","P1","Hyderabad(HYD)",'1976-12-01','M');
update StudentInfo set Dept= "HR" where ID=1;
insert into StudentInfo values(2,"Ananya","Mishra",
"Admin","P2","Delhi(DEL)",'1968-05-02','M');
update StudentInfo set Gender= "F" where ID=2;
insert into StudentInfo values(3,"Rohan","Diwan",
"Account","P3","Mumbai(BOM)",'1980-01-01','M');
insert into StudentInfo values(4,"Sonia","Kulkarni",
"HR","P1","Hyderabad(HYD)",'1992-05-02','F');
insert into StudentInfo values(5,"Ankit","Kapoor",
"Admin","P2","Delhi(DEL)",'1994-07-03','M');
select * from StudentInfo;

create table StudentCourse(StudentID int,Course varchar(20),DOJ date,Fees int,
foreign key(StudentID) references StudentInfo(ID));
insert into StudentCourse values(1,"BCA",'2022-05-01',500000),
(2,"MCA",'2022-05-02',75000),
(3,"BBA",'2022-05-01',90000),
(2,"BCom",'2022-05-02',85000),
(1,"BCA",'2022-05-01',300000);

/*question 1 *Write a query to fetch the Fname from the StudentInfo table in upper case and use the
ALIAS name as StudentName.*/
select upper(Fname) as StudentName from StudentInfo; 

/*question 2 Write a query to fetch the number of students join in the course ‘MCA’. */
select count(distinct(ID)) from StudentInfo a inner join 
StudentCourse b on a.ID = b.StudentID  where Course ="MCA"  ;

/*question 3 Write a query to get the current date. */
select current_date() ;

/*question 4 Write a query to retrieve the first four characters of
 Lname from the StudentInfo table. */
 select Lname from StudentInfo;
 select substring(Lname,1,4) from StudentInfo ;
 
/* question 5  Write a query to fetch only the place name
(string before brackets) from the Address column
of StudentInfo table.*/

select substring(Address,1,locate("(",Address)-1) from StudentInfo;

/* question 6  Write a query to create a new table which consists of data and structure copied from the
other table.*/

create table StudentInfo2 as select * from StudentInfo;
select * from StudentInfo2

/* question 7  Write a query to find all the students whose fees is between 50000 to 100000.*/
select concat(Fname," ", Lname) from StudentInfo  where Id in 
(select StudentId from StudentCourse where fees between 50000 and 100000);

/* question 8  Write a query to find the names of Student that begin with ‘S’*/
select Fname from StudentInfo where Fname like 'S%' ;

/* question 9 Write a query to fetch top N records.*/ 
/*this top query will only  rum in sql server
 here is syntax
 select top(n) from table_name;
 In mysql
 */ 
 select fname from studentInfo limit 2;
 
 /* question 10 Write a query to retrieve the Fname and Lname in a single column as “FullName”. The first
name and the last name must be separated with space..*/ 
select concat(Fname," ", Lname) from StudentInfo ;

 /* question 11 Write a query find number of students whose DOB is between 02/05/1970 to 31/12/1975
and are grouped according to gender*/ 
select count(Id) from StudentInfo where DOB between '1970-05-02' and '1975-12-31';


  /* question 12. Write a query to fetch all the records from the StudentInfo table ordered by Lname in
descending order and Course in the ascending order.r*/ 

select * from StudentInfo a inner join StudentCourse b on  a.Id = b.StudentId order by Lname desc, course asc ;
 
  /* question 13. Write a query to fetch details of Students whose Lname ends with an alphabet ‘A’ and
contains five alphabets.*/ 
select * from studentinfo where Lname like '%a' and Lname like '_____';

  /* question 14.Write a query to fetch details of all students excluding the students with first names,
“Sanjay” and “Sonia” from the StudentInfo table..*/ 
select * from studentinfo a inner join StudentCourse b on a.Id= b.studentId  where Fname not in  (select Fname from studentinfo where Fname in ('Sanjay','Sonia') )

 /* question 15 Write a query to fetch details of students with the address as “DELHI(DEL)”..*/ 
 select * from studentinfo a inner join StudentCourse b on a.Id= b.studentId  where address= 'Delhi(DEL)'
 
  /* question 16 Write a query to fetch all students who also hold the MCA course.*/ 
  select * from studentinfo a inner join StudentCourse b on a.Id= b.studentId where course = "MCA"
  
 /* question 17  Write a query to fetch the course-wise count of students sorted by course’s count in
ascending order..*/   
select count(studentid),course from studentcourse group by course order by count(course) asc;
  
  
  /* question 18 Write a query to calculate the even and odd rows from a table. */ 
  /*even row*/
  select * from  studentinfo where mod(ID,2)=0;
  /*odd row*/
  select * from  studentinfo where mod(ID,2)!=0;
  
  /* question 19 Write a SQL query to retrieve year wise student count of each course. */ 
     
 select count(b.course) ,doj from studentinfo a inner join StudentCourse b on a.Id= b.studentId 
 group by b.DOJ;



 /* question 20 Write a query to retrieve two minimum and maximum fees from the StudentCourse table. */
SELECT DISTINCT Fees AS MIN FROM studentCourse ORDER BY Fees DESC LIMIT 2
SELECT DISTINCT Fees  AS MAX FROM studentCourse ORDER BY Fees ASC LIMIT 2

 
/* question 21 Write a query to find the 4th highest fees from the table without using TOP/limit keyword. */ 
select max(fees) from studentcourse where fees<(SELECT MAX(FEES) FROM STUDENTCOURSE WHERE FEES<(SELECT MAX(FEES) FROM STUDENTCOURSE WHERE FEES < (SELECT MAX(FEES) FROM STUDENTCOURSE)));

/* question 22 Write a query to retrieve duplicate records from a table. */ 
 select id,concat(fname," ",lname) from studentinfo a inner join StudentCourse b on a.Id= b.studentId group by a.id having count(a.id)>1

/* question  23. Write a query to retrieve the list of students working in the same course.*/ 
 select * from studentinfo a inner join StudentCourse b on a.Id= b.studentId
 
/* question  24. Write a query to retrieve the last 3 records from the StudentInfo table..*/ 
select * from studentinfo order by id desc limit 3; 


/* question  25. Write a query to find the third-highest salary--FEES from the StudentCourse table.*/ 
SELECT MAX(FEES) FROM STUDENTCOURSE WHERE FEES<(SELECT MAX(FEES) FROM STUDENTCOURSE WHERE FEES < (SELECT MAX(FEES) FROM STUDENTCOURSE));
 
/* question  26. Write a query to display the first and the last record from the StudentInfo table.*/  
(select * from studentinfo ORDER BY ID ASC LIMIT 1)
UNION
(select * from studentinfo ORDER BY ID DESC LIMIT 1);
 
/* question  27.Create function to check email is valid or not.*/  
CREATE FUNCTION checkemail(email VARCHAR(200))
RETURNS INT
BEGIN
  DECLARE result INT;
  SET result = email REGEXP '^[a-zA-Z0-9][a-zA-Z0-9.!#$%&''*+-/=?^_`{|}~]*@[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9]\\.[a-zA-Z]{2,63}$';
  RETURN result;
END

/* question  28. Write a query to retrieve course who have less than 2 students working in it.*/ 
select COURSE,COUNT(id)  from studentinfo a inner join StudentCourse b on a.Id= b.studentId GROUP BY COURSE HAVING COUNT(COURSE)<2; 
 
/* question 29 Write a query to retrieve course along with total fees paid for each of them.*/ 
 select COURSE,SUM(FEES) AS `TOTAL FEES` from studentinfo a inner join StudentCourse b on a.Id= b.studentId  GROUP BY COURSE; 

/* question 30 Write a query to fetch 50% records from the StudentInfo table.*/
select * from STUDENTINFO where id <= (select count(ID)/2 from STUDENTINFO);