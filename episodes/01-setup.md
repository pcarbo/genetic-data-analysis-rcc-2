# Analysis of Genetic Data 2: Setup

These instructions assume that you have a user or guest account on the
RCC compute cluster, *midway*. If you plan to use a different
computing resource (e.g., another compute cluster, your own laptop),
the steps described here, and in subsequent episodes, will be slightly
different.

### Introduce yourself

Introduce yourself to your neighbors. If you get stuck in any of the
steps of this workshop, ask one your neighbors for help.

We will may this Google doc .

We may use the University of Chicago
[Google Docs](http://gdocs.uchicago.edu) to share and discuss our
results, or ask questions, as we work through the episodes. Open up
the [Workshop Google doc](http://tinyurl.com/h46hnm2) in your Web
browser, and **introduce yourself**.


### Getting a midway user account

If you do not have a
[user account on midway](http://rcc.uchicago.edu/getting-started/request-account), the instructor can provide you with a YubiKey, which will
allow you to access *midway* for the duration of the workshop.

. If
you do not have a *midway* account, please ask the instructor for
access. If you plan to use a different computing resource (e.g.,
another compute cluster, your own laptop), the exact steps described
here, and in subsequent episodes, will be slightly different for you.

Log on to midway using ssh with X forwarding:

```bash
ssh -X username@midway.rcc.uchicago.edu
```

Request an **interactive session** using the reservation for this
workshop. To safeguard against losing your connection, I recommend
using **screen**, but this is optional.

```bash
screen -S workshop-gda1
sinteractive --time=02:45:00 --mem=4G --reservation=workshop-3-nov-2016
```

*If you have volunteered to generate the PCA results, you will need to
request 8 GB of memory instead of 4 GB.*

Load the modules necessary to complete the exercises.
  
```bash
module load R/3.2
module load plink/1.90
module load admixture
```
  
*Optionally*, load [RStudio](https://rstudio.rcc.uchicago.edu) in
your browser. The rest of workshop will assume that you are running R
from the shell, but all the steps should work in RStudio as well.

Clone this repository. (Note you don't need a github account to do
this.)

```bash
mkdir -p ~/git
cd ~/git
git clone https://github.com/pcarbo/genetic-data-analysis-rcc-1.git gda1
```

After completing this step, you should have a bunch of new files and
folders in `~/git/gda1`.

If you have a github account, please log in to your account and
bookmark this repository by clicking the "Star" button at the
top-right corner of this webpage.

Copy the data files into the "data" folder in the repository. The data
files take about 350 MB of space, so make sure you have enough space
left over in your home directory for these files. (Run the `quota`
command to check.)

```bash
cd ~/git/gda1/data
cp /project/rcc/workshops/genetic-data-analysis-1/data/* .
```

Running ADMIXTURE ([Episode 4](04-admixture.md)) may take longer than
2 hours to complete, so we have pre-generated the ADMIXTURE
results. Copy these results files into the results folder in the
github repo.

```bash
cd ~/git/gda1/results
cp /project/rcc/workshops/genetic-data-analysis-1/results/* .
```

Make sure that you can generate and view graphics in R using
[ggplot2](http://ggplot2.org). First, start R,

```bash
cd ~/git/gda1
R --no-save
```

and once you have loaded the R environment, enter:

```R
source("code/demo.ggplot.R")
```

This should create an oscillating arrangement of multicolour dots. If
this is not working on your computer, and alternative (for the
*midway* cluster only) is [ThinLinc](http://rcc.uchicago.edu/docs/connecting/index.html#connecting-with-thinlinc).

:white_check_mark: Once you have successfully completed all these
steps, you are ready to move on to [Episode 2](02-pca.md).

### Notes

These instructions are adapted from [the Setup for Part 1](https://github.com/pcarbo/genetic-data-analysis-rcc-1/blob/master/episodes/01-setup.md).
