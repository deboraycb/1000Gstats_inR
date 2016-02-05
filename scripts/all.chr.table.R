######################################################################
#
# all.chr.table.R
#
# 04-feb-2015 Debora
#
# To run in R from /raid/genevol/1kg/phase3/data/
# 
# Une as tabelas por cromossomo em 1kg/data/chrN/chrN.table.RData
# em uma tabela única (all.chr.table)
#
# Colunas em all.chr.table:
# CHR POS ID REF ALT refgene_GENE refgene_ANNOTATION encode_GENE
# encode_ANNOTATION ANC
# AF_ALT_all(*3) AF_ALT_POP(*26*3) AF_ALT1_noadm(*3)
# FST_overall FST_num_overall FST_den_overall
# FST_noadmix FST_num_noadmix FST_den_noadmix
# FST_POP1-POP2(*325) FST_num_POP1-POP2(*325) FST_den_POP1-POP2(*325)
#
######################################################################

# 1. rbind das tabelas de todos os cromossomos

load("chr1/chr1.table.RData")
all.chr.table<-chr.table
save.image("all.chr.table.RData")

load("chr2/chr2.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr3/chr3.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr4/chr4.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr5/chr5.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr6/chr6.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr7/chr7.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr8/chr8.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr9/chr9.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr10/chr10.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr11/chr11.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr12/chr12.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr13/chr13.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr14/chr14.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr15/chr15.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr16/chr16.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr17/chr17.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr18/chr18.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr19/chr19.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr20/chr20.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr21/chr21.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

load("chr22/chr22.table.RData")
all.chr.table<-rbind(all.chr.table,chr.table)
save.image("all.chr.table.RData")

save(all.chr.table, file="/raid/genevol/1kg/phase3/r_objects/all.chr.table.RData")
