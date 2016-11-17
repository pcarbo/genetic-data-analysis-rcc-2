# Analysis of Genetic Data, Part 2
**Research Computing Center, University of Chicago**<br>
November 17, 2016<br>
2:00 pm - 4:00 pm<br>
**Instructor:** Peter Carbonetto<br>
**Helpers:** Will Graybeal

Register [here](https://training.uchicago.edu/course_detail.cfm?course_id=1715).

## General Information

Following from [Analysis of Genetic Data
Part 1](https://github.com/pcarbo/genetic-data-analysis-rcc-1), in this
2-hour workshop we will use PLINK and R to generate interesting
biological insights from large-scale genetic data. We will also use
online databases such as the UCSC Genome Browser to interpret the
output of the data analyses. Although no background in genetics is
required to follow the examples, participants with exposure to
concepts in modern quantitative genetics will be in a better position
to benefit from this workshop. Since we cannot work with human data
due to data sharing restrictions, we will download and investigate
data from a mouse genetics study.

**Level:** Intermediate

**Prerequistes:** This workshop assumes some experience performing
simple tasks in a UNIX-like shell environment, as well as basic
familiarity with R. Participants must be able to log in to the RCC
compute cluster, although experience using the RCC cluster is not
required. All participants must bring a laptop with a Mac, Linux, or
Windows operating sytem that they have administrative privileges on.
*Note:* Attending
[Part 1](https://github.com/pcarbo/genetic-data-analysis-rcc-1) is
*not* required for the second part.

**Where:** Kathleen A. Zar Room, John Crerar Library, University of
  Chicago ([OpenStreetMap](https://www.openstreetmap.org/search?query=john%20crerar%20library#map=18/41.79053/-87.60282)).

**Additional info:** This workshop is an attempt to apply elements of
the
[Software Carpentry approach](http://software-carpentry.org/lessons)
(see also
[this article](http://dx.doi.org/10.12688/f1000research.3-62.v2)) to
interactive instruction for computing/quantitative sciences.

Please also take a look at the [Code of Conduct](conduct.md), and the
[Software License](LICENSE) which applies to all the scripts and code
examples in this repository. All instructional material contained in
this repository is made available under the Creative Commons
Attribution license
([CC BY 4.0](https://creativecommons.org/licenses/by/4.0)).

## Aims

1. Explore the application of numeric techniques for identifying
the genetic factors that contribute to a measured trait.

2. Understand how large-scale genetic data sets are commonly
represented in computer files.

3. Use command-line tools to manipulate genetic data.

4. Use R to summarize and visualize the results of a genetic data
analysis.

5. Practice using the RCC shell environment (*midway*) for large-scale
data processing and analysis.

## Episodes

| Episode | Concepts |
| --- | --- |
| 1. [Setup](episodes/01-setup.md) | How do I set up my shell environment on *midway* for an analysis of genetic data? |
| 2. [Inspecting the data](episodes/02-explore-data.md) | How are genetic data commonly represented in computer files?<br>How can I use standard shell commands to explore and summarize genetic data? |
| 3. [Mapping genetic associations](episodes/03-map-testis.md) | *Description goes here.* |
| 4. [Visualizing and interpreting the association analysis](episodes/04-plot-genomewide-scan.md) | *Description goes here.* |
| 5. [Refining the association analysis](episodes/05-map-testis-2.md) | *Description goes here.* |
