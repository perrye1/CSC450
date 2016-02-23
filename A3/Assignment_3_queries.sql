/*a*/
select name, NVL(total.num_cars,0) as num_of_toyota_or_honda
from person
left join
  (Select driver_id, count (model) as num_cars
  from owns
  join car on owns.LICENSE = car.LICENSE
  where model like 'Toyota' or model like 'Honda'
  group by driver_id
) total
on person.DRIVER_ID = total.driver_id;

/*b*/
select name, num_toyota_or_honda
from person p,
lateral (
  select count(model) as num_toyota_or_honda
  from owns
  join car on owns.license = car.license
  where (p.driver_id = owns.driver_id) and ((model like 'toyota') or (model like 'honda'))
);

/*c*/
select report_nr, sum (damage_amt)
from participated
where report_nr in(
  select report_nr
  from car
  join participated on car.license = participated.license
  where model like 'Honda' or model like 'Toyota'
)
group by report_nr;

/*d*/
select report_nr, avg(damage_amt)
from participated
where report_nr not in(
  select report_nr
  from car
  join participated on car.license = participated.license
  join owns on car.license = owns.license
  join person on owns.driver_id = person.driver_id
  where name like 'Rubens Barrichello'
)
group by report_nr;

/*e*/
insert into Accident values ('R08','21-FEB-2016','Cold Spring');
insert into Participated values ('R08','SZM818',5,2000);
insert into Participated values ('R08','SZM815',2,3000);

/*f*/
delete from 
owns
where license in
(
  select license
  from car
  where model like 'Toyota'
);
delete from 
participated
where license in
(
  select license
  from car
  where model like 'Toyota'
);
delete
  from car
  where model like 'Toyota';

/*g*/
update participated
set damage_amt = damage_amt*1.1
where report_nr in (
  select participated.report_nr 
  from participated
  join accident on accident.report_nr = participated.REPORT_NR
  where to_char(accident_date, 'YYYY') like '2009'
);
select participated.report_nr 
  from participated
  join accident on accident.report_nr = participated.REPORT_NR
  where to_char(accident_date, 'YYYY') like '2009';

/*h*/
grant select on car to user_y;
grant select on accident to user_y;
grant select on participated to user_y;
grant update,insert,delete on participated.damage_amt to user_y;

/*g*/
create view test_view as (
    select * from participated
    where report_nr in (
    select participated.report_nr 
    from participated
    join accident on accident.report_nr = participated.REPORT_NR
    where to_char(accident_date, 'YYYY') like '2009'
  )
);
grant select on test_view to user_y;