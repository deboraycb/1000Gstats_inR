#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import os
import subprocess

if len(sys.argv) != 6:
    print '''Use ./run_annovar.py ANNOVAR_DIR DATABASE INDATA_DIR OUT_DIR NUMBER_OF_PROCESSES'''
    sys.exit()

annovar_dir = sys.argv[1]
db_type = sys.argv[2]
data_dir = sys.argv[3]
output_dir = sys.argv[4] + "/" + db_type
procs_max = int(sys.argv[5])

# Create directory for the output
if not os.path.isdir(output_dir):
    os.mkdir(output_dir)

procs = []

for chn in range(1,23):
    ch = "chr" + str(chn)
    input_file = ch + ".avinput"
    input_path = data_dir + "/" + ch + "/" + input_file

    out_file = ch + "_annotated"
    out_path = output_dir + "/" + out_file

    command = [annovar_dir + "annotate_variation.pl",
               "-out",
               out_path,
               "-build",
               "hg19",
               "-dbtype",
               db_type,
               input_path,
               annovar_dir + "humandb/"
               ]

    if not os.path.isfile(out_path + ".variant_function"):
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
