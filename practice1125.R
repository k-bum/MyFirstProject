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
df<- rename(df, sex = h10_g3, birth = h10_g4, marriage = h10_g10,
            religion = h10_g11, income = p1002_8aq1, code_job = h10_eco9,
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
  group_by(ageg, sex) %>% #ageg로 그룹짓고 다시 male과 female로 그룹짓는다.
  summarise(mean_income = mean(income))
ageg_sex_income
head(ageg_sex_income)

ggplot(data = ageg_sex_income, aes(x = ageg, y = mean_income, col = sex)) +
  geom_point()
ggplot(ageg_sex_income, aes(x = ageg, y = mean_income, group = sex, colour = sex)) + geom_line()

class(df$code_job)
table(df$code_job)
list_job <- readxl::read_excel("Koweps_Codebook.xlsx", col_names = T, sheet = 2)
View(list_job)
head(list_job)
dim(list_job)

df <- left_join(df, list_job, by = "code_job")
table(df$code_job)
table(df$job)

job_male <- df %>% filter(!is.na(job) & sex == "male") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)
job_male

ggplot(job_male, aes(x = reorder(job, n), y = n)) + 
  geom_col() +
  coord_flip()

job_female <- df %>% filter(!is.na(job) & sex == "female") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)
job_female

ggplot(job_female, aes(x = reorder(job, n), y = n)) + 
  geom_col() +
  coord_flip()
table(df$ageg)

job_income <- df %>%
  filter(!is.na(income)) %>% 
  group_by(job) %>% summarise(mean_income = mean(income))
job_income
job_income1 <- job_income %>% arrange(mean_income) %>% head(10)
job_income1
job_income2 <- job_income %>% arrange(desc(mean_income)) %>% head(10)
job_income2
ggplot(job_income1, aes(x = job, y = mean_income, fill = job)) + geom_bar(stat = 'identity')
ggplot(job_income2, aes(x = job, y = mean_income, fill = job)) + geom_bar(stat = 'identity')

class(df$religion)
table(df$religion)
df$religion <- ifelse(df$religion == 1, "yes", "no") 
table(df$religion)
qplot(df$religion)

class(df$marriage)
table(df$marriage)
df$group_marriage <- ifelse(df$marriage == 1, "marriage",
                            ifelse(df$marriage == 3, "divorce", NA))
table(df$group_marriage)
table(is.na(df$group_marriage))
qplot(df$group_marriage)

religion_marriage <- df %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(religion, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 1))
religion_marriage$pct
religion_marriage

#religion 별 divorce비율
divorce <- religion_marriage %>% 
  filter(group_marriage == "divorce") %>%
  select(religion, pct)
divorce

ggplot(divorce, aes(x = religion, y = pct)) + geom_col()

ageg_marriage <- df %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(ageg, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 1))
ageg_marriage

#ageg 중 young을 제외한 ageg별 divorce비율
ageg_divorce <- ageg_marriage %>% 
  filter(ageg != "young" & group_marriage == "divorce") %>% 
  select(ageg, pct)
ageg_divorce
View(ageg_divorce)
ggplot(ageg_divorce, aes(x = ageg, y = pct)) + geom_col()

ageg_religion_marriage <- df %>% 
  filter(!is.na(group_marriage) & ageg != "young") %>% 
  group_by(ageg, religion, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 1))
ageg_religion_marriage

#ageg별 religion여부에 따른 divorce비율
df_divorce <- ageg_religion_marriage %>% 
  filter(group_marriage == "divorce") %>% 
  select(ageg, religion, pct)
df_divorce
ggplot(df_divorce, aes(x = ageg, y = pct, fill = religion)) +
  geom_col(position = "dodge")

class(df$code_region)
table(df$code_region)

list_region <- data.frame(code_region = c(1:7), 
                          region = c("서울", "수도권", "경남/부산/울산",
                                     "대구/경북", "대전/충남", "강원/충북",
                                     "광주/전남/전북/제주"))
View(list_region)

df <- left_join(df, list_region, id = "code_region")
#code_region이라는 이름으로 list_region과 df의 code_region으로 합친다
table(df$code_region)
table(df$region)
df %>% select(code_region, region) %>% head()

region_ageg <- df %>% group_by(region, ageg) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 1))
View(region_ageg)
head(region_ageg)
ggplot(region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() 
  