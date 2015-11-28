# Diretório `/raid/genevol/1kg/phase3/scripts/`

## Scripts de manipulação de formatos de entrada e saída de programas

- `phase3_pops.R`

  Faz download da lista de amostras do 1000 Genomas e
  cria um arquivo por população contendo os IDs dos
  indivíduos que pertencem a ela.

## Scripts que chamam funções do VCFtools

- `run_vcf.py`

  Chama o vcftools para calcular Fst (Weir & Cockerham estimator)
  entre todos os pares de populações.

## Scripts geradores de workspaces em `phase3/r_objects/`
