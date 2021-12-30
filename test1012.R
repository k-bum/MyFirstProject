#data preprocessing
library("dplyr")
exam <- read.csv("csv_exam.csv")
exam

exam %>% filter(class == 1)
exam %>% filter(class != 1)
exam %>% filter(class != 3)

exam %>% filter(math >= 50)
exam %>% filter(english > 80)

exam %>% filter(class == 1 & math >= 50)
exam %>% filter(class == 2 & english >= 80)

exam %>% filter(math >=90 | english >= 90)
exam %>% filter(science < 50 | english < 90)

exam %>% filter(class == 1 | class == 2 | class == 3)
exam %>% filter(class %in% c(1, 3, 5))

class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)

mean(class1$math)
mean(class2$math)

5^2
5**2
5 / 2
5 %/% 2
5 %% 2

library("ggplot2")
mpg1 <- mpg
mpg1
a1 <- mpg1 %>% filter(displ <= 4)
a2 <- mpg1 %>% filter(displ >= 5)
a1
a2 
mean(a1$hwy)
mean(a2$hwy)
ifelse(mean(a1$hwy) >= mean(a2$hwy), "4 is better", "5 is better")

audi <- mpg1 %>% filter(manufacturer == "audi")
audi 
toyota <- mpg1 %>% filter(manufacturer == "toyota")
toyota
mean(audi$cty)
mean(toyota$cty)
ifelse(mean(audi$cty) >= mean(toyota$cty), "audi is better", "toyota is better")

#select 
exam
exam_math <- exam %>% select(math)
exam_english <- exam %>% select(english)
exam %>% select(class, math, english)
exam %>% select(-math)
exam %>% select(-math, -english)

exam %>% filter(class == 1) %>% select(math)
exam %>% select(id, math) %>% head()

c <- mpg1 %>% select(class, cty)
head(c, n = 3)
View(c)
c1 <- c %>% filter(class == "suv")
View(c1)
c2 <- c %>% filter(class == "compact")
View(c2)
m1 <- mean(c1$cty)
m1
m2 <- mean(c2$cty)
m2
ifelse(m1 >= m2, "suv is better", "compact is better")

#arrange 
exam
exam %>% arrange(math)
exam %>% arrange(desc(math)) 
exam %>% arrange(class, math) 

str(mpg)
audi <- mpg %>% filter(manufacturer == "audi") %>% select(hwy)
a_arrange <- audi %>% arrange(hwy)
a_arrange
head(a_arrange, n = 5)









