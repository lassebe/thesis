library(ggplot2)
# header = TRUE ignores the first line, check.names = FALSE allows '+' in 'C++'
times <- read.table("/home/lasse/thesis/scripts/graphing/stateless-fast.dat", header = TRUE, row.names = "id", check.names = FALSE)


ggplot(times, aes(x=exper, y=mean, fill=type)) + 
    geom_bar(position=position_dodge(), stat="identity") +
     geom_errorbar(aes(ymin=mean-se, ymax=mean+se),
                  size=.1,                      # thinner lines
                  width=.2,                    # Width of the error bars
                  position=position_dodge(.9)) +
     xlab("Experiment name") +
     ylab("Running time (ms)") +
     theme(axis.text.x = element_text(angle = 90, hjust = 1))