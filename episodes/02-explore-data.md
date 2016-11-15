# Analysis of Genetic Data 2:<br>Inspecting the data using UNIX command-line tools

In this episode, we will use standard UNIX shell commands to explore
the mouse genetics data. The aim is to get an initial impression of
the data, and to appreciate how simple shell commands can be used to
examine large-scale data.

The data set contains three types of data:

1. **The SNP data**: Information about the single nucleotide
polymorphisms (SNPs) that we have genotyped, such as their database
id, and on which chromosome they are found.

2. **The genotype data**: A large file storing the genotype sampled
for every sample, and for every SNP.

3. **The phenotype data**: Measurements such as body weight and
glucose levels that were recorded for every mouse. In this study, this
includes measurements that were recorded to assess behavior.

Here we will investivate how these three types of data are stored in
compute files for this data set. We will start by taking a quick look
at the phenotype data.

:pushpin: Along with the data files, you should have downloaded an
accompanying "readme" file describing the data files in detail. Please
consult this file if you would like to dig deeper beyond what we have
explored in this episode.

### A. The phenotype data

The phenotype data are stored in file **pheno.csv**. This is a
standard way of representing a data table in a text file, in which
rows correspond to lines of the file, and the separation between
columns is demarked using commas.

Glance at the phenotype data with the following commands:

```bash
cd ~/git/gda2/data
less -S pheno.csv
```

You can use the arrows to move to different rows and columns of the
table.

This command shows us the "raw" text, which is not a particularly nice
way to view a table. It does, however, allow us to make a few
observations about the data:

+ The first line of the file gives the column header.

+ A sample id is given in the first table column.

+ Each line after the first gives us a long list of measurements
("phenotype values") for one mouse.

+ Some measurements are recorded as numeric values, while others are
categorical (e.g., yes/no).

+ A small fraction of measurements are missing—"NA" is the
convention in R (and in other programs) to encode a missing value.

Using the `column` command, combined with `less`, we can view this
file in a way that makes it much easier to read as a table:

```bash
column -s, -t pheno.csv | less -S
```

The column command lined up the text between the commas to make the
data much more (human) readable.

How many rows (samples) are in this table? We can easily find out
using another shell command:

```bash
wc -l pheno.csv
```

The total number of samples is one less than this number because the
table header was also counted.

:pushpin: To find out more information about any of the commands we
use in the examples, type `man <command>` in the UNIX shell. For
example, to read more about the less command, type `man less`.

### B. The SNP data

SNP data is now by far the most common type of genetic data used
because it is relatively inexpensive to measure (at least for many
organisms) genotypes for a large number of SNPs (typically hundreds of
thousands), and a wide range of statistical methods have been
developed to analyze SNP data.

The information about the SNPs is contained in two files:
[map.txt](/data/map.txt) and cfw.bim
