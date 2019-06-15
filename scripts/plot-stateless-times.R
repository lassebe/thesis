library(ggplot2)

times2 <- read.table("/home/lasse/thesis/scripts/graphing/stateless-fast.dat", header = TRUE, row.names = NULL, check.names = FALSE)
times3 <- read.table("/home/lasse/thesis/scripts/graphing/stateless-slow.dat", header = TRUE, row.names = NULL, check.names = FALSE)

ggplot(times2, aes(x=exper, y=mean, fill=type)) + 
    geom_bar(position=position_dodge(), stat="identity", width=0.9) +
     geom_errorbar(aes(ymin=(mean-se), ymax=(mean+se)),
                  size=0.4,                      # thinner lines
                  width=.2,                    # Width of the error bars
                  position=position_dodge(.8)) +
     coord_flip() +
     guides(fill = guide_legend(reverse = TRUE)) +
     scale_x_discrete(limits = rev(levels(times2$exper))) +
     xlab("Experiment name") +
     ylab("Running time (ms)") +
     theme(text = element_text(size=17))

ggsave("stateless-fast.pdf", dpi=600)



ggplot(times3, aes(x=exper, y=(mean/1000), fill=type)) + 
    geom_bar(position=position_dodge(), stat="identity", width=0.9) +
     geom_errorbar(aes(ymin=(mean-se)/1000, ymax=(mean+se)/1000),
                  size=0.4,                      # thinner lines
                  width=.2,                    # Width of the error bars
                  position=position_dodge(.8)) +
     coord_flip() +
     guides(fill = guide_legend(reverse = TRUE)) +
     scale_x_discrete(limits = rev(levels(times3$exper))) +
     xlab("Experiment name") +
     ylab("Running time (s)") +
     theme(text = element_text(size=17))

ggsave("stateless-slow.pdf", dpi=600)