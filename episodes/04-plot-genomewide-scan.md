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

Now that we have had some
practice using `read.table` to read tables or spreadsheets from text
files, this step should be a little easier this time around. First,
open up R:

```bash
cd ~/git/gda2
R --no-save
```

Then enter the following:

```R
plink <- read.table(file        = "results/plink_new.qassoc",
                    sep         = " ",
                    header      = TRUE,
					strip.white = TRUE)
plink <- plink[2:10]					
print(head(plink))
```

Since there are leading and trailing spaces on each line, the
`read.table` function interpreted those as columns with no data, so I
included the second statement to remove these two columns. Now the
first column should be the chromosome number (**CHR**) and the last
column should be the *p*-value (**P**).

### B. Summarizing the genome-wide association results using R/qtl

The [R/qtl](http://rqtl.org) package has many features for association
analysis that we will not explore in this workshop; here we will only
use the powerful plotting functions.

With the PLINK results now loaded into our R session, we will modify
this table so that it is in the exact same format as the output from
`scanone`, the R/qtl function for mapping associations:

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

Explain here what this does, and why we converted the p-values to the
logarithmic scale; this is commonly done.

One benefit is that we can use the R/qtl interface to quickly generate
a summary of the association results:

```R
print(summary(plink.qtl))
```

*Describe the summary here.*

:ledger: Observe that at least one SNP on chromosome 13 has a very
 small $p$-value. What is the $p$-value?

This is useful for a very quick summary, but there are many things it
doesn't tell us. R/qtl also has a plot function that is designed
specifically for visualizing the association signal across the genome:

```R
# Optionally, create a new graphics device. Note this doesn't work
# in RStudio.
dev.new(height = 3.5,width = 12)

# Show the genome-wide association signal using the plot.scanone
# function from the 'qtl' package.
plot(plink.qtl,incl.markers = FALSE,type = "p",cex = 0.5,pch = 20,
     col = "darkblue",xlab = "",ylab = "-log10 p-value",gap = 3e7)
		  
```

This provides a "big picture" view of the association
result. Association on chromosome 13 stands out and, to a lesser
degree, one on chromosome 5. Next we will look more closely at these
parts of the genome to better understand the biological implications
of these results.

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

Typically one will also include in this plot a horizontal line
representing the "genome-wide" significance threshold. I intentionally
do not show this. Why? *Discuss question of significance threshold.*
