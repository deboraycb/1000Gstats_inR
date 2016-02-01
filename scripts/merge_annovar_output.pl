#!/usr/bin/perl

# Une os pares de arquivos de saída do annovar (um para anotação geral,
# e outro para anotação exônica) por população e por cromossomo num
# único arquivo por cromossomo com essas duas colunas.

# Argumentos:
$indir = $ARGV[0]; # Primeiro argumento: diretorio onde estao todos os
                    # arquivos de output do annovar
                    # ( 22 (cromossomos) * 14 (populacoes) *
                    # 3 (variant_func, exonic_variant_fun, log) = 924 arquivos)
$outfile = $ARGV[1]; # Segundo argumento: prefixo para os nomes dos
                    # arquivos de saída (será concatenado com N,
                    # sendo N de 1 a 22 o cromossomo correspondente)

opendir(DIR,"$indir"); #abre o diretorio onde estao todos os arquivos
                        # de output do annovar
my @files = readdir(DIR); # @files recebe todos os nomes dos arquivos
                            # da pasta
closedir(DIR);

foreach $chr(1 .. 22){ #loop pelos cromossomos
    my %snps = (); #declara/limpa o hash %snps
    # @chrfiles1 recebe os arquivos .variant_function de todas as pops
    # (14 arquivos) do cromossomo $chr
    @chrfiles1 = grep /^chr$chr\_.+?\.variant\_function/, @files;
    @chrfiles2 = grep /^chr$chr\_.+?\.exonic\_variant\_function/, @files;
    # @chrfiles2 recebe os arquivos .exonic_variant_function de todas
    # as pops (14 arquivos) do cromossomo $chr
    # loop pelos arquivos .variant_function do cromossomo $chr
    foreach $file(@chrfiles1){
        open(IN,"$indir"."/"."$file"); #abre o arquivo
        #imprime na tela o nome do arquivo que esta sendo aberto
        print "Reading file $file"."\n";
        while (<IN>){ #le o arquivo linha a linha
            chomp $_;
            # dá um match na 1a, 2a, 4a e 10a coluna da linha
            if ($_ =~ /^(.+?)\t(.+?)(\t|\().+?\t.+?\t(.+?)\t/){ 
            # a 1a coluna é a anotação; 2a é o gene, 4a é a posicao do snp
                ($annotation, $gene, $position) = ($1,$2,$4);
            }
            #Se já existe uma anotação para essa posição
            if (exists($snps{$position})) {
                # e se a essa anotacao ainda nao esta no hash %snps
                if ($snps{$position} !~ /(\s|\,)$annotation($|\,)/){
                    #concatena no elemento $position do hash %snps a
                    #anotacao separada por uma virgula
                    $snps{$position} = join("\,",($snps{$position},$annotation));
                }
            }
            #Se não existe uma anotação para essa posição
            else{
                #e se o SNP for intergênico
                if ($annotation =~ /intergenic/){
                    # atribui a anotacao na posicao
                    # $position do hash %snps separados por tab.
                    # Como é intergênico, no lugar do nome do gene, inserir NA
                    $snps{$position}  = join("\t",("NA", $annotation));
                }
                # se não for intergênico
                else{
                    # atribui o gene e anotacao na
                    # posicao $position do hash %snps separados por tab
                    $snps{$position}  = join("\t",($gene, $annotation));
                }
            }
        }
        close(IN);
    }
    ## loop pelos arquivos .exonic_variant_function do cromossomo $chr
    foreach $file(@chrfiles2){
        open(IN,"$indir"."/"."$file"); #abre o arquivo
        #imprime na tela o nome do arquivo que esta sendo aberto
        print "Reading file $file"."\n";
        while (<IN>){ #le o arquivo linha a linha
            chomp $_;
            # dá um match na 2a 5a e ultima coluna da linha...
            if ($_ =~ /^.+?\t(.+?)\ .+?\t.+?\t.+?\t(.+?)\t/){
                #...que sao respectivamente a anotacao, a posicao e o SNPsource
                ($annotation, $position) = ($1,$2);
            }
            #Se já existe uma anotação para essa posição
            if (exists($snps{$position})) {
                #e se a anotacao for diferente dessa
                if($snps{$position} !~ /(\s|\,)$annotation/){
                    #concatena no elemento $position do hash $snps
                    #a anotacao separada por uma virgula
                    $snps{$position} = join("\,",($snps{$position},$annotation));
                }
                #}
            }
            else{  #Se não existe uma anotação para essa posição
                #atribui a fonte do snp e anotacao na posicao $position do
                #hash %snps, colocando um NA onde era para estar o nome do gene
                $snps{$position}  = join("\t",("NA",$annotation));
            }
        }
        close(IN);
    }
    # abre um novo (>) arquivo chamado $outfile com o numero do
    # cromossomo concatenado, que servirá de output
    open(out, ">$outfile"."$chr");
    print "Writing chr $outfile"."$chr"."\n";
    #para cada $position do hash ordenado pelas keys
    #(keys em ordem numerica, e nao de caracter, por isso o {$a<=$b>})...
    foreach $position(sort {$a<=>$b} keys %snps){
        #imprime no arquivo de output:
        #[posicao] \t [snpsource] \t [gene] \t [func, outras func]
        print out "$position\t$snps{$position}\n";
    }
    close(out);
}

