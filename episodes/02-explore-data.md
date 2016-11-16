# Analysis of Genetic Data 2:<br>Inspecting the data using UNIX command-line tools

In this episode, we will use standard UNIX shell commands to briefly
explore the mouse genetics data. The aim is to get an initial
impression of the data, and to appreciate how simple shell commands
can be used to examine large-scale data.

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
computer files using standard file formats. We will start by taking a
quick look at the phenotype data.

:pencil2: Along with the data files, you should have downloaded an
accompanying "readme" file describing the data files in detail.
Consult this file if you would like to learn more about the
data set.

### A. The phenotype data

The phenotype data are stored in file **pheno.csv**. This is a
standard way of representing a data table in a text file, in which
rows correspond to lines of the file, and commas are used to define
the columns.

Glance at the phenotype data by entering the following commands in the
shell:

```bash
cd ~/git/gda2/data
less -S pheno.csv
```

You can use the arrows to move to different rows and columns of the
table.

This command shows us the "raw" text. This is not a nice way to view a
table, but at least gives us an initial impression. Using the `column`
command, combined with `less`, we can view this file in a way that
makes it much easier to read as a table:

```bash
column -s, -t pheno.csv | less -S
```

The column command creates a new text file in which the text between
the commas is lined up to make the data much more readable (by a
human).

This view allows us to make a few observations about the data:

1. The first line of the file is the table header.

2. The sample id is given in the first (left-most) column of the table.

3. Each line after the first gives us a long list of measurements
("phenotype values") for one mouse.

4. Some measurements are recorded as numeric values. Others are
categorical (e.g., yes/no).

5. A small fraction of measurements are missing. "NA" is the
convention in R (and in other programs) to encode a missing value.

:blue_book: How many rows (*i.e.,* samples) are in this table? We can
easily find out using another shell command:

```bash
wc -l pheno.csv
```

The total number of samples is one less than this number because the
table header was also counted.

:pencil2: To find out more information about any of the commands we
use in the examples, type `man <command>` in the UNIX shell. For
example, to read more about the less command, type `man less`.

### B. The SNP data

SNP genotypes are now by far the most common type of genetic data
generated. Thanks to recent advances in genotyping technologies, these
data are relatively inexpensive to obtain (at least for many
organisms), and a wide range of statistical methods have been
developed to manipulate and analyze SNP genotypes.

The information about the SNPs is contained in two files: **map.txt**
and **cfw.bim**. The latter is the standard file format used by
[PLINK](http://www.cog-genomics.org/plink2). Let's take a closer look
at this file:

```bash
cd ~/git/gda2/data
less -S cfw.bim
```

Like the phenotype file, the data are stored in columns. Here, the
columns are separated by spaces instead of commas. Unlike the
phenotype file, the columns do not have headers telling us what the
data mean. Therefore, we need to consult the
[PLINK documentation](http://www.cog-genomics.org/plink2/formats#bim).

From a quick glance of this file using `less`, it seems that the
SNPs are ordered by chromosome number (precisely, autosomal
chromosomes), and then by base-pair position along the chromosome
(according to whatever genome reference is being used—in this case,
[Genome Reference Consortium Mouse Build 38](http://www.ncbi.nlm.nih.gov/assembly/327618)
was used).

You will need to be very patient if you want to use the arrows to
scroll to the bottom of the file. Alternatively, you can use the
`tail` command to quickly glance at the bottom of the file.
Additionally, use `wc` to count the number of SNPs:

```bash
wc -l cfw.bim
```

:blue_book: Why are some SNP ids of the form rs---, and others are not?

### C. The genotype data

The genotypes are stored in
[PLINK's binary format](http://www.cog-genomics.org/plink2/formats#bed).
For computer programs, this is convenient because the data can be read
very quickly. The disadvantage is that it is not human readable.
Fortunately, we can use PLINK to convert the binary format to human
readable (but much less compact) format:

```bash
cd ~/git/gda2/data
plink --bfile cfw --recode --out cfw
```

This command outputs a file, **cfw.ped**, which we can now inspect by
eye. (As a bonus, another outputted file, **cfw.log**, provides a
compact summary of the data.)

As we did for the phenotype and SNP data, the genotypes are now
conveniently viewable as a raw text file:

```bash
less -S cfw.ped
```

This genotype file format is explained
[here](http://www.cog-genomics.org/plink2/formats#ped). The
description is a bit hard to follow, so for the purpose of this
workshop, suffice to say that each row corresponds to a sample, 
the second (space-delimited) column gives the sample id, and every
pair of columns after the 6th column gives the genotype at the SNP in
the corresponding line of the **cfw.bim** file. Observe that some
genotypes are "0 0". What do you think this means?

:ledger: We would expect that the number of samples and the number of
SNPs matches up with the numbers we obtained from the other files we
have viewed so far. Similar to before, we can use the `wc` commmand to
check this:

```bash
wc -w -l cfw.ped 
```

The first number gives the number of lines, and the second number
gives the number of "words". How can you use these two numbers to get
the number of SNPs? (Keep in mind that one genotype is represented by
a pair of letters; e.g., "A G".) What inconsistency to you find?

:blue_book: Use the `ls -l` command to assess how efficient the binary
representation (**.bed**) is relative to the text format (**.ped**).

:blue_book: For the most part, we use standard UNIX tools to inspect
and summarize the data. PLINK provides several specialized tools that
generate detailed summaries of the data provided that the data are in
a format supported by PLINK. For example, the following command
generates a report of the proportion of missing genotypes per sample
and per SNP:

```bash
plink --bfile cfw --missing
```

Observe that the proportion of missing genotypes per sample is
high—usually above 20%. This is because the genotype data in this
study were obtained using a technology that is relatively inexpensive,
but can come at the cost of lower accuracy. Genotypes estimated with
less certainty have been removed, and reported as "missing".

We did not focus on these specialized tools in this episode because it
is important to appreciate that even very simple shell programs such
as `wc` can be useful for inspecting genetic data files.

:white_check_mark: Now that we have gained some familiarity with the
data, and how these data are encoded in computer files, in
[the next episode](03-map-testis.md) we will use these data files to
assess support for genetic associations with a measured trait.
