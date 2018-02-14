library(ggplot2)
stats <- read.table("/home/lasse/thesis/scripts/centralised.dat", header = TRUE, row.names = NULL, check.names = FALSE)


ggplot(stats, aes(factor(experiment), pct, fill = factor(reason))) +
        geom_bar(stat = "identity", color = "grey40", width=.6) +
        coord_flip() +
        scale_x_discrete(limits = rev(levels(stats$experiment))) +
        labs(fill = "Reason")