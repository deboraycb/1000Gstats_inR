#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import os
import subprocess
import re

if len(sys.argv) != 5:
    print '''Use ./run_counts.py GENOME_DIR POPULATIONS_DIR OUTPUT_DIR NUMBER_OF_PROCESSES'''
    sys.exit()

genome_dir = sys.argv[1]
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

ch_files = os.listdir(genome_dir)

chs ={}

ch_files = filter(lambda f: f[-2:] == 'gz', ch_files)

for cfile in ch_files:
    cname = re.match("ALL.(.*).phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz", cfile).group(1)
    chs[cname] = genome_dir + "/" + cfile

procs = []

for ch in chs.keys():
    # Create directory for the output
    if not os.path.isdir(output_dir + "/" + ch):
        os.mkdir(output_dir + "/" + ch)

    for pop in pops.keys():
        out_file = "{}".format(pop)
        out_path = output_dir + "/" + ch + "/" + out_file

        vcf_command = ["vcftools",
                       "--gzvcf",
                       chs[ch],
                       "--keep",
                       pops[pop],
                       "--counts",
                       "--out",
                       out_path
		       ]

        if not os.path.isfile(out_path + ".frq.count"):
            procs.append(subprocess.Popen(vcf_command))
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
