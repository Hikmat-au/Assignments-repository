library(tidyverse)
library(ggpubr) 
install.packages("ggpubr") 
install.packages("ggrepel") 
library(ggrepel) 

library(ggplot2)



mycotoxin<- read.csv("MycotoxinData.csv", na.strings = "na")
head(mycotoxin) 
str(mycotoxin)
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

mycotoxin$Treatment <- as.factor(mycotoxin$Treatment) 
mycotoxin$Cultivar <- as.factor(mycotoxin$Cultivar)
str(mycotoxin)

cbbPalette <- c("#56B4E9", "#009E73")

##DON_PLOT1
Plot1 <- ggplot(mycotoxin, aes(x = Treatment, y = DON, fill = Cultivar)) + 
  geom_boxplot() + # add boxplot layer 
  xlab("") +  
  ylab("DON (ppm)") + # y label 
  geom_point(alpha = 0.6,pch = 21, color = "black", position = position_jitterdodge()) + 
  scale_fill_manual(values = cbbPalette)+ # transparency of the jittered points to 0.6. #Jitter points over the boxplot and fill the points and boxplots Cultivar with two colors from the cbbPallete  
  facet_wrap(~Cultivar)+ #faceted by Cultivar 
  theme_classic() # for classic theme  

Plot1 


mycotoxin$Treatment<- factor(mycotoxin$Treatment, levels = c("NTC", "Fg", "Fg + 37", "Fg + 40", "Fg + 70"))


#15ADONandMassperSeed_mg
##15ADON_PLOT2
cbbPalette <-c ("#56B4E9", "#009E73")
Plot2 <- ggplot(mycotoxin, aes(x = Treatment, y = X15ADON, fill = Cultivar)) +
  geom_boxplot() + # add boxplot layer
  xlab("") + # xlabel empty 
  ylab("15ADON") + # y label
  geom_point(alpha = 0.6,pch = 21, color = "black", position = position_jitterdodge()) +
  scale_fill_manual(values = cbbPalette)+ # transparency of the jittered points to 0.6. #Jitter points over the boxplot and fill the points and boxplots Cultivar with two colors from the cbbPallete 
  facet_wrap(~Cultivar)+ #faceted by Cultivar
  theme_classic() # for classic theme 

Plot2


##MassperSeed_mg_PLOT3
Plot3 <- ggplot(mycotoxin, aes(x = Treatment, y = MassperSeed_mg, fill = Cultivar)) +
  geom_boxplot() + # add boxplot layer
  xlab("") +  
  ylab("Seed Mass (mg)") + # y label
  geom_point(alpha = 0.6,pch = 21, color = "black", position = position_jitterdodge()) +
  scale_fill_manual(values = cbbPalette)+ # transparency of the jittered points to 0.6. #Jitter points over the boxplot and fill the points and boxplots Cultivar with two colors from the cbbPallete 
  facet_wrap(~Cultivar)+ #faceted by Cultivar
  theme_classic() # for classic theme 

Plot3

#3Combined_PLOT
library(ggpubr)


figure=ggarrange(Plot1,Plot2,Plot3,labels = c("A", "B", "C"),nrow = 1,ncol = 3,common.legend=TRUE)
figure



#Ques5
## Plot 1: plot1 with pairwise comparisons 
Plot1_pwc <- Plot1 +
  geom_pwc(aes(group = Treatment), method = "t.test", label = "p.adj.format") +  # Add pairwise t-tests
  theme_classic()

Plot1_pwc


##Plot 2: plot2 with pairwise comparisons
Plot2_pwc <- Plot2 +
  geom_pwc(aes(group=Treatment), method= "t.test", label= "p.adj.format")+
  theme_classic()

Plot2_pwc

##Plot 3: plot3 with pairwise comparisons
Plot3_pwc = Plot3 + geom_pwc(aes(group=Treatment), method="t.test", label="p.adj.format")+
  theme_classic()

Plot3_pwc

#Combine all three plots with a common legend ----
Combined_pwc =ggarrange(Plot1_pwc,Plot2_pwc,Plot3_pwc,labels = c("D", "E", "F"),nrow = 1,ncol = 3,common.legend=TRUE)
Combined_pwc
