######################################################################
#
# all.fst.table.R
#
# mar-2016 Debora
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

cat("chr1")
load("chr1/chr1.fst.RData")
all.fst.table <- fst.table
save(all.fst.table, file="/raid/genevol/1kg/phase3/r_objects/all.fst.table.RData")

for(i in 2:22){
    cat("\t", "chr", i)
    load(paste0("chr",i,"/chr",i,".fst.RData"))
    all.fst.table <- rbind(all.fst.table, fst.table)
    #if(i%/%5){
        #save(all.fst.table, file="/raid/genevol/1kg/phase3/r_objects/all.fst.table.RData")
    #}
}

save(all.fst.table, file="/raid/genevol/1kg/phase3/r_objects/all.fst.table.RData")
