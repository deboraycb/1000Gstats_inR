# Organização do diretório com dados, scripts e estatísticas sumárias
dos dados do [Projeto 1000 Genomas](http://www.1000genomes.org/) - fase 3

Todos os dados brutos, estatísticas sumárias e scripts usados para
gerá-las estão em `/raid/genevol/1kg/phase3/`, que contém os
seguintes diretórios e arquivos:

`README_dir_structure`
  Este arquivo, que explica a organização desse diretório. :)

`README_commands.md`
  Lista de comandos usados para download dos dados brutos, cálculo de
  estatísticas sumárias e criação de um objeto em R (dataframe)
  contendo estatísticas populacionais por SNP.

`data/`
  Dados brutos ou parcialmente processados

`scripts/`
  Scripts usados para gerar os dados parcialmente processados em
  `data/`, os objetos de R em `r_objects` e outras análises

`r_objects`
  workspaces de R com o mesmo nome dos scripts que os geraram
  (scripts em `/raid/genevol/1kg/phase3/scripts/`)
