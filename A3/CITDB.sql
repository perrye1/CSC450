
-- if tables already exist, drop them

drop table Person;
drop table Owns;
drop table Car;
drop table Participated;
drop table Accident;

--create tables and insert tuples for Problem 1

create table Person
(Driver_id	numeric(2),
 Name		varchar2(20),
 Address	varchar2(15),
 primary key (Driver_id));

create table Car
(License	varchar2(7),
 Model		varchar2(8),
 Year		numeric(5),
 primary key (License));

create table Owns
(Driver_id	numeric(2),
 License	varchar2(7),
 primary key (License));
 
create table Accident
(Report_nr	varchar2(4),
 Accident_date	date,
 Location	varchar2(20),
 primary key (Report_nr));

create table Participated
(Report_nr	varchar2(4),
 License	varchar2(7),
 Driver_id	numeric(2),
 Damage_amt	numeric(10),
 primary key (Report_nr, License));

insert into Person values (0,'Jenson Button','University St');
insert into Person values (1,'Rubens Barrichello','1st Ave');
insert into Person values (2,'Sebastian Vettel','1st Ave');
insert into Person values (3,'Mark Webber','1st Ave');
insert into Person values (4,'Lewis Hamilton','1st Ave');
insert into Person values (5,'Felipe Massa','University St');

insert into Car values ('SZM813','Honda',2009);
insert into Car values ('SZM814','Toyota',2009);
insert into Car values ('SZM815','BMW',2009);
insert into Car values ('SZM816','Honda',2009);
insert into Car values ('SZM817','Honda',2008);
insert into Car values ('SZM818','BMW',2008);
insert into Car values ('SZM819','BMW',2008);
insert into Car values ('SZM820','Toyota',2008);

insert into Accident values ('R01','13-APR-2008','Monza');
insert into Accident values ('R02','22-JUL-2008','Indianapolis');
insert into Accident values ('R03','22-JUL-2008','Indianapolis');
insert into Accident values ('R04','22-JUL-2008','New York');
insert into Accident values ('R05','27-JUL-2008','New York');
insert into Accident values ('R06','27-JAN-2009','Highland Heights');
insert into Accident values ('R07','15-FEB-2009','Highland Heights');

insert into Owns values (0,'SZM813');
insert into Owns values (1,'SZM814');
insert into Owns values (2,'SZM815');
insert into Owns values (3,'SZM816');
insert into Owns values (4,'SZM817');
insert into Owns values (5,'SZM818');
insert into Owns values (0,'SZM819');
insert into Owns values (4,'SZM820');

insert into Participated values ('R01','SZM813',0,4000);
insert into Participated values ('R02','SZM814',1,6000);
insert into Participated values ('R03','SZM815',4,6000);
insert into Participated values ('R04','SZM814',1,1000);
insert into Participated values ('R05','SZM817',4,6000);
insert into Participated values ('R06','SZM818',5,5000);
insert into Participated values ('R07','SZM819',0,5000);
insert into Participated values ('R04','SZM817',4,3000);
insert into Participated values ('R05','SZM813',0,4000);
insert into Participated values ('R06','SZM814',3,2000);
insert into Participated values ('R07','SZM814',1,1000);
insert into Participated values ('R07','SZM820',4,6000);
insert into Participated values ('R07','SZM813',3,4000);

COMMIT;
