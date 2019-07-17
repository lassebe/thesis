library(ggplot2)
stats <- read.table("/home/lasse/thesis/scripts/sir-interrupt.dat", header = TRUE, row.names = NULL, check.names = FALSE)
stats2 <- read.table("/home/lasse/thesis/scripts/stateless-interrupt.dat", header = TRUE, row.names = NULL, check.names = FALSE)

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

ggsave("sir-interrupt.pdf", dpi=600, width = 6)


ggplot(stats2, aes(factor(experiment), pct, fill = as.factor(reason))) +
        geom_histogram(stat = "identity", color = "grey40", aes(color=factor(reason)) ) +
	scale_fill_discrete(guide = guide_legend(reverse=TRUE)) +
        scale_color_brewer(palette="Dark2") +
	coord_flip() +
        scale_x_discrete(limits = rev(levels(stats2$experiment))) +
        labs(fill = "Reason") +
        xlab("Experiment name") +
        ylab("Percentage") +
        theme(text = element_text(size=17))

ggsave("stateless-interrupt.pdf", dpi=600, height = 4, width = 6)
