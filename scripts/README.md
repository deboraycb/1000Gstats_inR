# Diretório `/raid/genevol/1kg/phase3/scripts/`

## Scripts de manipulação de formatos de entrada e saída de programas

- `phase3_pops.R`

  Faz download da lista de amostras do 1000 Genomas e
  cria um arquivo por população contendo os IDs dos
  indivíduos que pertencem a ela.

- `merge_annovar_output.pl`

  Une os arquivos de saída do annovar (`.variant_function` e
  `.exonic_variant_function`) em um único arquivo


## Scripts que chamam outros programas

- `run_vcf.py`

  Chama o vcftools para calcular Fst (Weir & Cockerham estimator)
  entre todos os pares de populações.

- `run_counts.py`

  Chama o vcftools para calcular o número de alelos de cada SNP
  em cada população.

- `annovar_input`

  Chama o script `convert2annoovar.pl`, do próprio annovar, 
  que gera o arquivo no formato de entrada do annovar a partir de 
  arquivos vcf.

- `run_annovar.py`

  Chama o annovar para fazer a anotação dos SNPs

## Scripts geradores de workspaces em `phase3/r_objects/`

- `chr.table.R`

  Gera um dataframe em R para um dado cromossomo contendo as colunas:

```
  CHR POS ID REF ALT refgene_GENE refgene_ANNOTATION encode_GENE
  encode_ANNOTATION ANC
  AF_ALT_all(*3) AF_ALT_POP(*26*3) AF_ALT1_noadm(*3)
  FST_overall FST_num_overall FST_den_overall
  FST_noadmix FST_num_noadmix FST_den_noadmix
  FST_POP1-POP2(*325) FST_num_POP1-POP2(*325) FST_den_POP1-POP2(*325)
```

  Gera o workspace em `phase3/data/chrN/chrN.table.RData`

- `all.chr.table.R`

  Une os dataframes de cada cromossomo, gerados com o script acima.

  Gera o workspace em `phase3/r_objects/all.chr.table.RData`
