install.packages("tidyverse")
library(tidyverse)

mtcars
#The line is on the top of the points

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method=lm, se=FALSE)

  #the points are on the top

ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_smooth(method=lm, se=FALSE) +  
  geom_point(aes(color=hp)) +
  xlab("weight(tons)") +
  ylab("miles per gallon") +
  scale_color_gradient(low="green", high="grey")

#bars with SE error bars
bull.richness<-read.csv("Bull_richness.csv")
ggplot(bull.richness,aes(x=GrowthStage, y=richness, color=Fungicide, fill=Fungicide)) +
geom_boxplot()+
geom_point(position = position_jitterdodge()) +
  scale_fill_manual(values=c("orange","blue")) +
  scale_color_manual(values=c("red","yellow"))
  
#bars with SE error bars
ggplot(bull.richness,aes(x=GrowthStage, y=richness, fill=Fungicide)) +
  stat_summary(fun=mean,geom="bar",position="dodge")+
  stat_summary(fun.data=mean_cl_normal, geom="errorbar", position = "dodge")

#facetting
ggplot(bull.richness,aes(x=GrowthStage, y=richness, color=Fungicide, group = Fungicide)) +
  stat_summary(fun=mean,geom="line") +
  stat_summary(fun.data=mean_cl_normal, geom="errorbar")+
  facet_wrap(~Treatment*Crop,scales="free")

  


