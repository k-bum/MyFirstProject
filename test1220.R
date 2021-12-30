library(foreign)
raw_df <- read.spss("Koweps_hpc10_2015_beta1.sav", to.data.frame = TRUE)

df <- raw_df
View(df)
names(df)
df <- rename(df, sex = h10_g3, birth = h10_g4, marriage = h10_g10, religion = h10_g11,
             income = p1002_8aq1, code_job = h10_eco9, code_region = h10_reg7)
df$sex <- ifelse(df$sex == 1, "male", "female")
df$sex
table(df$sex)
qplot(df$sex)

df$income <- ifelse(df$income %in% c(0, 9999), NA, df$income)
df$income
summary(df$income)
mean(df$income, na.rm = T)
sex_income <- df %>% group_by(sex) %>% summarise(mean_income = mean(income, na.rm = T))
sex_income
sex_income2 <- df %>% filter(!is.na(income)) %>% group_by(sex) %>% summarise(mean_income = mean(income))
sex_income2
ggplot(sex_income, aes(x = sex, y = mean_income)) + geom_bar(stat = "identity", width = 0.5)
                              
summary(df$birth)
qplot(df$birth)
is.na(df$birth)
df$birth <- ifelse(df$birth == 9999, NA, df$birth)
table(is.na(df$birth))
df$age <- 2021 - df$birth + 1
summary(df$age)
age_income <- df %>% filter(!is.na(income) & !is.na(age)) %>% group_by(age) %>% summarise(mean_income = mean(income))
age_income
age_income$ageg <- ifelse(age_income$age < 30, "young", ifelse(age_income$age >= 30 & df$age < 60, "middle", "old"))
age_income
table(df$ageg)
qplot(df$ageg)
ggplot(age_income, aes(x = ageg, y = mean_income), fill = age) + geom_bar(stat = "identity", color = "blue")

df$ageg <- ifelse(df$age < 30, "young", ifelse(df$age >= 30 & df$age < 60, "middle", "old"))
df$ageg
ageg_income <- df %>% filter(!is.na(income)) %>% group_by(ageg) %>% 
  summarise(mean_income = mean(income))
ageg_income
ggplot(ageg_income, aes(x = reorder(ageg, mean_income), y = mean_income)) + geom_bar(stat = "identity")

group_income <- df %>% filter(!is.na(income)) %>% group_by(ageg, sex) %>% 
  summarise(mean_income = mean(income)) 
group_income
ggplot(group_income, aes(x = ageg, y = mean_income, group = sex, color = sex)) + 
  geom_line()
ggplot(group_income, aes(x = ageg, y = mean_income, fill = sex)) + geom_bar(stat = "identity")
group_income       
ggplot(group_income, aes(x = ageg, y = mean_income, fill = sex)) + 
  geom_bar(stat = "identity", position = "dodge")

class(df$code_job)
table(df$code_job)

library(readxl)
list_job <- readxl::read_excel("Koweps_Codebook.xlsx", col_names = T, sheet = 2)
list_job
head(list_job)
dim(list_job)

df <- left_join(df, list_job, id = "code_job")
df$job
View(df)
job_income_u <- df %>% filter(!is.na(income)) %>% group_by(job) %>% summarise(mean_income = mean(income)) %>% 
  arrange(desc(mean_income)) %>% head(10)
job_income_u
job_income_d <- df %>% filter(!is.na(income)) %>% group_by(job) %>% summarise(mean_income = mean(income)) %>% 
  arrange(mean_income) %>% head(10)
job_income_d
ggplot(job_income_u, aes(x = job, y = mean_income)) + 
  geom_bar(stat = "identity", width = 0.5, color = "blue", fill = "white")
ggplot(job_income_d, aes(x = job, y = mean_income)) + 
  geom_bar(stat = "identity", width = 0.5, color = "red", fill = "white")

job_male <- df %>% group_by(job) %>% filter(!is.na(job) & sex == "male") %>% summarise(n = n()) %>% 
  arrange(desc(n)) %>% head(10)
job_male
job_female <- df %>% group_by(job) %>% filter(!is.na(job) & sex == "female") %>% summarise(n = n()) %>% 
  arrange(desc(n)) %>% head(10)
job_female
ggplot(job_male, aes(x = reorder(job, n), y = n)) + geom_bar(stat = "identity")
ggplot(job_female, aes(x = reorder(job, n), y = n)) + geom_bar(stat = "identity")

table(df$religion)
table(df$marriage)
df$religion <- ifelse(df$religion == 1, "yes", "no")
table(df$religion)
df$marriage <- ifelse(df$marriage == 1, "marriage", "divorce")
table(df$marriage)
reli_marriage <- df %>% group_by(religion) %>% filter(marriage == "marriage") %>% 
  summarise(n = n())
reli_marriage
reli_divorce <- df %>% group_by(religion) %>% filter(marriage == "divorce") %>% 
  summarise(n = n())
reli_divorce
ggplot(reli_divorce, aes(x = religion, y = n)) + geom_bar(stat = "identity", width = 0.5)

religion_marriage <- df %>% group_by(religion, marriage) %>% summarise(n = n()) %>% 
  mutate(tot = sum(n)) %>% mutate(pct = round(n / tot, 3))
religion_marriage
ggplot(religion_marriage, aes(x = religion, y = pct, group = marriage, fill = marriage)) + 
  geom_bar(stat = "identity", position = "dodge") +
  scale_y_continuous(label = scales::percent)

table(df$ageg)
table(df$marriage)
ageg_marriage <- df %>% group_by(ageg, marriage) %>% summarise(n = n()) %>% 
  mutate(tot = sum(n)) %>% mutate(pct = round(n / tot, 3))
ageg_marriage
ggplot(ageg_marriage, aes(x = ageg, y = pct, group = marriage, fill = marriage)) + 
  geom_bar(stat = "identity", position = "dodge") +
  scale_y_continuous(label = scales::percent)

ageg_reli_marriage <- df %>% group_by(ageg, religion, marriage) %>% 
  summarise(n = n()) %>% filter(ageg == "middle" | ageg == "old") %>% 
  mutate(tot = sum(n)) %>% mutate(pct = round(n / tot * 100, 1)) %>% 
  filter(marriage == "divorce")
ageg_reli_marriage
ggplot(ageg_reli_marriage, aes(x = ageg, y = pct, group = religion, fill = religion)) +
         geom_bar(stat = "identity", position = "dodge")

table(df$code_region)
list_region <- data.frame(code_region = c(1:7), region = c("서울", "수도권", "부산/경남/울산", "대구/경북",
                                   "대전/충남", "강원/충북", "광주/전남/제주"))
list_region
df <- left_join(df, list_region)
table(df$code_region)
table(df$region)
table(df$ageg)

ageg_region <- df %>% group_by(ageg, region) %>% summarise(n = n()) %>% filter(ageg == "old") %>% 
  mutate(tot = sum(n)) %>% mutate(pct = round(n / tot * 100, 3))
ageg_region
ggplot(ageg_region, aes(x = region, y = pct)) + geom_bar(stat = "identity")
ggplot(ageg_region, aes(x = region, y = pct)) + geom_col()
