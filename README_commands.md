1. Download dos dados

  Entrar no diretório onde ficarão os dados brutos

  `cd /raid/genevol/1kg/phase3/data/phase3_chr`

  1. Download dos arquivos VCF

    ```bash
    for i in {1..22};
    do wget ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20130502/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz*;
    done
    ```

    **OUTPUT:**

    ```
    data/phase3_chr/ALL.chrN[...].vcf.gz
    data/phase3_chr/ALL.chrN[...].vcf.gz.tbi
    ```
  
  2. Download da lista de amostras do 1000G e 
  criação de uma lista de amostrar para cada população
    `Rscript /raid/genevol/1kg/phase3/scripts/phase3_pops.R`

    **OUTPUT:**

    ```
    data/phase3_pops/popPOPNAME.txt
    ```

2. Calcular F<sub>ST</sub> global
  
  [VCFtools](https://vcftools.github.io/index.html) v0.1.14 code
  [`variant_file_output.cpp`](https://github.com/vcftools/vcftools/blob/master/src/cpp/variant_file_output.cpp)
  so that the output of --weir-fst-pop command includes the numerator
  and denominator of Weir and Cockerham's F<sub>ST</sub> estimator, allowing
  to calculate F<sub>ST</sub> over multiple sites appropriately ("ratio of
  averages")

  line 3628 of [`variant_file_output.cpp`](https://github.com/vcftools/vcftools/blob/master/src/cpp/variant_file_output.cpp):
  
  `out << e->get_CHROM() << "\t" << e->get_POS() << "\t" << fst << endl;`
  
  was modified to:
  
  `out << e->get_CHROM() << "\t" << e->get_POS() << "\t" << fst << "\t" << sum_a << "\t" << sum_all << endl;`

  *Credit: [Travis Collier](http://sourceforge.net/p/vcftools/mailman/message/33927517/)*

  1. F<sub>ST</sub> entre todas as populções
    
    ```bash
    cd /raid/genevol/1kg/phase3/data/

    for i in {1..22};
    do /home/debora/vcftools/src/cpp/vcftools \
    --gzvcf phase3_chr/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
    --weir-fst-pop phase3_pops/popACB.txt \
    --weir-fst-pop phase3_pops/popASW.txt \
    --weir-fst-pop phase3_pops/popBEB.txt \
    --weir-fst-pop phase3_pops/popCDX.txt \
    --weir-fst-pop phase3_pops/popCEU.txt \
    --weir-fst-pop phase3_pops/popCHB.txt \
    --weir-fst-pop phase3_pops/popCHS.txt \
    --weir-fst-pop phase3_pops/popCLM.txt \
    --weir-fst-pop phase3_pops/popESN.txt \
    --weir-fst-pop phase3_pops/popFIN.txt \
    --weir-fst-pop phase3_pops/popGBR.txt \
    --weir-fst-pop phase3_pops/popGIH.txt \
    --weir-fst-pop phase3_pops/popGWD.txt \
    --weir-fst-pop phase3_pops/popIBS.txt \
    --weir-fst-pop phase3_pops/popITU.txt \
    --weir-fst-pop phase3_pops/popJPT.txt \
    --weir-fst-pop phase3_pops/popKHV.txt \
    --weir-fst-pop phase3_pops/popLWK.txt \
    --weir-fst-pop phase3_pops/popMSL.txt \
    --weir-fst-pop phase3_pops/popMXL.txt \
    --weir-fst-pop phase3_pops/popPEL.txt \
    --weir-fst-pop phase3_pops/popPJL.txt \
    --weir-fst-pop phase3_pops/popPUR.txt \
    --weir-fst-pop phase3_pops/popSTU.txt \
    --weir-fst-pop phase3_pops/popTSI.txt \
    --weir-fst-pop phase3_pops/popYRI.txt \
    --out chr${i}/overall;
    bzip2 chr${i}/overall.weir.fst;
    done
    ```

    **OUTPUT:**

    ```
    data/chrN/overall.weir.fst.bz2
    data/chrN/overall.log
    ```
    
  2. Entre todas as populações, excluindo miscigenadas

    - populações excluídas:
        - todas as do grupo AMR: MXL, PUR, CLM, PEL
        - outras miscigenadas segundo página 5 do material
        suplementar do 1000G: ASW, ACB
    
    ```bash
    cd /raid/genevol/1kg/phase3/data/

    for i in {1..22};
    do /home/debora/vcftools/src/cpp/vcftools \
    --gzvcf phase3_chr/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz \
    --weir-fst-pop phase3_pops/popBEB.txt \
    --weir-fst-pop phase3_pops/popCDX.txt \
    --weir-fst-pop phase3_pops/popCEU.txt \
    --weir-fst-pop phase3_pops/popCHB.txt \
    --weir-fst-pop phase3_pops/popCHS.txt \
    --weir-fst-pop phase3_pops/popESN.txt \
    --weir-fst-pop phase3_pops/popFIN.txt \
    --weir-fst-pop phase3_pops/popGBR.txt \
    --weir-fst-pop phase3_pops/popGIH.txt \
    --weir-fst-pop phase3_pops/popGWD.txt \
    --weir-fst-pop phase3_pops/popIBS.txt \
    --weir-fst-pop phase3_pops/popITU.txt \
    --weir-fst-pop phase3_pops/popJPT.txt \
    --weir-fst-pop phase3_pops/popKHV.txt \
    --weir-fst-pop phase3_pops/popLWK.txt \
    --weir-fst-pop phase3_pops/popMSL.txt \
    --weir-fst-pop phase3_pops/popPJL.txt \
    --weir-fst-pop phase3_pops/popSTU.txt \
    --weir-fst-pop phase3_pops/popTSI.txt \
    --weir-fst-pop phase3_pops/popYRI.txt \
    --out chr${i}/overall_noadm;
    bzip2 chr${i}/overall_noadm.weir.fst;
    done
    ```

    **OUTPUT:**

    ```
    data/chrN/overall_noadm.weir.fst.bz2
    data/chrN/overall_noadm.log
    ```
    
3. F<sub>ST</sub> par-a-par

    *ATENÇÃO: o último número dessa linha de comando é o número
    de processos que vão rodar em paralelo. Verificar a
    disponibilidade do servidor antes de rodar 50 processos!*

    ```bash
    cd /raid/genevol/1kg/phase3/
    
    for i in {1..22};
    do ./scripts/run_vcf.py data/phase3_chr/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz data/phase3_pops/ data/chr${i} 50;
    done
    ```

    **OUTPUT:**

    ```
    data/chrN/POP1-POP2.weir.fst.bz2
    data/chrN/POP1-POP2.log
    ```

4. Frequencias por população

    *ATENÇÃO: o último número dessa linha de comando é o número
    de processos que vão rodar em paralelo. Verificar a
    disponibilidade do servidor antes de rodar 50 processos!*

    ```bash
    cd /raid/genevol/1kg/phase3/
    ./scripts/run_counts.py data/phase3_chr/ data/phase3_pops/ data/ 50
    
    for i in {1..22};
    do bzip2 data/chr${i}/*.frq.count;
    done
    ```

    **OUTPUT:**

    ```
    data/chrN/POP.frq.count.bz2
    data/chrN/POP.log
    ```

5. Anotação

  1. Instalar [annovar](http://doc-openbio.readthedocs.org/projects/annovar/en/latest/)
    
    ```bash
    cd /raid/genevol/1kg/phase3/
    wget http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz
    tar -xzvf annovar.latest.tar.gz
    ```

  2. Download de base de dados para gene-based annotation
  
    ```bash
    cd annovar
    # refSeq
    ./annotate_variation.pl -downdb -buildver hg19 -webfrom annovar refGene humandb/
    # GENCODE
    ./annotate_variation.pl -downdb -build hg19 seq humandb/hg19_seq/
    ./annotate_variation.pl -downdb wgEncodeGencodeBasicV19 humandb/ -build hg19
    ./retrieve_seq_from_fasta.pl -format genericGene -seqdir humandb/hg19_seq/ -outfile humandb/hg19_wgEncodeGencodeBasicV19Mrna.fa humandb/hg19_wgEncodeGencodeBasicV19.txt
    ```

  3. Preparar arquivos de entrada do annovar

    ```bash
    cd /raid/genevol/1kg/phase3/
    ./scripts/annovar_input.py data/phase3_chr/ annovar/ data/ 22
    ```

    **OUTPUT:**

    ```
    data/chrN/chrN.avinput
    ```

  4. Rodar annovar nos arquivos gerados acima

    Para anotação do GENCODE, usar `wgEncodeGencodeBasicV19` no lugar de `refGene`

    ```bash
    ./scripts/run_annovar.py annovar/ refGene data/ data/annovar_output/ 22
    ```

    **OUTPUT:**

    ```
    data/annovar_output/refGene/chrN_annotated.variant_function
    data/annovar_output/refGene/chrN_annotated.exonic_variant_function
    ```

  5. Fundir os dois arquivos de saída do annovar em um único arquivo
  com anotação geral e exônica na mesma coluna

    Para anotação do GENCODE, usar `wgEncodeGencodeBasicV19` no lugar de `refGene`

    ```bash
    ./scripts/merge_annovar_output.pl data/annovar_output/refGene/ data/annovar_output/refGene/mergeanno_chr
    ```

    **OUTPUT:**

    ```
    data/annovar_output/refGene/mergeanno_chrN
    ```

6. Lendo resultados no R, por cromossomo

  ```bash
  cd /raid/genevol/1kg/phase3/data/chr1/
  for i in {1..22};
  do cd ../chr${i};
  Rscript ../../scripts/chr.table.R;
  done
  ```

  **OUTPUT**
  ```
  data/chrN/chrN.table.RData
  ```

7. Juntando tabelas de R por cromossomo em uma só tabela e escrevendo em arquivo txt

  ```bash
  Rscript ./scripts/all.chr.table.R
  ```

  **OUTPUT**
  ```bash
  r_objects/all.chr.table.RData
  ```

8. Exemplo: Definindo pedaços de interesse na tabela

  ```R
  mhc_indice <- which(all.chr.table)
  ```
