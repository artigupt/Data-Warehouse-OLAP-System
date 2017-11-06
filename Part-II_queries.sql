Part-III


1. a.

groupA <- dbGetQuery(con,"select distinct c.p_id from clinical_fact c, disease d where d.name='AML'and c.ds_id=to_char(d.ds_id)")


groupB <- dbGetQuery(con,"select distinct c.p_id from clinical_fact c, disease d where d.name !='AML'and c.ds_id=to_char(d.ds_id)")

b. 

create view view_gene1(u_id,exp1) as
select  distinct u_id, exp from clinical_fact cf, microarray_fact m, probe p where p_id in ( select  distinct c.p_id from clinical_fact c, disease d where d.name='AML' and c.ds_id=to_char(d.ds_id)) and cf.s_id != 'null' and m.s_id=cf.s_id and p.pb_id=m.pb_id;

create view view_gene2(u_id,exp2) as
select  distinct u_id, exp from clinical_fact cf, microarray_fact m, probe p where p_id in ( select  distinct c.`p_id from clinical_fact c, disease d where d.name !='AML' and c.ds_id=to_char(d.ds_id)) and cf.s_id != 'null' and m.s_id=cf.s_id and p.pb_id=m.pb_id;


CREATE TABLE v_gene
(
gene number,
value varchar(2),
exp varchar(20)
);

insert into v_gene (gene, value, exp)
select u_id, '0', exp1 from view_gene1;

insert into v_gene (gene, value, exp)
select u_id, '1', exp2 from view_gene2;
 
  select gene ,
      round(avg(decode(value, '0', exp, null)),2) d_all,
      round(avg(decode(value, '1', exp, null)),2) d_other,
      round(stats_t_test_indep(value, exp, 'STATISTIC', '0'),2) t_stats,
      round(stats_t_test_indep(value, exp),2) p_value
  FROM v_gene
  group by rollup(gene);


c:

 create view informative(gene, p_value) as
 select gene, p_value from
  (select gene ,
      round(avg(decode(value, '0', exp, null)),2) d_all,
      round(avg(decode(value, '1', exp, null)),2) d_other,
      round(stats_t_test_indep(value, exp, 'STATISTIC', '0'),2) t_stats,
      stats_t_test_indep(value, exp) p_value
  from v_gene
  group by rollup(gene));
  
  select gene from informative
  where p_value < 0.01;




Part-III:

2: a:

    (select distinct t.u_id from test_samples t, informative i
  where i.gene=t.u_id
  and  i.p_value < 0.01);
  
  
  b:
  
    create view inform_all(p_id, u_id,exp1) as
select  distinct cf.p_id, u_id, exp 
from clinical_fact cf, microarray_fact m, probe p 
where p_id in ( select  distinct p_id from clinical_fact c, disease d where d.name='ALL' and c.ds_id=to_char(d.ds_id)) 
and cf.s_id != 'null' 
and m.s_id=cf.s_id 
and p.pb_id=m.pb_id;

    (select distinct ia.p_id from test_samples t, inform_ALL ia, informative i
  where i.gene=t.u_id
  and ia.u_id=i.gene
  and  i.p_value < 0.01);
  
  
  
  c:
  
    create table informative_all_groupa
  (pa_id int,
  exp1 int);
  
    create table pn_groupa
  (pn_id int,
  exp int);
  
  insert into informative_all_groupa
select  distinct cast(cf.p_id as int),  exp 
from clinical_fact cf, microarray_fact m, probe p 
where p_id in ( select  distinct p_id from clinical_fact c, disease d where d.name='ALL' and c.ds_id=to_char(d.ds_id)) 
and cf.s_id != 'null' 
and m.s_id=cf.s_id 
and p.pb_id=m.pb_id;

     insert into  pn_groupa (pn_id, exp) 
    select distinct cast(ia.p_id as int), cast(ia.exp1 as int) from test_samples t, inform_ALL ia, informative i
  where i.gene=t.u_id
  and ia.u_id=i.gene
  and  i.p_value < 0.01;
  
    create view v_n(p_id, exp1, exp2) as
  select pa.pa_id p_id, pa.exp1 exp1, pna.exp exp2
  from informative_all_groupa pa, pn_groupa pna
  where pa.pa_id=pna.pn_id;
  
  select p_id,
       corr_s(exp1, exp2) rA
from v_n
group by p_id;
  
  
  d:
  
  create view inform_notall(p_id, u_id,exp2) as
select  distinct cf.p_id, u_id, exp from clinical_fact cf, microarray_fact m, probe p 
where p_id in ( select  distinct p_id from clinical_fact c, disease d where d.name !='ALL' and c.ds_id=to_char(d.ds_id)) 
and cf.s_id != 'null' 
and m.s_id=cf.s_id 
and p.pb_id=m.pb_id;

  
      (select distinct ia.p_id from test_samples t, inform_notALL ia, informative i
  where i.gene=t.u_id
  and ia.u_id=i.gene
  and  i.p_value < 0.01);
  
  
  e:
  
  
    
    create table informative_all_groupb
  (pb_id int,
  exp1 int);
  
    create table pn_groupb
  (pnb_id int,
  exp int);
  
  insert into informative_all_groupB
select  distinct cast(cf.p_id as int),  exp 
from clinical_fact cf, microarray_fact m, probe p 
where p_id in ( select  distinct p_id from clinical_fact c, disease d where d.name !='ALL' and c.ds_id=to_char(d.ds_id)) 
and cf.s_id != 'null' 
and m.s_id=cf.s_id 
and p.pb_id=m.pb_id;
  
       insert into  pn_groupb (pnb_id, exp) 
select distinct cast(ia.p_id as int), cast(ia.exp2 as int) from test_samples t, inform_notALL ia, informative i
  where i.gene=t.u_id
  and ia.u_id=i.gene
  and  i.p_value < 0.01;
  
  
      create view v_n2(p_id, exp1, exp2) as
  select pb.pb_id p_id, pb.exp1 exp1, pnb.exp exp2
  from informative_all_groupb pb, pn_groupb pnb
  where pb.pb_id=pnb.pnb_id;
  
  select p_id,
       corr_s(exp1, exp2) rb
from v_n2
group by p_id;


f:

create view rA(p_id, rA) as
select p_id,
       corr_s(exp1, exp2) rA
from v_n
group by p_id;


create view rB(p_id, rB) as
select p_id,
       corr_s(exp1, exp2) rb
from v_n2
group by p_id;

rA <- dbGetQuery(con, "SELECT rA FROM rA")
rB <- dbGetQuery(con, "SELECT rB FROM rB")

t_rA_rB <-  t.test(rA,rB)

print(t_rA_rB)
  
  
select distinct p_id informative_gene_ALL from v_n v1, pn_groupa i
where v1.p_id=i.pn_id;

select distinct p_id informative_gene_NOTALL from v_n2 v2, pn_groupb i
where v2.p_id=i.pnb_id;
  
  
  