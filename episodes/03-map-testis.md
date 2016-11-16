# Analysis of Genetic Data 2:<br>Mapping genetic associations with testis weight—a first pass

Explain aim for this next episode: use PLINK to map genetic loci
associated with testis weight. Motivate mapping genetic associations
for testis weight. Most of the work is getting the data in the right
format for the analysis with PLINK.

However, we discovered a problem in the previous episode: the rows of
the phenotype data table (**pheno.csv**) do not line up with the rows
of the genotype data table (**cfw.ped**). In the first part of this
episode, we will use R to package up the phenotype data in the right
format so that we can (correctly!) run an association analysis using
PLINK.

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

The `--assoc` command

```bash
cd ~/git/gda2/data
plink --bfile cfw --assoc
```
