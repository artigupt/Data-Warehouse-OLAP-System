library(RJDBC)
library(rJava)
library(RJSONIO)
library(rPython)
 






jdbcDriver <- JDBC(driverClass="oracle.jdbc.OracleDriver", classPath="/Users/artipengoriya/Downloads/ojdbc6.jar")


con <- dbConnect(drv, "jdbc:oracle:thin:@//aos.acsu.buffalo.edu:1521/aos.buffalo.edu", "artigupt", "cse562")


assay <- dbGetQuery(con, "SELECT * FROM assay")
gene <- dbGetQuery(con, "SELECT * FROM gene")
clinical_fact <- dbGetQuery(con, "SELECT * FROM CLINICAL_FACT")
cluster1 <- dbGetQuery(con, "SELECT * FROM CLUSTER1")
disease <- dbGetQuery(con, "SELECT * FROM DISEASE")
domain <- dbGetQuery(con, "SELECT * FROM domain")
drug <- dbGetQuery(con, "SELECT * FROM DRUG")
experiment_fact <- dbGetQuery(con, "SELECT * FROM experiment_fact")
experiment <- dbGetQuery(con, "SELECT * FROM experiment")
gene_fact <- dbGetQuery(con, "SELECT * FROM GENE_FACT")
go <- dbGetQuery(con, "SELECT * FROM GO")
marker <- dbGetQuery(con, "SELECT * FROM MARKER")
measureUnit <- dbGetQuery(con, "SELECT * FROM MEASUREUNIT")
microarray_fact <- dbGetQuery(con, "SELECT * FROM microarray_fact")
norm <- dbGetQuery(con, "SELECT * FROM norm")
patient <- dbGetQuery(con, "SELECT * FROM patient")
person <- dbGetQuery(con, "SELECT * FROM person")
platform <- dbGetQuery(con, "SELECT * FROM platform")
probe <- dbGetQuery(con, "SELECT * FROM probe")
project <- dbGetQuery(con, "SELECT * FROM project")
promoter <- dbGetQuery(con, "SELECT * FROM promoter")
sample_fact <- dbGetQuery(con, "SELECT * FROM sample_fact")
sample <- dbGetQuery(con, "SELECT * FROM sample")
term <- dbGetQuery(con, "SELECT * FROM term")
test_sample <- dbGetQuery(con, "SELECT * FROM test_sample")
test <- dbGetQuery(con, "SELECT * FROM test")
protocol <- dbGetQuery(con, "SELECT * FROM protocol")
publication <- dbGetQuery(con, "SELECT * FROM publication")


v2 <- dbGetQuery(con, "SELECT * FROM v2")
e1 <- dbGetQuery(con, "SELECT e1 FROM v1")
e2 <- dbGetQuery(con, "SELECT e2 FROM v2")



d1 <- dbGetQuery(con, "SELECT * FROM d1")

d2 <- dbGetQuery(con, "SELECT * FROM d2")

m1 <- data.frame(d1)

m2 <- data.frame(d2)

DT1 <- data.table(m1)

DT2 <- data.table(m2)


x <- m1[, aggp_id := exp_ALL]

for (i in DT1){
  x=DT1[i]^2
}


h <- hash( P_ID, EXP_ALL )

t_stat <- t.test(e1,e2)

#remove(e2) 

print(fa)

dbGetQuery(con, "select count(*) from TEST_TABLE")
d <- dbReadTable(con, "TEST_TABLE")
dbDisconnect(con)

#install.packages("rJava",type='source')

e1_ALL <- dbGetQuery(con, "select cast(m.exp as INT) from probe p, microarray_fact m where u_id in (select u_id from gene_fact where go_id='7154') and m.s_id in (select  distinct  s_id from clinical_fact cf where p_id in (select  distinct p_id from clinical_fact c, disease d where d.name='ALL' and c.ds_id=to_char(d.ds_id)) and s_id != 'null') and to_char(p.pb_id)=m.pb_id")

e2_AML <- dbGetQuery(con, "select cast(m.exp as INT) from probe p, microarray_fact m where u_id in (select u_id from gene_fact where go_id='7154') and m.s_id in (select  distinct  s_id from clinical_fact cf where p_id in (select  distinct p_id from clinical_fact c, disease d where d.name='AML' and c.ds_id=to_char(d.ds_id)) and s_id != 'null') and to_char(p.pb_id)=m.pb_id")

e3_colon_tumor <- dbGetQuery(con, "select cast(m.exp as INT) from probe p, microarray_fact m where u_id in (select u_id from gene_fact where go_id='7154') and m.s_id in (select  distinct  s_id from clinical_fact cf where p_id in (select  distinct p_id from clinical_fact c, disease d where d.name='Colon tumor' and c.ds_id=to_char(d.ds_id)) and s_id != 'null') and to_char(p.pb_id)=m.pb_id")

e4_breast_tumor <- dbGetQuery(con, "select cast(m.exp as INT) from probe p, microarray_fact m where u_id in (select u_id from gene_fact where go_id='7154') and m.s_id in (select  distinct  s_id from clinical_fact cf where p_id in (select  distinct p_id from clinical_fact c, disease d where d.name='Breast tumor' and c.ds_id=to_char(d.ds_id)) and s_id != 'null') and to_char(p.pb_id)=m.pb_id")

exp_f_stats <- data.frame(e1_ALL, e2_AML,e3_colon_tumor, e4_breast_tumor)

remove(queries)

library(rPython)

library(hash)

library(data.table)

  python.load('2.6.py')

  
  
  
  for (i in 3:8)
  {
    cortop[i] <- cor(dataframe1$Score_top,dataframe2$i)
    
    
  }
  
  
  
  
  remove(e2)
  v3 <- dbGetQuery(con, "SELECT e2 FROM v3")
  v4 <- dbGetQuery(con, "SELECT e1 FROM v4")
  
  t_stat <- t.test(v3,v4)
  
  print(t_stat)
  
  
  remove(fa4)
  
  f5 <- dbGetQuery(con, "select * from f_stats_w")
  m3 <- data.frame(f5)
  
  fa2 <- oneway.test(EXP_VAL~dis, data = m2, var.equal = TRUE)
  
  
  fa4 <- oneway.test(EXP_VAL~DIS, data = m3, var.equal = TRUE)
  
  print(fa4)