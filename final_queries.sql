1:

select patient_count_ALL, patient_count_leukemia, patient_count_tumor
from
(select count(distinct c.p_id) patient_count_ALL
from clinical_fact c, disease d
where d.name='ALL'
and c.ds_id=to_char(d.ds_id)) a,
(select count(distinct c.p_id) patient_count_leukemia
from clinical_fact c, disease d
where d.type='leukemia'
and c.ds_id=to_char(d.ds_id)) b,
(select count(distinct c.p_id) patient_count_tumor
from clinical_fact c, disease d
where d.description='tumor'
and c.ds_id=to_char(d.ds_id)) c ;


2:

select distinct a.type
from drug a,
(select distinct c.p_id, c.dr_id 
from clinical_fact c, disease d
where d.description='tumor'
and c.ds_id=to_char(d.ds_id)) b
where to_char(a.dr_id)=b.dr_id;


3:

select distinct s_id, exp from microarray_fact where
pb_id in 
(select pb_id from probe p
where u_id in 
(select u_id from gene_fact g where cl_id='2'))
and mu_id='1'
and s_id in (select  distinct s_id
from clinical_fact cf
where p_id in (
select  distinct p_id
from clinical_fact c, disease d
where d.name='ALL'
and c.ds_id=to_char(d.ds_id))
and s_id != 'null');


4:
create view v2(p2,e2) as
select m.pb_id, cast(m.exp as INT) from probe p, microarray_fact m where u_id in
(select u_id from gene_fact where go_id='7154')
and m.s_id in 
(select  distinct  s_id
from clinical_fact cf
where p_id in (
select  distinct p_id
from clinical_fact c, disease d
where d.name != 'Breast tumor'
and c.ds_id=to_char(d.ds_id))
and s_id != 'null')
and to_char(p.pb_id)=m.pb_id;

create view v1(p1,e1) as
select m.pb_id, cast(m.exp as INT) from probe p, microarray_fact m where u_id in
(select u_id from gene_fact where go_id='7154')
and m.s_id in 
(select  distinct  s_id
from clinical_fact cf
where p_id in (
select  distinct p_id
from clinical_fact c, disease d
where d.name='Breast tumor'
and c.ds_id=to_char(d.ds_id))
and s_id != 'null')
and to_char(p.pb_id)=m.pb_id;

R_work:

e1 <- dbGetQuery(con, "SELECT e1 FROM v1")
e2 <- dbGetQuery(con, "SELECT e2 FROM v2")

t_stat <- t.test(e1,e2)



5:


create view v_probe_w(pb_id,s_id, exp) as
select p.pb_id, s_id, cast(m.exp as INT) from probe p, microarray_fact m 
where u_id in 
(select u_id from gene_fact where go_id='10083')
and p.pb_id=m.pb_id;


CREATE TABLE f_stats
(pb_id varchar(50),
exp_val varchar(50),
disease varchar(50)
);

insert into f_stats(pb_id, exp_val, disease) 
select pb_id,exp,'ALL' from  v_probe
where s_id in (select  distinct s_id
from clinical_fact cf
where p_id in (
select  distinct p_id
from clinical_fact c, disease d
where d.name='ALL'
and c.ds_id=to_char(d.ds_id))
and s_id != 'null');





insert into f_stats(exp_val, disease) 
select exp,'AML' from  v_probe
where s_id in (select  distinct s_id
from clinical_fact cf
where p_id in (
select  distinct p_id
from clinical_fact c, disease d
where d.name='AML'
and c.ds_id=to_char(d.ds_id))
and s_id != 'null');



insert into f_stats(exp_val, disease) 
select exp,'ALL' from  v_probe
where s_id in (select  distinct s_id
from clinical_fact cf
where p_id in (
select  distinct p_id
from clinical_fact c, disease d
where d.name='ALL'
and c.ds_id=to_char(d.ds_id))
and s_id != 'null');


insert into f_stats(exp_val, disease) 
select exp,'Colon tumor' from  v_probe
where s_id in (select  distinct s_id
from clinical_fact cf
where p_id in (
select  distinct p_id
from clinical_fact c, disease d
where d.name='Colon tumor'
and c.ds_id=to_char(d.ds_id))
and s_id != 'null');


f <- dbGetQuery(con, "select * from f_stats")
m <- data.frame(f)

fa <- oneway.test(EXP_VAL~DIS, data = m, var.equal = TRUE)

print(fa)