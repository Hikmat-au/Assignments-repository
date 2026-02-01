#Assignments on Introduction to R and Coding Challenge_1#

#1. Explain the following things about R and R studio#

#a. Where do you type code?
# We type code in R script in Rstudio.#

#b.Where is the output of the code?#
# The output of a code is in Console.#

#c.Where do plots show up?#
# Plots show up in lower right panel along with other tabs like files, packages and help in Rstudio.#

#d. o	What is a global environment?#
# Global environment is the area where R stores all the created objects, data frames, variables etc in any session.#

#e. How do you get help for a function through R studio?#
# To get help, we can use the function help() through R studio.#

#f. What is an R package? #
# Package is an extra code loaded into R to do calculations that do not come with the essential R functions. In other words, it contains more functions to manipulate R objects.#

#g. What is a function?#
# A function is a reusable block of code that performs a specific task when called. It takes inputs, process them, and return an output.#

#h. How do you find the installed and loaded packages?#
# Installed packages can be viewed using installed.packages(), while loaded packages can be seen using search(). These commands are written in the R Script and executed to view the results.#

#i. What is a working directory, and how do you find it?# 
# The working directory is the default folder where R reads and saves files.We can find it using the getwd() function.#

#j. What is a relative file path and how is it different than an absolute file path?# 
# A relative file path specifies a file location with respect to the current working directory. An absolute file path specifies the full location of a file starting from the root directory of the computer system.#

#2. Explain the steps to start a new R project connected to a GitHub repository.# 
# Open a new project from R studio-->start a new version control project-->clicjk Git to initiate a git repository-->go to github and create a new repository-->give a name and add a readme to the new repository-->click create, navigate repository and copy the link to the created repository-->Paste repository URL in R  and choose location in computer to save the repository-->click create repository and do commit and push under git in the Rstudio#

#3. Please explain the different data classes and how they are similar and different from each other. #
#Vector
#Dataframe
#Matrix
## In R, a vector is like a simple list of items that all have the same type, like numbers or characters. A matrix is like a table with rows and columns, but it still only allows one type of data, like only numbers. A data frame is also a table, but it’s more flexible because each column can be a different type, like one column with numbers and another with text. So, vectors are one-dimensional, while matrices and data frames are two-dimensional, and the main difference is that data frames can mix data types while matrices cannot.#

#4. Complete all tasks in an R script and push it to GitHub.#

#a. Create a vector named 'z' with the values 1 to 200.#
z<-c(1:200)
z #returns 1, 2, 3, 4 ......................,199, 200

#b. Print the mean and standard deviation of z on the console#
mean(z) #returns 100.5 in console
sd(z) #returns 57.87918 in console

#c. Create a logical vector named zlog that is 'TRUE' for z values greater than 30 and 'FALSE' otherwise.
z
zlog<-z>30
zlog # returns FALSE for 1-30 and TRUE for 31-200

#d. Make a dataframe with z and zlog as columns. Name the dataframe zdf#
zdf<-data.frame(z,zlog)
zdf #returns a dataframe having two column as z and zlog

#e. Change the column names in your new dataframe to equal “zvec” and “zlogic”#
colnames(zdf)<-c("zvec","zlogic")
zdf #returns column name  as zvec and zlogic for first and second column

#f. Make a new column in your dataframe equal to zvec squared (i.e., z2). Call the new column zsquared.#
zdf$zsquared<-zdf$zvec^2
zdf #returns a third column having squares of values of first column or zvec column

#g. Subset the dataframe with and without the subset() function to only include values of zsquared greater than 10 and less than 100 #
zdf_subset <- subset(zdf, zsquared > 10 & zsquared < 100) #using subset()
zdf_subset #returns new dataframe with zsquared values>10and<100
zdf_subset2 <- zdf[zdf$zsquared > 10 & zdf$zsquared < 100, ] #without using subset()
zdf_subset2

#h. Subset the zdf dataframe to only include the values on row 26#
zdf_row26 <- zdf[26, ]
zdf_row26 #returns all the value from 26th row 

#i. Subset the zdf dataframe to only include the values in the column zsquared in the 180th row.#
zdf_zsquared_180 <- zdf[180, "zsquared"]
zdf_zsquared_180 #returns the 180th row value from column zsquared

#5. Download the Tips.csv file from Canvas. Use the read.csv() function to read the data into R using a relative file path  and so that the missing values are properly coded. **Note the missing values are reported in the data as a period (i.e., “.”). How do you know the data were read correctly? #
getwd()
tips <- read.csv("TipsR.csv", na.strings = ".")
tips #from the console, I got NA for all the missed data which are reported as a period in csv file>#
#I used read.csv("Tips.csv", na.strings = ".") to load the data. The argument na.strings = "." tells R to treat "." as missing. I know the data were read correctly because missing values now appear as NA in R instead of ".", and the structure and values of other columns look correct.#

#6. Annotate your code, commit the changes and push it to your GitHub repository you created last class#
# performed all the task and committed and pushed to github#
