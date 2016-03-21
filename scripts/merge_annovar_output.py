#!/usr/bin/python

import sys
import collections as col

if len(sys.argv) != 3:
    print '''Use ./merge_annovar_output.py INFOLDER OUTPREFIX'''
    sys.exit()

infolder = sys.argv[1]
outpref = sys.argv[2]

for chrom in range(1,23):

    var_file = infolder+"/chr"+str(chrom)+"_annotated.variant_function"
    ex_file = infolder+"/chr"+str(chrom)+"_annotated.exonic_variant_function"

    allvar = open(var_file)
    exvar = open(ex_file)

    def mergefiles(allvar,exvar):
        annotation = col.defaultdict(list)
        exannotation = col.defaultdict(list)
        gene = col.defaultdict(list)
        for line in allvar:
            fields = line.strip().split()
            annotation[fields[3]].append(fields[0])
            gene[fields[3]].append(fields[1])
        for line in exvar:
            fields = line.strip().split()
            exannotation[fields[5]].append(fields[1])
        return(annotation,exannotation,gene)

    (annotation,exannotation,gene) = mergefiles(allvar,exvar)

    allvar.close()
    exvar.close()

    out_file = infolder+"/"+outpref+"_chr"+str(chrom)
    outfile = open(out_file, "w")

    for p in sorted(int(k) for k in annotation.keys()):
        pos = str(p)
        outfile.write(pos+"\t"+
                    ",".join(list(set(gene[pos])))+"\t"+
                    ",".join(annotation[pos])+";"+
                    ",".join(exannotation[pos])+"\n")

    outfile.close()
