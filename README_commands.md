1. Download data

  Enter data directory

  `cd /raid/genevol/1kg/phase3/data/phase3_chr`

  1. Download VCF files
    ```
    for i in {1..22};
    do wget ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20130502/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz*;
    done
    ```
  2. Download sample list and create one list of samples per population  
    `Rscript /raid/genevol/1kg/phase3/scripts/phase3_pops.R`
