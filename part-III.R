groupA1 <- dbGetQuery(con,"select  distinct  p_id, u_id, exp from clinical_fact cf, microarray_fact m, probe p where p_id in ( select  distinct p_id from clinical_fact c, disease d where d.name='ALL' and c.ds_id=to_char(d.ds_id)) and cf.s_id != 'null' and m.s_id=cf.s_id and p.pb_id=m.pb_id")

groupB1 <- dbGetQuery(con,"select  distinct  p_id, u_id, exp from clinical_fact cf, microarray_fact m, probe p where p_id in ( select  distinct p_id from clinical_fact c, disease d where d.name !='ALL' and c.ds_id=to_char(d.ds_id)) and cf.s_id != 'null' and m.s_id=cf.s_id and p.pb_id=m.pb_id")



groupB1 <- dbGetQuery(con,"select  distinct  p_id, exp from clinical_fact cf, microarray_fact m where p_id in (select  distinct p_id from clinical_fact c, disease d where d.name !='ALL' and c.ds_id=to_char(d.ds_id)) and cf.s_id != 'null' and m.s_id=cf.s_id")



groupA <- dbGetQuery(con,"select distinct c.p_id from clinical_fact c, disease d where d.name='ALL'and c.ds_id=to_char(d.ds_id)")


groupB1 <- dbGetQuery(con,"select distinct c.p_id from clinical_fact c, disease d where d.name !='ALL'and c.ds_id=to_char(d.ds_id)")


select  distinct  p_id, u_id, exp from clinical_fact cf, microarray_fact m, probe p where p_id in ( select  distinct p_id from clinical_fact c, disease d where d.name='ALL' and c.ds_id=to_char(d.ds_id)) and cf.s_id != 'null' and m.s_id=cf.s_id and p.pb_id=m.pb_id;

disease_out <- dbGetQuery(con, "SELECT * FROM v_disease")

disease_out_stack <- stack(disease_out)

summary(disease_out)

attach(disease_out_stack)

oneway.test(values ~ ind, var.equal=TRUE)


data = c(21.75, 18.0875, 18.75, 23.5, 14.125, 16.75, 11.125, 11.125, 14.875, 15.5, 20.875,17.125, 19.075, 25.125, 27.75, 29.825, 17.825, 28.375, 22.625, 28.75, 27, 12.825, 26, 32.825, 25.375, 24.825, 25.825, 15.625, 26.825, 24.625, 26.625, 19.625)
t.test(x=data, mu=10, conf.level=0.95)

aov(e1,e2)

v_g <- dbGetQuery(con, "SELECT * FROM v_g")

each_gene <- dbGetQuery(con, "SELECT GENE FROM v_g")

exp1 <- dbGetQuery(con, "SELECT exp1 FROM v_g")

exp2 <- dbGetQuery(con, "SELECT exp2 FROM v_g")


t.result <- apply(counts[,2:7], 1, function (x) t.test(x[1:3],x[4:6],paired=TRUE))

lapply(v_g[-1], function(v_g) t.test(v_g ~ v_g$Label))


library(plyr)
cols_to_test <- c("F1", "F2", "F3")
results <- ldply(
  cols_to_test,
  function(colname) {
    t_val = t.test(testData[[colname]] ~ testData$Label)$statistic
    return(data.frame(colname=colname, t_value=t_val))
  })


fastT(each_gene, exp1, exp2, var.equal = TRUE)

x  = matrix(runif(454425), nrow=4, ncol=3)
f2 = factor(floor(runif(ncol(x))*2))
r2 = rowttests(x, f2) 
for (j in 1:nrow(x)) {
  s2 = t.test(x[j,] ~ f2, var.equal=TRUE)
  about.equal(s2$statistic, r2$statistic[j])
  about.equal(s2$p.value,   r2$p.value[j])
}


matrix.t.test(each_gene, MARGIN = 1, exp1 = if (MARGIN == 1) floor(ncol(each_gene)/2)
              else floor(nrow(each_gene)/2), exp2 = if (MARGIN == 1) ncol(each_gene) - exp1 else 
                nrow(each_gene) - exp1, pool = TRUE, pOnly=TRUE, tOnly = FALSE)






cor(dataframe1$Score, dataframe2[-c(1:2)])
