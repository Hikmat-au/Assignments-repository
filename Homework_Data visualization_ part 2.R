#Homework:Coding Notes-Data visualization Part 2
##loading package
library(tidyverse)
install.packages("ggpubr")
library(ggpubr)
library(ggrepel)
library(ggplot2)

#figure design for accessibility
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

#stitching multiple plots together
##read in the data
sample.data.bac<-read.csv("BacterialAlpha.csv", na.strings="na")
sample.data.bac$Time_Point<-as.factor(sample.data.bac$Time_Point)
sample.data.bac$Crop<-as.factor(sample.data.bac$Crop)
sample.data.bac$Crop <- factor(sample.data.bac$Crop, levels = c("Soil", "Cotton", "Soybean"))
str(sample.data.bac)

#Bacterial evenness; Figure 2a
bac.even <- ggplot(sample.data.bac, aes(x = Time_Point, y = even, color = Crop))+
  geom_boxplot(position = position_dodge(0.85))+
  geom_point(position = position_jitterdodge(0.05))+
  ylab("Pielou's evenness") +  
  xlab("Hours post sowing") +  
  scale_color_manual(values = cbbPalette, name = "", labels = c("Soil no seeds", "Cotton spermosphere", "Soybean spermosphere")) +  
  theme_classic() 
  bac.even
  bac.even <- ggplot(sample.data.bac, 
                     aes(x = Time_Point, y = even, color = Crop)) +
    geom_boxplot(position = position_dodge(0.85)) +
    geom_point(shape = 21, fill = "white", color = "black",
               position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.85)) +
    ylab("Pielou's evenness") +
    xlab("Hours post sowing") +
    scale_color_manual(values = c("#E69F00", "#56B4E9", "#009E73"),name = "",labels = c("Soil no seeds", "Cotton spermosphere", "Soybean spermosphere")) +
    theme_classic()
  bac.even

#Water Imbibition correlate with bacterial evenness; Figure 2b
sample.data.bac.nosoil <- subset(sample.data.bac, Crop != "Soil")
water.imbibed <- ggplot(sample.data.bac.nosoil, aes(Time_Point, 1000 * Water_Imbibed, color = Crop)) +  
    geom_jitter(width = 0.5, alpha = 0.5) +  
    stat_summary(fun = mean, geom = "line", aes(group = Crop)) +  
    stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5) +  
    xlab("Hours post sowing") +  
    ylab("Water Imbibed (mg)") +  scale_color_manual(values = c("#56B4E9", "#009E73"),name = "",labels = c("Cotton", "Soybean")) +  
    theme_classic() +  
    theme(strip.background = element_blank(), legend.position = "none") +  
    facet_wrap(~Crop, scales = "free")
  water.imbibed

# Figure 2c
water.imbibed.cor <- ggplot(sample.data.bac.nosoil,aes(x = 1000 * Water_Imbibed,y = even,color = Crop)) +
    geom_point(aes(shape = Time_Point), size = 3) +   
    geom_smooth(method = lm,se = FALSE,aes(group = Crop)) +  
    xlab("Water Imbibed (mg)") +
    ylab("Pielou's evenness") +
    scale_color_manual(values = c(cbbPalette[[1]], cbbPalette[[2]]),name = "") +
    scale_shape_manual(values = c(15, 16, 17, 18),name = "",labels = c("0 hrs", "6 hrs", "12 hrs", "18 hrs")) +
    theme_classic() +
    theme(strip.background = element_blank()) +
    facet_wrap(~Crop, scales = "free")
  water.imbibed.cor

##Figure 2; significance levels added with Adobe or powerpoint #### 
  install.packages("ggpubr")
  library(ggpubr)
  figure2 <- ggarrange(water.imbibed,bac.even,water.imbibed.cor,labels = "auto",  nrow = 3,  ncol = 1, legend = FALSE) 
  bac.even + 
  stat_compare_means(method = "anova") 

### Example with pvalues as significance levels
  bac.even + 
  geom_pwc(aes(group = Crop), method = "t_test", label = "p.adj.format")
  
### example with * as significance levels
  bac.even + 
  geom_pwc(aes(group = Crop), method = "t_test", label = "p.adj.signif")
  
  
  ### Example with combined pvalue and * to indicate significance
  bac.even + 
  geom_pwc(aes(group = Crop), method = "t_test", label = "{p.adj.format}{p.adj.signif}")
  
  water.imbibed.cor + 
    stat_cor()
  
  water.imbibed.cor + 
    stat_cor(label.y = 0.7) +
    stat_regline_equation()  
  ##,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  
  "C:\UsersC\admin\Desktop\Assignments-repository"  
diff.abund <- read.csv("diff_abund.csv")
str(diff.abund)
head(diff.abund)

#Make a volcano plot for Soybean vs. Soil
diff.abund$log10_pvalue <- -log10(diff.abund$p_CropSoybean)
diff.abund.label <- diff.abund[diff.abund$log10_pvalue > 30,]

#Make the plot
library(ggrepel)
ggplot() + 
  geom_point(data = diff.abund, aes(x = lfc_CropSoybean, y = log10_pvalue, color = diff_CropSoybean)) + 
  theme_classic() + 
  geom_text_repel(data = diff.abund.label, aes(x = lfc_CropSoybean, y = log10_pvalue, color = diff_CropSoybean, label = Label))

#Make the plot look nice with our colorblind friendly scheme and labeled x and y axes plus make the legend more easily understandable
volcano <- ggplot() + 
  geom_point(data = diff.abund, aes(x = lfc_CropSoybean, y = log10_pvalue, color = diff_CropSoybean)) + 
  geom_text_repel(data = diff.abund.label, aes(x = lfc_CropSoybean, y = log10_pvalue, color = diff_CropSoybean, label = Label)) + 
  scale_color_manual(values = cbbPalette, name = "Significant") +
  theme_classic() + 
  xlab("Log fold change Soil vs. Soybean") +
  ylab("-log10 p-value")
volcano

#We can use the same concept if we wanted to emphasize certain points as a different shape or color

volcano <- ggplot() + 
  geom_point(data = diff.abund, aes(x = lfc_CropSoybean, y = log10_pvalue)) + 
  geom_point(data = diff.abund.label, aes(x = lfc_CropSoybean, y = log10_pvalue), color = "red", shape = 17, size = 4) +
  geom_text_repel(data = diff.abund.label, aes(x = lfc_CropSoybean, y = log10_pvalue, label = Label), color = "red") + 
  theme_classic() + 
  xlab("Log fold change Soil vs. Soybean") +
  ylab("-log10 p-value")
volcano


