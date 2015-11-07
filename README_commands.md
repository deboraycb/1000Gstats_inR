1. Download data

  Enter data directory

  `cd /raid/genevol/1kg/phase3/data/phase3_chr`

  1. Download VCF files

    ```bash
    for i in {1..22};
    do wget ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20130502/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz*;
    done
    ```
  
  2. Download sample list and create one list of samples per population  
    `Rscript /raid/genevol/1kg/phase3/scripts/phase3_pops.R`

2. Calculate global F~ST~
  
  [VCFtools](https://vcftools.github.io/index.html) v0.1.14 code
  [`variant_file_output.cpp`](https://github.com/vcftools/vcftools/blob/master/src/cpp/variant_file_output.cpp)
  so that the output of --weir-fst-pop command includes the numerator
  and denominator of Weir and Cockerham's F~ST~ estimator, allowing
  to calculate F~ST~ over multiple sites appropriately ("ratio of
  averages")

  line 3628 of [`variant_file_output.cpp`](https://github.com/vcftools/vcftools/blob/master/src/cpp/variant_file_output.cpp):
  
  `out << e->get_CHROM() << "\t" << e->get_POS() << "\t" << fst << endl;`
  
  was modified to:
  
  `out << e->get_CHROM() << "\t" << e->get_POS() << "\t" << fst << "\t" << sum_a << "\t" << sum_all << endl;`

  *Credit: [Travis Collier](http://sourceforge.net/p/vcftools/mailman/message/33927517/)*

  1. F~ST~ among all populations
    
    ```bash
    cd /raid/genevol/1kg/phase3/data/

    for i in {1..22};
    do /home/debora/vcftools/src/cpp/vcftools \
    --gzvcf phase3_chr/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
    --weir-fst-pop phase3_pops/popASW.txt \
    --weir-fst-pop ... \
    --weir-fst-pop ... \
    --out chr${i}/overall;
    done
    ```

    **OUTPUT:**

    ```
    data/chrN/overall.weir.fst
    data/chrN/overall.log
    ```
