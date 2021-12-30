library("dplyr")
library("ggplot2")

exam <- read.csv("csv_exam.csv")
exam$total <- exam$math + exam$english + exam$science
exam
exam1 <- exam %>% mutate(total = math + english + science)
exam1
exam1 <- exam %>% mutate(total = math + english + science, mean = (math + english + science)/3) %>% 
  arrange(total) %>% head(6)
exam1
exam1 %>% mutate(test =  ifelse(science >= 60, "pass", "fail")) %>% 
  head(4)
exam1 %>% mutate(total =  math + english + science) %>% arrange(total) %>% 
  head(6)
exam1

mpg_new <- as.data.frame(ggplot2 :: mpg)
mpg_new <- mpg %>% mutate(total = cty + hwy) %>% 
  mutate(avg = total / 2) %>% 
  arrange(desc(avg)) %>% head(3)
View(mpg_new)

help(summarise)
exam %>% summarise(mean_math = mean(math))
exam
exam %>% group_by(class) %>% summarise(mean_math = mean(math))

exam %>% group_by(class) %>% summarise(mean_math = mean(math),
                                       sum_math = sum(math),
                                       median_math = median(math),
                                       n = n())
mpg %>% group_by(manufacturer, drv) %>% summarise(mean_cty = mean(cty)) %>% 
  head() 

mpg2 <- as.data.frame(mpg)
View(mpg2)
mpg2 <- mpg %>% group_by(manufacturer) %>%
  filter(class == "suv") %>% 
  mutate(total_mean = (cty + hwy)/2) %>% 
  summarise(mean = mean(total_mean)) %>% 
  arrange(desc(mean)) %>% 
  head(5)
View(mpg2)

mpg3 <- as.data.frame(mpg)
mpg3 %>% group_by(class) %>% summarise(class_mean = mean(cty)) %>% 
  arrange(desc(class_mean))
mpg3 %>% group_by(manufacturer) %>% summarise(manu_mean = mean(hwy)) %>%  
  arrange(desc(manu_mean)) %>% head(3)
mpg3 %>% group_by(manufacturer) %>% 
  filter(class == "compact") %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))

test1 <- data.frame(id = c(1, 2, 3, 4, 5), midterm = c(60, 80, 70, 90, 85))
test1
test2 <- data.frame(id = c(1, 2, 3, 4, 6), finalterm = c(50, 80, 90, 100, 70))
test2
total1 <- left_join(test1, test2, by = "id")

total1 
total2 <- left_join(test2, test1, by = "id")
total2

name <- data.frame(class = c(1, 2, 3, 4, 5), teacher = c("kim", " lee", "park", "choi", "jung"))
name
exam_new <- left_join(exam, name, by = "class")
exam_new

group_a <- data.frame(id = c(1, 2, 3, 4, 5), test = c(60, 80, 70, 90, 85))
group_a
group_b <- data.frame(id = c(6, 7, 8, 9, 10), test = c(73, 65, 92, 54, 45))
group_b
group_all <- bind_rows(group_a, group_b)
group_all

group_a <- data.frame(id = c(1, 2, 3, 4, 5), test_a = c(60, 80, 70, 90, 85))
group_a
group_b <- data.frame(id = c(6, 7, 8, 9, 10), test_b = c(73, 65, 92, 54, 45))
group_b
group_all <- bind_rows(group_a, group_b)
group_all

View(mpg)
mpg4 <- as.data.frame(mpg)
price_fl <- data.frame(fl = c("c", "d", "e", "p", "r"), price = c(2.35, 2.38, 2.11, 2.76, 2.22), stringsAsFactors =  F)
type_fl <- data.frame(fl = c("c", "d", "e", "p", "r"), 
                         type= c("CNG", "disel", "ethanol E85", "premium", "regular"))
fuel <- left_join(type_fl, price_fl, by = "fl")
fuel
mpg4 <- left_join(mpg4, price_fl, by = "fl")
View(mpg4)
mpg4 %>% select(model, fl, price_fl) %>% head(5)




