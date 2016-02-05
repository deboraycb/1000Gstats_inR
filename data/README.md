# Diretório `/raid/genevol/1kg/phase3/data/`

*Para mais detalhes de como os scripts mencionados abaixo foram 
rodados, ver `../README_commands.md`*

- `phase3_chr/`

  Arquivos VCF zipados (.vcf.gz) para cada um dos **N** cromossomos,
  mais o arquivo índice (.vcf.tbi) equivalente. Foram baixados do
  [ftp do 1000 Genomas](ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20130502/)
  - `ALL.chrN.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz`
  - `ALL.chrN.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz.tbi`

- `phase3_pops/`

  Arquivos com a identificação (ID) dos indivíduos em cada
  população.

  Um indivíduo por linha.
  - `popNAME.txt`

- `annovar_output/`

  Arquivos de saída do anovar e arquivos de saída do script
  `merge_annovar_output.pl`

- `chrN/`

  Arquivos de saída do vcftools e annovar, por cromossomo:
  
  - `POP.log` e `POP.frq.count.bz2`

    Contagem de alelos overall e por população

  - `overall.log` e `overall.weir.fst.bz2`

  - `noadmix_overall.log` e `noadmix_overall.weir.fst.bz2`
  
  - `POP1-POP2.log` e `POP1-POP2.weir.fst.bz2`

    Fst para cada SNP overall, overall sem populações miscigenadas
    e entre pares de populações

    Duas últimas colunas: numerador e denominador do Fst
    (estimador de Weir & Cockerham)

  - `chrN.avinput.bz2`

    Arquivo de entrada do annovar

  - `chrN.table.RData`

    Workspace de R contendo o dataframe para esse cromossomo
