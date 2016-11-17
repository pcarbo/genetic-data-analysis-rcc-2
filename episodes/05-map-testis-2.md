# Analysis of Genetic Data 2:<br>Mapping genetic associations with testis weight—a second attempt

Here we will take a closer look at the phenotype data, which will lead
to an improved and more accurate genome-wide association
analysis. *This episode is not yet completed.*

Some useful R code:

```R
library(ggplot2)
out <- transform(combined.data,
                 testisweight = cut(testisweight,seq(0,0.3,0.005)))
print(ggplot(out,aes(testisweight)) +
      geom_bar(fill = "dodgerblue") +
	  theme_minimal() +
	  theme(axis.text.x = element_text(angle = 45)))
```

Some more useful R code:

```R
x <- mean(combined.data$testisweight,na.rm = TRUE)
y <- sd(combined.data$testisweight,na.rm = TRUE)
print(x + 3*c(-y,+y))
```
