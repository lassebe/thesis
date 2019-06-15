library(ggplot2)
library(gridExtra)

stats <- read.table("/home/lasse/thesis/scripts/sir-methodstats.dat", header = TRUE, row.names = NULL, check.names = FALSE)




ggplot(stats, aes(x=experiment, y=recordedovertotal)) + 
        geom_bar(position=position_dodge(), fill="dodgerblue", colour="grey40", stat="identity", width=0.8) +
         coord_flip() +
         scale_x_discrete(limits = rev(levels(stats$experiment))) +
         xlab("Experiment name") +
         ylab("Ratio of summarised methods") +
         theme(text = element_text(size=17))

ggsave("methodsumratio.pdf", dpi=600)


ggplot(stats, aes(x=experiment, y=matchedcalls)) + 
        geom_bar(position=position_dodge(),fill="dodgerblue", colour="grey40", stat="identity", width=0.8) +
         coord_flip() +
         scale_x_discrete(limits = rev(levels(stats$experiment))) +
         xlab("Experiment name") +
         ylab("Ratio of matched calls") +
         theme(text = element_text(size=17))

ggsave("argsmatchratio.pdf", dpi=600)
