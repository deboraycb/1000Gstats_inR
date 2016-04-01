load("/raid/genevol/1kg/phase3/r_objects/all.chr.table.RData")

# Coordenadas RefSeq UCSC Genome Browser on Human Feb. 2009
# (GRCh37/hg19) Assembly (3/out/2013):
# I always chose the coordinates giving the longer transcrips, except
# for DPA1, because its longest transcript overlapped with DPB1.

hlaa <- which(with(all.chr.table, CHR==6 & POS>=29910247 & POS<=29913661))
hlab <- which(with(all.chr.table, CHR==6 & POS>=31321649 & POS<=31324989))
hlac <- which(with(all.chr.table, CHR==6 & POS>=31236526 & POS<=31239913))
hlae <- which(with(all.chr.table, CHR==6 & POS>=30457183 & POS<=30461982))
hlaf <- which(with(all.chr.table, CHR==6 & POS>=29691117 & POS<=29695073))
hlag <- which(with(all.chr.table, CHR==6 & POS>=29794756 & POS<=29798899))
hladpa1 <- which(with(all.chr.table, CHR==6 & POS>=33032346 & POS<=33041454))
hladpb1 <- which(with(all.chr.table, CHR==6 & POS>=33043703 & POS<=33057473))
hladqa1 <- which(with(all.chr.table, CHR==6 & POS>=32605183 & POS<=32611429))
hladqb1 <- which(with(all.chr.table, CHR==6 & POS>=32627241 & POS<=32634466))
hladra <- which(with(all.chr.table, CHR==6 & POS>=32407619 & POS<=32412824))
hladrb1 <- which(with(all.chr.table, CHR==6 & POS>=32546547 & POS<=32557613))
hladma <- which(with(all.chr.table, CHR==6 & POS>=32916391 & POS<=32920899))
hladmb <- which(with(all.chr.table, CHR==6 & POS>=32902406 & POS<=32908847))

hlagenes <- c(hlaa,hlab,hlac,hladra,hladrb1,hladqa1,hladqb1,hladpa1,hladpb1)

# Coordenadas dos exons de genes hla retiradas do RefSeq atraves do UCSC Table Browser
exonic <- with(all.chr.table, grep("^exonic",refgene_ANNOTATION))

# HLA-A 
hlaa_exnars <- which(with(all.chr.table[exonic,], CHR==6 &
                     ((POS>=29910247 & POS<=29910403) | (POS>=29911899 & POS<=29913661))))
hlaa_exars <- which(with(all.chr.table[exonic,], CHR==6 &
                   POS>=29910534 & POS<=29911320))
# HLA-B
hlab_exnars <- which(with(all.chr.table[exonic,], CHR==6 &
                     ((POS>=31324863& POS<=31324989) | (POS>=31321649& POS<=31323369))))
hlab_exars <- which(with(all.chr.table[exonic,], CHR==6 &
                   POS>=31323944& POS<=31324734))
# HLA-C
hlac_exnars <- which(with(all.chr.table[exonic,], CHR==6 &
                     ((POS>=31239776& POS<=31239913) | (POS>=31236526& POS<=31238262))))
hlac_exars <- which(with(all.chr.table[exonic,], CHR==6 &
                   POS>=31238850& POS<=31239645))

# HLA-DRA
hladra_exnars <- which(with(all.chr.table[exonic,], CHR==6 &
                      ((POS>=32407619 & POS<=32407809) | (POS>=32410962 & POS<=32412826))))
hladra_exars <- which(with(all.chr.table[exonic,], CHR==6 &
                     POS>=32410225 & POS<=32410470))
# HLA-DRB1
hladrb1_exnars <- which(with(all.chr.table[exonic,], CHR==6 &
                        ((POS>=32557420 & POS<=32557613) | (POS>=32546547 & POS<=32551947))))
hladrb1_exars <- which(with(all.chr.table[exonic,], CHR==6 &
                       POS>=32551949 & POS<=32552129))
# HLA-DQA1
hladqa1_exnars <- which(with(all.chr.table[exonic,], CHR==6 &
                         ((POS>=32605183 & POS<=32605317) | (POS>=32609749 & POS<=32611429))))
hladqa1_exars <- which(with(all.chr.table[exonic,], CHR==6 &
                        POS>=32609087 & POS<=32609335))

#regiões a seguir segundo Shiina et al. (2009) + Coordenadas RefSeq UCSC Genome Browser on Human Feb. 2009 (GRCh37/hg19) Assembly (3/out/2013):

mhccl <- which(with(all.chr.table, CHR==6 & POS>=29691117 & POS<=33111102))
mhcext <- which(with(all.chr.table, CHR==6 & POS>=29570005 & POS<=33377699))

class1cl <- which(with(all.chr.table, CHR==6 & POS>=29691117 & POS<=31478901))
class1ext <- which(with(all.chr.table, CHR==6 & POS>=29570005 & POS<=29644931))
class2cl <- which(with(all.chr.table, CHR==6 & POS>=32407619 & POS<=33111102))
class2ext <- which(with(all.chr.table, CHR==6 & POS>=33130469 & POS<=33377699))
class3 <- which(with(all.chr.table, CHR==6 & POS>=31487257 & POS<=32374900))

save(list=ls()[ls()!="all.chr.table"],file="/raid/genevol/1kg/phase3/r_objects/indices_hla.RData")
