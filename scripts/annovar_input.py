#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import os
import subprocess
import re

# Verificar se o usuario deu os 4 argumentos que o programa requer
if len(sys.argv) != 5:
    print '''Use ./annovar_input.py VCF_DIR ANNOVAR_DIR OUTPUT_DIR NUMBER_OF_PROCESSES'''
    sys.exit()


# argumento 1: diretorio onde estao os arquivos vcf.gz
genome_dir = sys.argv[1]
# argumento 2: diretorio onde esta o annovar
annovar_dir = sys.argv[2]
# argumento 3: diretorio de output
output_dir = sys.argv[3]
# argumento 4: numero de processos que podem ser rodados em paralelo
procs_max = int(sys.argv[4])

# se o diretorio de output nao existe...
if not os.path.isdir(output_dir):
    #...cria o diretorio de output com o nome dado pelo usuario
    os.mkdir(output_dir)

# cria lista com os nomes de todos arquivos no diretorio de arquivos vcf fornecido pelo usuario
ch_files = os.listdir(genome_dir)

# cria dicionario vazio
chs ={}

# seleciona apenas os nomes de arquivo que terminam com gz (que sao os arquivos .vcf.gz)
ch_files = filter(lambda f: f[-2:] == 'gz', ch_files)

# para cada arquivo .vcf.gz
for cfile in ch_files:
    # guarda o nome do cromossomo (eg "chr6") na variavel cname
    cname = re.match("ALL.(.*).phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz", cfile).group(1)
    # no dicionario chs, cria um item que tem key cname e o valor é o path completo para o arquivo vcf
    chs[cname] = genome_dir + "/" + cfile

# cria lista de processos que estão rodando
procs = []

# loop pelos cromossomos chr1, chr2, ..., chr22
for ch in chs.keys():
    # out_file é o nome do arquivo de saída: eg chr1.avinput ... chr2.avinput
    out_file = ch + ".avinput"
    # out_path é o path completo para o arquivo de saída: eg data/chr1/chr1.avinput
    out_path = output_dir + "/" + ch + "/" + out_file
    # comando a ser rodado: abre o arquivo .vcf.gz do 1000G e passa ele como
    # imput para o script convert2annovar.pl, que vem com o annovar.
    # esse script convert2annovar converte um arquivo .vcf para o
    # formato de entrada do annovar
    command = "vcftools --gzvcf " + chs[ch] + " --recode --stdout | " + annovar_dir + "convert2annovar.pl -format vcf4 - -outfile " + out_path + " -allsample -withfreq"
    # se o arquivo de saída ainda nao existe
    #(isso é um controle pra caso vc já tenha rodado o comando acima para algum dos cromossomos.
    #Nesse caso ele não será rodado novamente.)
    if not os.path.isfile(out_path):
        # roda o comando acima e coloca-o na lista de processos que estão rodando
        procs.append(subprocess.Popen(command, shell = True))
        # se a lista já tiver o número máximo de processos determinados pelo usuario
        if len(procs) == procs_max:
            # Wait for processes to finish
            while True:
                # se a lista agora tiver menos processos do que o máximo
                if len(procs) < procs_max:
                    # quebra esse loop while e testa de novo if len(procs) == procs_max
                    break
                # cria lista de processos que terminaram de rodar
                finished_procs = []
                # para cada processo na lista procs
                for i,p in enumerate(procs):
                    # se esse processo já tiver terminado de rodar
                    if p.poll() == 0:
                        # coloca o processo na lista de processos terminados
                        finished_procs.append(i)
                # para cada processo terminado
                for i in finished_procs:
                    # elimina ele da lista de processos que estão rodando
                    procs.pop(i)
