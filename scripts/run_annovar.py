#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import os
import subprocess

if len(sys.argv) != 5:
    print '''Use ./run_annovar.py ANNOVAR_DIR IODATA_DIR NUMBER_OF_PROCESSES'''
    sys.exit()

annovar_dir = sys.argv[1]
data_dir = sys.argv[2]
procs_max = int(sys.argv[3])

# Create directory for the output
if not os.path.isdir(data_dir):
    os.mkdir(data_dir)

procs = []

for chn in range(1,23):
    ch = "chr" + chn
    input_file = ch + ".avinput"
    input_path = data_dir + "/" + ch + input_file

    # Create directory for the output
    if not os.path.isdir(data_dir + "/" + ch):
        os.mkdir(data_dir + "/" + ch)

    out_file = ch + "_annotated"
    out_path = data_dir + "/" + ch + "/" + out_file

    command = [annovar_dir + "annotate_variation.pl",
               "-out",
               out_path,
               "-build hg19",
               input_path,
               annovar_dir + "humandb/"
               ]

    if not os.path.isfile(out_path):
        procs.append(subprocess.Popen(command))
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
