######################################################################
#
# fst.table.R
#
# mar-2016 Debora
#
# To run in R from /raid/genevol/1kg/phase3/data/chrN
# 
######################################################################

library(stringr)
library(reshape2)

# get chromosome number
this.chr <- str_match(getwd(), "chr(.+?)$")
print(paste("Starting ",this.chr[,1]))

load(paste0(this.chr[,1],".codingSNPs.RData"))

#-------------------------------------------------------------------------------

# FST

print("Reading Fst files")

# read files with fst (overall and pairwise) previously calculated using
# vcftools
files_fst <- list.files(pattern = ".weir")

file <- files_fst[1]
temp <- read.table(file, row.names = NULL, header = TRUE,
                 colClasses = rep("numeric", 5),
                 col.names = c("CHROM", "POS", "FST", "FSTnum", "FSTden"))[codingSNPindex,]
fst.table <- temp[, c(1,2)]
colname_num <- paste0("FSTnum_", str_match(file, "^.{7}"))
colname_den <- paste0("FSTden_", str_match(file, "^.{7}"))
fst.table[, colname_num] <- temp[, 4]
fst.table[, colname_den] <- temp[, 5]

for(file in files_fst[-1]){
  temp <- read.table(file, row.names = NULL, header = TRUE,
                     colClasses = rep("numeric", 5),
                     col.names = c("CHROM", "POS", "FST", "FSTnum", "FSTden"))[codingSNPindex,]
  poppair <-  str_match(file, "^.{7}")
  cat(poppair, " ")
  colname_num <- paste0("FSTnum_", poppair)
  colname_den <- paste0("FSTden_", poppair)
  #chr.table[, colname_fst] <- temp[, 3]
  fst.table[, colname_num] <- temp[, 4]
  fst.table[, colname_den] <- temp[, 5]
}

#-------------------------------------------------------------------------------

print("Saving fst.table")
save("fst.table", file = paste0(this.chr[, 1], ".fst.RData"))
