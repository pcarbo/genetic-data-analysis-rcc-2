# Analysis of Genetic Data 2:<br>Visualizing and interpreting the results of the genome-wide association analysis

Describe aim of Episode 4.

### A. Loading the results of the PLINK association analysis

Here we will read the PLINK results into R. PLINK saves the
association results in a format that makes it easy to inspect
visually, but unfortunately it is less machine readable because the
number of spaces between each column is variable. We will fix this
problem by reducing the spaces between each column to only one space:

```bash
cd ~/git/gda2/results
cat plink.qassoc | tr --squeeze-repeats " " > plink_new.qassoc
```

We now have a new PLINK results file that is more easily read into R.

Now that we have had some practice using `read.table` to read tables
or spreadsheets from text files, this step should be a little easier
this time around. First, open up R:

```bash
cd ~/git/gda2
R --no-save
```

Then enter the following:

```R
plink <- read.table(file        = "results/plink_new.qassoc",
                    sep         = " ",
                    header      = TRUE)
plink <- plink[2:10]					
print(head(plink))
```

Note that `read.table` doesn't handle leading and trailing spaces very
well; since there are leading and trailing spaces on each line, the
`read.table` function interpreted those as columns with no data. To
get rid of these empty columns, I included the second statement to
remove these two columns. Now the first column should be the
chromosome number ("CHR") and the last column should be the *p*-value
("P").

### B. Summarizing the genome-wide association results using R/qtl

The [R/qtl](http://rqtl.org) package has many features for association
analysis and other analyses of genetic data that we will not explore
in this workshop; here we will only use some of the powerful plotting
tools.

With the PLINK results now loaded into our R session, we will modify
this table so that it is in the exact same format as the output from
function `scanone`, which is the R/qtl function for mapping
associations. Once it it in the same format as a "scanone" output, we
can use R/qtl's functions for plotting.

```R
library(qtl)
plink.qtl <-
  data.frame(chr  = plink$CHR,
             pos  = plink$BP,
			 logp = -log10(plink$P))
rownames(plink.qtl) <- plink$SNP
class(plink.qtl)    <- c("scanone","data.frame")
print(head(plink.qtl))
```

The new data table has three columns: the chromosome number, the
base-pair position on the chromosome, and the *p*-value. Here we
applied a commonly used trick: transform the *p*-value onto the
logarithmic scale which improves the visual summary, especially when
some *p*-values are very small. By adding the minus sign, the smallest
*p*-values will show up on the top of the vertical axis.

One immediate benefit is that we can use the R/qtl interface to
quickly generate a summary of the association results:

```R
print(summary(plink.qtl))
```

This summary shows the smallest *p*-value on each chromosome, and the
corresponding SNP.

:ledger: Observe that at least one SNP on chromosome 13 has a very
 small *p*-value. What is the *p*-value?

This is useful for a quick summary, but there are many things it
doesn't tell us. For example, there could be multiple SNPs on
chromosome 13 with very small *p*-values, but this summary doesn't
tell us how many there are. R/qtl also has a plot function that is
designed specifically for visualizing the association signal across
the genome:

```R
# Optionally, create a new graphics device. Note this doesn't work
# in RStudio.
dev.new(height = 3.5,width = 12)

# Show the genome-wide association signal using the plot.scanone
# function from the 'qtl' package.
plot(plink.qtl,incl.markers = FALSE,type = "p",cex = 0.5,pch = 20,
     col = "darkblue",xlab = "",ylab = "-log10 p-value",gap = 3e7)
```

This provides a broad view of the association results. An association
on chromosome 13 stands out and, to a lesser degree, one on
chromosome 5. Next we will look more closely at these parts of the
genome to better understand the biological implications of these
results.

### C. A closer look at the association on chromosome 13



```R
rows <- which(plink.qtl$chr == 13)
plot(plink.qtl[rows,],incl.markers = FALSE,type = "p",cex = 0.5,pch = 20,
     col = "darkblue",xlab = "",ylab = "-log10 p-value",)
```

```R
rows <- which(plink.qtl$chr == 13 & plink.qtl$logp > 10)
print(plink.qtl[rows,])
```

Next steps:

+ Look up the region in the UCSC Genome Browser.

+ Look up information about the gene at the
  [NCBI site](https://www.ncbi.nlm.nih.gov/gene).

### Notes

Typically one will also include in the genome-wide plot a horizontal
line representing the "genome-wide" significance threshold. I
intentionally do not touch on the question of significance because it
is a complicated and ongoing discussion in the quantitative genetics
community, and many factors could influence the final threshold. For
this data set only, we have used a statistical method called a
permutation test to estimate a significance threshold of 2e-6. This
can be used as a rule of thumb *for this data set only*. How many
regions of the genome meet this threshold for the mapping of testis
weight?

