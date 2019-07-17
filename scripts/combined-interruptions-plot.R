library(ggplot2)
stats <- read.table("/home/lasse/thesis/scripts/combined-interrupt.dat", header = TRUE, row.names = NULL, check.names = FALSE)

ggplot(stats, aes(factor(experiment), pct, fill = factor(reason))) +
        geom_histogram(stat = "identity", color = "grey40", bins=8, binwidth=200) +
        scale_colour_brewer(palette = "Set1") +
        scale_fill_discrete(guide = guide_legend(reverse=TRUE)) +
        coord_flip() +
        scale_x_discrete(limits = rev(levels(stats$experiment))) +
        labs(fill = "Reason") +
        xlab("Experiment name") +
        ylab("Percentage") +
        theme(text = element_text(size=17))

ggsave("combined-interrupt.pdf", dpi=600, height = 9)
