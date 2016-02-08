/*1b*/
select Full_Name 
from A2_EMPLOYEES_SAMPLE
where ASSIGNMENT_CATEGORY like 'Parttime-Regular';

/*1c*/
select count(DISTINCT department)
from A2_EMPLOYEES_SAMPLE;

/*2b*/
Select Full_Name 
from A2_EMPLOYEES
where DEPARTMENT like (
    Select DEPARTMENT
    From A2_EMPLOYEES
    where FULL_NAME like 'Adcock Sr Gerald W' );

/*2c*/    
Select department, count(department) as num_employees
from A2_EMPLOYEES 
group by DEPARTMENT;

/*4a*/
select distinct student.SNAME,student.GPA
from enroll 
join STUDENT on STUDENT.SID = enroll.SID
where cno = 351;

/*4b*/
select sname
from STUDENT
where age = (
    select max(age)
    from student);
 
/*4c*/   
select distinct student.sname,major.dname
from enroll 
inner join STUDENT on STUDENT.SID = enroll.SID
inner join course on course.CNO = enroll.CNO
inner join major on major.SID = STUDENT.SID
where course.CNAME like 'World History%';

/*4d*/
select sname 
from student
where sid in (
    select sid 
    from enroll
    where dname like 'Comp. Sci.')
and sid in (
    select sid 
    from enroll
    where dname like 'Elec. Eng.');

/*4e*/
select count(*)
from student
where sid in (
    select sid
    from major
    group by sid
    having count(dname) > 1);

/*4f*/  
select sname
from student
where sex like 'M' and age = (
    select max(age)
    from student
    where sex like 'M');

/*4g*/
select sname,sid
from student
where sid not in (
    select enroll.sid
    from enroll
    inner join major on major.sid = enroll.sid
    where major.dname = enroll.dname);
