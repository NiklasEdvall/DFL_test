
#Libraris
library(readr)
library(ggplot2)
library(ggdark)

#Read data with adjusted var types
dat <- read_csv("result.csv", 
                     col_types = cols(trial_type = col_factor(levels = c("Same", "Different")), 
                                      response = col_factor(levels = c("Same", "Different", "Catch"))))

#List trial_types same for plot
same.trials <- which(dat$trial_type == "Same")
same.xmin <- same.trials - 0.15
same.xmax <- same.trials + 0.15
same.ymin <- rep(-50,length(same.trials))
same.ymax <- rep(50,length(same.trials))

#Plot
ggplot(dat, aes(x=trial_n, y=reference_freq-test_freq, fill = response)) + 
  geom_bar (stat="identity",position = position_dodge(0.9)) +
  
  scale_fill_manual(name = "Response", 
                    values=c("#FF6F61", "#009B77", "#5780c1"), 
                    breaks = c("Same", "Different", "Catch"), drop = FALSE) +
  
  ggtitle("Difference Limen - Frequency") +
  xlab("Trial (n)") +
  ylab("Stimuli difference (Hz)") +
  
  scale_y_continuous(limits = c(-200,200)) +
  annotate("rect", xmin = same.xmin, xmax = same.xmax, ymin = same.ymin, ymax = same.ymax, fill = "#5780c1", alpha = 1) +
  dark_theme_minimal() +
  theme(panel.grid.major = element_line(colour = "#5c5c5b", linetype = "solid"),
        panel.grid.minor = element_line(colour = "#5c5c5b", linetype = "dashed"),
        
        plot.title = element_text(size=24, face="bold", hjust = 0.5),
        axis.title.x = element_text(size=20, face="bold"),
        axis.title.y = element_text(size=20, face="bold"),
        
        axis.text.x = element_text(size = 16),
        axis.text.y = element_text(size = 16),
        
        legend.title=element_text(size=20),
        legend.text=element_text(size=14))