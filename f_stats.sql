create view v_ALL(pb_id, e1) as
select m.pb_id, cast(m.exp as INT) from probe p, microarray_fact m where u_id in
(select u_id from gene_fact where go_id='7154')
and m.s_id in 
(select  distinct  s_id
from clinical_fact cf
where p_id in (
select  distinct p_id
from clinical_fact c, disease d
where d.name='ALL'
and c.ds_id=to_char(d.ds_id))
and s_id != 'null')
and to_char(p.pb_id)=m.pb_id;

create view v_AML(pb_id, e2) as
select m.pb_id, cast(m.exp as INT) from probe p, microarray_fact m where u_id in
(select u_id from gene_fact where go_id='7154')
and m.s_id in 
(select  distinct  s_id
from clinical_fact cf
where p_id in (
select  distinct p_id
from clinical_fact c, disease d
where d.name='AML'
and c.ds_id=to_char(d.ds_id))
and s_id != 'null')
and to_char(p.pb_id)=m.pb_id;

create view v_c_tumor(pb_id, e3) as
select distinct m.pb_id from probe p, microarray_fact m where u_id in
(select u_id from gene_fact where go_id='7154')
and m.s_id in 
(select  distinct  s_id
from clinical_fact cf
where p_id in (
select  distinct p_id
from clinical_fact c, disease d
where d.name='Colon tumor'
and c.ds_id=to_char(d.ds_id))
and s_id != 'null')
and to_char(p.pb_id)=m.pb_id;

create view v_b_tumor(pb_id, e4) as
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


select a. pb_id, a.e1, b.e2, c.e3, d.e4 from 
(select m.pb_id, cast(m.exp as INT) e1 from probe p, microarray_fact m where u_id in
(select u_id from gene_fact where go_id='7154')
and m.s_id in 
(select  distinct  s_id
from clinical_fact cf
where p_id in (
select  distinct p_id
from clinical_fact c, disease d
where d.name='ALL'
and c.ds_id=to_char(d.ds_id))
and s_id != 'null')
and to_char(p.pb_id)=m.pb_id) a,
(select m.pb_id, cast(m.exp as INT) e2 from probe p, microarray_fact m where u_id in
(select u_id from gene_fact where go_id='7154')
and m.s_id in 
(select  distinct  s_id
from clinical_fact cf
where p_id in (
select  distinct p_id
from clinical_fact c, disease d
where d.name='AML'
and c.ds_id=to_char(d.ds_id))
and s_id != 'null')
and to_char(p.pb_id)=m.pb_id) b,
(select m.pb_id, cast(m.exp as INT) e3 from probe p, microarray_fact m where u_id in
(select u_id from gene_fact where go_id='7154')
and m.s_id in 
(select  distinct  s_id
from clinical_fact cf
where p_id in (
select  distinct p_id
from clinical_fact c, disease d
where d.name='Colon tumor'
and c.ds_id=to_char(d.ds_id))
and s_id != 'null')
and to_char(p.pb_id)=m.pb_id) c,
(select m.pb_id, cast(m.exp as INT) e4 from probe p, microarray_fact m where u_id in
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
and to_char(p.pb_id)=m.pb_id) d  
where a.pb_id=b.pb_id
and a.pb_id=c.pb_id
and a.pb_id=d.pb_id
;



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
and c.ds_id=to_char(d.ds_id)) c;

select * from disease;

select e1,e2 from v_all v1,v_aml v2
where v1.pb_id=v2.pb_id ;

select * from v_ALL,v_AML,v_c_tumor, v_b_tumor;

select 