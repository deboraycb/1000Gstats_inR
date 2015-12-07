#!/usr/bin/python
# -*- coding: utf-8 -*-
# Código contribuído por Edgard Z Alvarenga

import sys
import os
import subprocess
import re

if len(sys.argv) != 5:
    print '''Use ./run_vcf.py VCF_FILE POPULATIONS_DIR OUTPUT_DIR NUMBER_OF_PROCESSES'''
    sys.exit()

genome = sys.argv[1]
populations_dir = sys.argv[2]
output_dir = sys.argv[3]
procs_max = int(sys.argv[4])

# Create directory for the output
if not os.path.isdir(output_dir):
    os.mkdir(output_dir)

pop_files = os.listdir(populations_dir)

pops ={}
for pfile in pop_files:
    pname = re.match("pop(.*).txt", pfile).group(1)
    pops[pname] = populations_dir + "/" + pfile

procs = []

for i, pop1 in enumerate(pops.keys()[:-1]):
    for pop2 in pops.keys()[i+1:]:
        out_file = "{}-{}".format(pop1, pop2)
 	out_path = output_dir + "/" + out_file
        command = "/home/debora/vcftools/src/cpp/vcftools --gzvcf " + genome + " --weir-fst-pop " + pops[pop1] + " --weir-fst-pop " + pops[pop2] + " --out " + out_path + " --stdout | bzip2 > " + out_path +".weir.fst.bz2"

        if not os.path.isfile(out_path + ".weir.fst"):
            procs.append(subprocess.Popen(command, shell = True))
	    # Check with is already running the maximum number os processes
            if len(procs) == procs_max:
	        # Wait for processes to finish
                while True:
                    if len(procs) < procs_max:
                        break

                    finished_procs = []
                    for i,p in enumerate(procs):
                        if p.poll() is not None:
                            finished_procs.append(i)
                    for i in finished_procs:
                        procs.pop(i)
