load("/raid/genevol/1kg/phase3/r_objects/all.chr.table.RData")

# Peri segundo dissertação Binho;
# Coord segundoRefSeq UCSC Genome Browser on Human Feb. 2009 (GRCh37/hg19) Assembly (21/10)

hlaf <- which(with(all.chr.table, CHR==6 & POS>=29691117 & POS<=29695073))
loc554223 <- which(with(all.chr.table, CHR==6 & POS>29759683 & POS<29765584))
zndr1 <- which(with(all.chr.table, CHR==6 & POS>30029017 & POS<30032686))
muc21 <- which(with(all.chr.table, CHR==6 & POS>30951485 & POS<30957675))
muc22 <- which(with(all.chr.table, CHR==6 & POS>30973729 & POS<31003179))
c6orf15 <- which(with(all.chr.table, CHR==6 & POS>31079000 & POS<31080332))
cdsn <- which(with(all.chr.table, CHR==6 & POS>31082865 & POS<31088252))
psors1c1 <- which(with(all.chr.table, CHR==6 & POS>31082608 & POS<31107869))
psors1c2 <- which(with(all.chr.table, CHR==6 & POS>31105311 & POS<31107127))
cchcr1 <- which(with(all.chr.table, CHR==6 & POS>31110216 & POS<31126015))
tcf19 <- which(with(all.chr.table, CHR==6 & POS>31126303 & POS<31131992))
pou5f1 <- which(with(all.chr.table, CHR==6 & POS>31132114 & POS<31138451))
mica <- which(with(all.chr.table, CHR==6 & POS>31371371 & POS<31383090))
micb <- which(with(all.chr.table, CHR==6 & POS>31465855 & POS<31478901))
c6orf10 <- which(with(all.chr.table, CHR==6 & POS>32260475 & POS<32339656))
btnl2 <- which(with(all.chr.table, CHR==6 & POS>32362513 & POS<32374900))
drb5 <- which(with(all.chr.table, CHR==6 & POS>32485154 & POS<32498006))
dqa2 <- which(with(all.chr.table, CHR==6 & POS>32709163 & POS<32714664))
dqb2 <- which(with(all.chr.table, CHR==6 & POS>32723875 & POS<32731330))
hladob <- which(with(all.chr.table, CHR==6 & POS>32780540 & POS<32784825))
tap2 <- which(with(all.chr.table, CHR==6 & POS>32789610 & POS<32806547))
psmb82 <- which(with(all.chr.table, CHR==6 & POS>32808494 & POS<32812712))
tap1 <- which(with(all.chr.table, CHR==6 & POS>32812986 & POS<32821748))
psmb9 <- which(with(all.chr.table, CHR==6 & POS>32821938 & POS<32827628))

perihla <- c(hlaf,loc554223,hlag,zndr1,muc21,muc22,c6orf15,cdsn,
             psors1c1,psors1c2,cchcr1,tcf19,pou5f1,mica,micb,c6orf10,
             btnl2,drb5,dqa2,dqb2,hladob,tap2,psmb82,tap1,psmb9)

save(list=ls()[ls()!="all.chr.table"],file="/raid/genevol/1kg/phase3/r_objects/indices_perihla.RData")
