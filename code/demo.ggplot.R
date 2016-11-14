# Short R script to check that R graphics are working, and to
# demonstrate the ggplot2 package for quickly creating sophisticated
# plots.

# Load the ggplot2 package.
library(ggplot2)

# Generate the data points.
n <- 500
x <- sort(20*runif(n) - 10)
y <- sin(x) + rnorm(n)/10
r <- factor(sample(1:4,n,replace = TRUE))

# Generate the plot using ggplot.
print(ggplot(data.frame(x,y,r),aes(x = x,y = y,col = r)) + 
      geom_point(cex = 1.5) +
      scale_color_manual(values = c("dodgerblue","darkorange",
                                    "orangered","gold")) +
      theme_minimal() +
      labs(x = "x",y = "sin(x) + e") +
      theme(panel.grid.major = element_blank(),
            axis.text        = element_text(size = 11)))
