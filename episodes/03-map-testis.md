# Analysis of Genetic Data 2:<br>Mapping genetic associations with testis weight—a first pass

In this episode, we will use PLINK to map genetic loci associated with
a phenotype. More precisely, we will use PLINK to assess support for
phenotype-genotype associations at all of the >90,000 SNPs. We will
measure support for association by computing *p*-values.

We use testis weight as our example phenotype in this episode
primarily because the strong associations will yield more immediately
interpretable results.

We will see that most of the work is getting the data in the right
format for the analysis with PLINK. In the previous episode, we
discovered a problem: the rows of the phenotype data table
(**pheno.csv**) do not line up with the rows of the genotype data
table (**cfw.ped**). In the first part of this episode, we will use R
to prepare the phenotype data so that it is in the right format for
(correctly!) running a PLINK association analysis.

### A. Aligning the phenotype data to the genotype data

Many different ways to accomplish this. We will use R since learning
to read data into R will be useful later on in this workshop. This
will involve four steps:

1. Read sample information into R.

2. Read phenotype data into R.

3. Align the two data tables.

4. Output a new sample information file containing the phenotype
observations.

First, let's create a copy of the `cfw.fam` since we will create a new
version of this file with the values of the phenotype we are
interested in mapping.

```bash
cp cfw.fam cfw_old.fam
```

Next, start up the R environment:

```bash
cd ~/git/gda2
R --no-save
```

Let's now read in file `cfw.fam`, which contains the information about
the genotype samples (see
[here](http://www.cog-genomics.org/plink2/formats#fam) for a
description of the file format). The simplest way to read this file is
using the `read.table` function:

```R
fam <- read.table(file      = "data/cfw.fam",
                  sep       = " ",
				  header    = FALSE,
                  col.names = c("fid","id","pid","mid","sex","pheno"))
print(head(fam))
print(dim(fam))
```

Here we added our own column names to make the output easier to
understand. The second statement inspects the first 6 rows of the
table, and the third statement prints the number of rows and columns
of the table.

Our next step is to load the phenotype data as a large table, again
using the read.table command:

```R
pheno <- read.table(file   = "data/pheno.csv",
                    sep    = ",",
                    header = TRUE)
print(head(pheno[1:10]))					
print(dim(pheno))
```

Since the phenotype table is very large, here we inspect only the
first 10 columns. We did not need to provide column names since they
are already provided in the first line of the CSV file. Note that
there is an alternative function `read.csv` that is specifically
intended for reading CSV files, but we used `read.table` here to
contrast with the previous step.

Now that we have loaded the two tables, a single call to the `merge`
function will align the rows, similar to a database "join"
operation:

```R
combined.data <- merge(fam,pheno,by = "id",sort = FALSE)
head(combined.data[1:10])
print(dim(combined.data))
```

The first 6 columns of this new table are the exact same as the `fam`
table, although the columns are now a slightly different order.

Now that we have aligned the rows of the phenotype table against the
genotype sample ids, we are ready to write the phenotype data to a
file in the format that PLINK expects. Here we use the `write.table`
function for this:

```R
write.table(combined.data[c("fid","id","pid","mid","sex","testisweight")],
            file      = "data/cfw.fam",
			sep       = " ",
			row.names = FALSE,
			col.names = FALSE)
```

This will create a new file in the data folder in the same format as
the old file, except that the "dummy" phenotype column is replaced
with the testis weight data. Use `less` as before to inspect the new
file `cfw.fam` and compare against the old version `cfw_old.fam`.

:blue_book: You may notice that a few of the testis weights are
missing ("NA"). How would you quickly check the number of missing
values from the shell without having to scroll through the entire
file?

We now have all the data files we need to run the association analysis
in PLINK. Quit R to return to the shell environment.

### B. Assessing support for genetic associations using PLINK.

The
[--assoc function](http://www.cog-genomics.org/plink2/assoc#qassoc) in
PLINK fits a simple linear regression for each SNP, and computes test
statistics:

```bash
cd ~/git/gda2
plink --bfile data/cfw --assoc --out results/plink
```

Notice how quickly the analysis is completed! This command generates
two files in the results folder: file **plink.log**, which summarizes
the association analysis; and **plink.qassoc**, a text file containing
test statistics computed for each SNP. You can use `wc` to check that
the number of lines in this file equals the number of SNPs.

Use `less -S` to examine this file. The last column of this file is
usually the one that researchers are most interested in; it is the
*p*-value calculated under the Wald test, in which values indicate
greater evidence for an association with the phenotype. See
[the PLINK documentation](http://www.cog-genomics.org/plink2/formats#qassoc)
for a more detailed explanation of the results contained in this file.

:white_check_mark: We have successfully completed the genome-wide
association analysis for testis weight, but it is difficult to make
sense of the results by visual inspection. So in
[the next episode](04-plot-genomewide-scan.md) we will generate an
evocative visual summary of the results using the
[R/qtl](http://www.rqtl.org) package.

