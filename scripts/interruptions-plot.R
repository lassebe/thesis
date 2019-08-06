library(ggplot2)
stats <- read.table("/home/lasse/thesis/scripts/sir-interrupt.dat", header = TRUE, row.names = NULL, check.names = FALSE)
stats2 <- read.table("/home/lasse/thesis/scripts/stateless-interrupt.dat", header = TRUE, row.names = NULL, check.names = FALSE)

ggplot(stats, aes(factor(experiment), pct, fill = factor(reason))) +
        geom_histogram(stat = "identity", col = "black", color = "grey40", bins=12, binwidth=50) +
	scale_colour_brewer(palette = "Set1") +
        scale_fill_discrete(guide = guide_legend(reverse=TRUE)) +
        coord_flip() +
        scale_x_discrete(limits = rev(levels(stats$experiment))) +
        labs(fill = "Reason") +
        guides(fill=guide_legend(nrow=3,byrow=TRUE, reverse=TRUE)) +
        xlab("Experiment name") +
        ylab("Percentage") +
        theme_bw() +
        theme(axis.text.x = element_text(size=14)) +
        theme(axis.text.y = element_text(size=14)) +
        theme(legend.position = "bottom",
          legend.title.align=-30, 
          legend.direction = "horizontal",
          legend.title = element_text(size = 14),
          legend.text = element_text(size = 14)) +
        theme(text = element_text(size=16))

ggsave("sir-interrupt.pdf", dpi=600, width = 9, height = 9)


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
