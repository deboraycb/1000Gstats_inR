load("/raid/genevol/1kg/phase3/r_objects/all.chr.table.RData")

intergenic<-with(all.chr.table, grep("intergenic", refgene_ANNOTATION))
genic<-with(all.chr.table, !is.na(refgene_GENE))
intronic<-with(all.chr.table, grep("^intronic", refgene_ANNOTATION))
utr3<-with(all.chr.table, grep("UTR3", refgene_ANNOTATION))
utr5<-with(all.chr.table, grep("UTR5", refgene_ANNOTATION))
exonic<-with(all.chr.table, grep("^exonic", refgene_ANNOTATION))
synonymous<-with(all.chr.table, grep("(,|;)synonymous", refgene_ANNOTATION))
nonsynonymous<-with(all.chr.table, grep("nonsynonymous", refgene_ANNOTATION))

splicing<-with(all.chr.table, grep("splicing", refgene_ANNOTATION))
ncRNA<-with(all.chr.table, grep("ncRNA", refgene_ANNOTATION))
#existe ncRNA_exonic, ncRNA_intronic, ncRNA_splicing ...
upstream<-with(all.chr.table, grep("upstream", refgene_ANNOTATION))
downstream<-with(all.chr.table, grep("downstream", refgene_ANNOTATION))

stopgain<-with(all.chr.table, grep("stopgain", refgene_ANNOTATION))
stoploss<-with(all.chr.table, grep("stoploss", refgene_ANNOTATION))

save(list=ls()[ls()!="all.chr.table"],file="/raid/genevol/1kg/phase3/r_objects/indices_annotation.RData")
