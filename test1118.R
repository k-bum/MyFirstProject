library(ggplot2)
library(dplyr)
library(ggthemes)
install.packages("foreign")
library(foreign)
library(readxl)

raw_df <- read.spss("Koweps_hpc10_2015_beta1.sav", to.data.frame = TRUE)

df <- raw_df
head(df)
tail(df)
View(df)
dim(df)
str(df)
summary(df)

names(df)
df<- rename(df, sex = h10_g3, birth = h10_g4, marraige = h10_g10,
            religion = h10_g10, income = p1002_8aq1, code_job = h10_eco9,
            code_region = h10_reg7)
class(df$sex)
table(df$sex)
table(is.na(df$sex))
df$sex <- ifelse(df$sex == 1, "male", "female")
table(df$sex)
qplot(df$sex)

class(df$income)
summary(df$income)
qplot(df$income)
table(is.na(df$income))
df$income <- ifelse(df$income %in% c(0, 9999), NA, df$income)
summary(df$income)
sex_income <- df %>% filter(!is.na(income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))
sex_income

summary(df$birth)
qplot(df$birth)
table(is.na(df$birth))
df$birth <- ifelse(df$birth == 9999, NA, df$birth)
table(is.na(df$birth))
df$age <- 2021 - df$birth + 1
summary(df$age)
qplot(df$age)

age_income <- df %>% filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))
head(age_income)

df$ageg <- ifelse(df$age < 30, "young", ifelse(df$age <= 59, "middle", "old"))
qplot(df$ageg)

ageg_income <- df %>% filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income = mean(income))
ageg_income
ageg_sex_income <- df %>% filter(!is.na(income)) %>% 
  group_by(ageg, sex) %>% 
  summarise(mean_income = mean(income))
ageg_sex_income
ggplot(ageg_sex_income, aes(x = ageg, y = mean_income, group = sex, colour = sex)) + geom_line()




