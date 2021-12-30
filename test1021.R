#data.table
install.packages("data.table")
library("data.table")

theDF <- data.frame(A = 1:10, B = letters[1:10], C = LETTERS[11:20], 
                    D = rep(c("one", "two", "three"), length.out = 10))
theDT <- data.table(A = 1:10, B = letters[1:10], C = LETTERS[11:20], 
                    D = rep(c("one", "two", "three"), length.out = 10))
theDF
theDT

df <- data.frame(sex = c("M", "F", NA, "M", "F"), score = c(5, 4, 3, 4, NA))
df
is.na(df)
table(is.na(df))
table(is.na(df$sex))
table(is.na(df$score))

mean(df$score)
sum(df$score)

library("dplyr")
df
df %>% filter(is.na(score)) 
df %>% filter(!is.na(score)) 
df_nomiss <- df %>% filter(!is.na(score))
df_nomiss
mean(df_nomiss$score)
sum(df_nomiss$score)

df_nomiss <- df %>% filter(is.na(score) & !is.na(sex))
df_nomiss
df_nomiss <- df %>% filter(!is.na(score) & is.na(sex))
df_nomiss
df
df_nomiss2 <- na.omit(df) 
df_nomiss2

mean(df$score, na.rm = TRUE) 
sum(df$score, na.rm = TRUE)

exam <- read.csv("csv_exam.csv")
exam
exam[c(3, 8, 15), "math"] <- NA
exam
mean(exam$math)

mean(exam$math, na.rm = T)
exam$math <- ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))
exam
mean(exam$math) 

library("ggplot2")
mpg1 <- as.data.frame(ggplot2 :: mpg)
View(mpg1)
mpg1[c(65, 124, 131, 153, 212), "hwy"] <- NA

table(is.na(mpg1$hwy))
table(is.na(mpg1$drv))

mpg1 %>% filter(!is.na(hwy)) %>% 
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) 
mpg1

#outlier
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1), score = c(5, 4, 3, 4, 2, 6))
outlier
table(outlier$sex)
table(outlier$score)
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier
outlier %>% filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))
mpg %>% group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = TRUE))

mpg <- as.data.frame(ggplot2 :: mpg)
mpg[c(10, 14, 58, 93), "drv"] <- "k"
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)

table(mpg$drv)
mpg$drv %>% ifelse(mpg$drv %in% c("4", "f", "r"), mpg$drv, NA)
mpg %>% ifelse(mpg$drv == "k", NA, mpg$drv)
boxplot(mpg$cty)
boxplot(mpg$cty)$stats
mpg$cty %>% ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)
boxplot(mpg$cty)
mpg %>% group_by(drv) %>% summarise(mean_cty = mean(cty, na.rm = T))

