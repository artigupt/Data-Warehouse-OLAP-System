create table patient_new
(p_id int,
exp int,
ssn varchar(50),
name varchar(80),
gender varchar(8),
DOB DATE);

insert into patient_new
select p.p_id,cast(m.exp as int), p.ssn, p.name, p.gender, p.dob
from  patient p
left join clinical_fact cf on cf.p_id=p.p_id
left join microarray_fact m on m.s_id=cf.s_id
;

create table msample
(s_id int,
p_id int,
DOB DATE);

insert into msample
select cf.s_id,p.p_id,  dob
from patient p, clinical_fact cf
where cf.s_id in (select to_char(s_id) from sample s where to_char(s.s_id)=cf.s_id)
and cf.p_id=to_char(p.p_id);




create table mdisease
(ds_id int,
p_id int,
name varchar(50),
type varchar(50),
description varchar(50));

insert into mdisease
select d.ds_id, cast(cf.p_id as int), d.name, d.type, d.description
from disease d, clinical_fact cf
where cf.p_id in (select to_char(p_id) from patient p where to_char(p.p_id)=cf.p_id)
and cf.ds_id=to_char(d.ds_id);

create table mdrug
(dr_id int,
p_id int,
type varchar(100));

insert into mdrug
select dr.dr_id,cast(cf.p_id as int),  dr.type
from drug dr, clinical_fact cf
where cf.p_id in (select to_char(p_id) from patient p where to_char(p.p_id)=cf.p_id)
and cf.dr_id=to_char(dr.dr_id);

create table mgene
(u_id int,
p_id int,
status varchar(50));

insert into mgene
select g.u_id,cast(cf.p_id as int),  g.status
from  clinical_fact cf
left join microarray_fact m on m.s_id=cf.s_id
left join probe pb on to_char(pb.pb_id)=m.pb_id
left join gene g on pb.u_id=g.u_id
left join patient p on to_char(p.p_id)=cf.p_id
;


create table mprobe
(pb_id int,
p_id int,
ISQC varchar(50));

insert into mprobe
select pb.pb_id,cast(cf.p_id as int),  pb.ISQC
from  clinical_fact cf
left join microarray_fact m on m.s_id=cf.s_id
left join probe pb on to_char(pb.pb_id)=m.pb_id
left join patient p on to_char(p.p_id)=cf.p_id
;




create table mgo
(go_id int,
p_id int,
type varchar(50));

insert into mgo
select g.go_id,cast(cf.p_id as int), g.type
from  microarray_fact m
left join probe pb on to_char(pb.pb_id)=m.pb_id
left join gene_fact ge on to_char(pb.u_id)=ge.u_id
left join go g on to_char(g.go_id)=ge.go_id
left join clinical_fact cf on cf.s_id=m.s_id
;

commit;


create table m_measure
(mu_id int,
p_id int,
type varchar(50));

insert into m_measure
select mu.mu_id,cast(cf.p_id as int), mu.type
from  microarray_fact m
left join measureunit mu on to_char(mu.mu_id)=m.mu_id
left join clinical_fact cf on cf.s_id=m.s_id
;


create table m_cluster
(cl_id int,
p_id int,
sympton varchar(50));
   

insert into m_cluster;
select cl.cl_id,cast(cf.p_id as int),  cl.num
from  clinical_fact cf
left join microarray_fact m on m.s_id=cf.s_id
left join probe pb on to_char(pb.pb_id)=m.pb_id
left join gene_fact ge on to_char(pb.u_id)=ge.u_id
left join cluster1 cl on to_char(cl.cl_id)=ge.cl_id
left join patient p on to_char(p.p_id)=cf.p_id
;