install.packages("readxl")
library("readxl")
exam <- read.csv("csv_exam.csv")
exam
head(exam)
head(exam, 3)
head(exam, n = 3)
tail(exam)
tail(exam, 4)
tail(exam, n = 4)
View(exam)
dim(exam) 
str(exam) 
summary(exam) 

install.packages("ggplot2")
library("ggplot2")
diamonds
class(diamonds)
x <- as.data.frame(diamonds)
class(x)
head(x, 15)
tail(x, 15)
View(x)
dim(x)
str(x)
help(diamonds)
summary(x)

install.packages("dplyr")
library("dplyr")
library("ggplot2")
mpg1 <- mpg
View(mpg)
mpg1
mpg1 <- rename(mpg1, city = cty)
mpg1 <- rename(mpg1, highway = hwy)
mpg1
View(mpg1)

df <- ggplot2 :: mpg
df
df$total <- (df$cty + df$hwy)/2
df
View(df)
help(df)
str(df)
summary(df)

df$total
summary(df$total)
df$test <- ifelse(df$total >= 20, "pass", "fail")
head(df, 20)
table(df$test)
library("ggplot2")
qplot(df$test)

df$grade <- ifelse(df$total >= 30, "A", ifelse(df$total >= 25, "B", ifelse(df$total >= 20, "C", "D")))
head(df, 20)
table(df$grade)
qplot(df$grade)

library("ggplot2")
library("dplyr")
midwest
midwest1 <- midwest
midwest1 <- rename(midwest, total = poptotal, asian = popasian)
midwest1
str(midwest1)
dim(midwest1)
midwest1$asianper = (midwest1$asian / midwest1$total)*100
midwest1$asianper
hist(midwest1$asianper)
summary(midwest1$asianper)

midwest1$test <- ifelse(midwest1$asianper >= 0.4872, "large", "small")
View(midwest1)
table(midwest1$test)
qplot(midwest1$test)

                        
                   