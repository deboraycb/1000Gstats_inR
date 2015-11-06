######################################################################
#
# phase3_pops.R
#
# Download list of 1000G phase 3 samples
# and create one file per pop with correspondent sample IDs
#
# Debora 5-Nov-2015
# modified from phase1_pops.R
#
######################################################################

setwd("/raid/genevol/1kg/phase3/data/")

if (! file.exists("phase1_integrated_calls.20101123.ALL.panel")) {
    download.file("ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel",
                  destfile = "integrated_call_samples_v3.20130502.ALL.panel")
}

panel <- read.table("integrated_call_samples_v3.20130502.ALL.panel", header = F,
                    fill = T, col.names = c("IND", "POP", "CONT", "GENDER"))

for (pop in unique(panel$POP)){
    write.table(panel$IND[panel$POP == pop], paste0("phase3_pops/pop", pop, ".txt"),
                quote = F, row.names = F, col.names = F)
}
