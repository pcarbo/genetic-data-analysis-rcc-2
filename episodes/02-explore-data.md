# Analysis of Genetic Data 2:<br>Inspecting the data using UNIX command-line tools

In this episode, we will use standard UNIX shell commands to explore
the mouse genetics data. The aim is to get an initial impression of
the data, and to appreciate how simple shell commands can be used to
examine large-scale data.

The data set contains three types of data:

1. The SNP data: Information about the single nucleotide polymorphisms
(SNPs) that we have genotyped, such as their database id, and on which
chromosome they are found.

2. The genotype data: the genotypes sampled, or "called," for every
sample and every SNP. 

3. The phenotype data: measurements such as body weight and glucose
levels that were recorded for every mouse. In this study, this
includes measurements that were recorded to assess behavior.

Here we will investivate how these three types of data are stored in
compute files for this data set. We will start by taking a quick look
at the phenotype data.

```bash
column -s, -t pheno.csv | less -S
```

