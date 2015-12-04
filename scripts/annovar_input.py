#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import os
import subprocess
import re

if len(sys.argv) != 5:
    print '''Use ./annovar_input.py VCF_DIR ANNOVAR_DIR OUTPUT_DIR NUMBER_OF_PROCESSES'''
    sys.exit()

genome_dir = sys.argv[1]
annovar_dir = sys.argv[2]
output_dir = sys.argv[3]
procs_max = int(sys.argv[4])

# Create directory for the output
if not os.path.isdir(output_dir):
    os.mkdir(output_dir)

ch_files = os.listdir(genome_dir)

chs ={}

ch_files = filter(lambda f: f[-2:] == 'gz', ch_files)

for cfile in ch_files:
    cname = re.match("ALL.(.*).phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz", cfile).group(1)
    chs[cname] = genome_dir + "/" + cfile

procs = []

for ch in chs.keys():

    out_file = ch + ".avinput"
    out_path = output_dir + "/" + ch + "/" + out_file

    command = "vcftools --gzvcf " + chs[ch] + " --recode --stdout | " + annovar_dir + "convert2annovar.pl -format vcf4 - -outfile " + out_path + " -allsample -withfreq"

    if not os.path.isfile(out_path):
        procs.append(subprocess.Popen(command, shell = True))
        if len(procs) == procs_max:
            # Wait for processes to finish
            while True:
                if len(procs) < procs_max:
                    break

                finished_procs = []
                for i,p in enumerate(procs):
                    if p.poll() == 0:
                        finished_procs.append(i)
                for i in finished_procs:
                    procs.pop(i)
