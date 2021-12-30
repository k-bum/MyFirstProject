library("dplyr")
library("ggplot2")

mpg <- as.data.frame(ggplot2 :: mpg)
View(mpg)

mpg %>% group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))
 
mpg %>% group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

mpg %>% group_by(manufacturer) %>% 
  filter(class == "compact") %>% 
  summarise(num = n()) %>% 
  arrange((desc(num)))

midwest <- as.data.frame(ggplot2 :: midwest)

midwest1 <- midwest %>% mutate(per_ch = 100 - ((popadults / poptotal) * 100))
View(midwest1)

midwest1 %>% group_by(county) %>%
  arrange(desc(per_ch)) %>% 
  select(state, county, per_ch) %>% 
  head(5)

midwest1 <- midwest1 %>% 
  mutate(grade = ifelse(per_ch >= 40, "large", ifelse(per_ch >= 30, "middle", "small")))
View(midwest1)

midwest2 <- midwest1 %>% mutate(per_asian = ((popasian / poptotal) * 100))%>% 
  arrange(per_asian) %>% 
  select(state, county, per_asian) %>% 
  head(10)
midwest2

#apply() : only for matrix
theMatrix <- matrix(1:9, nrow = 3)
theMatrix

#1 means row, 2 means column
apply(theMatrix, 1, sum) #sum of rows
apply(theMatrix, 2, sum) #sum of columns

rowSums(theMatrix)
colSums(theMatrix)

#lapply() : only for lists, returns result as lists
thelist <- list(A = matrix(1:9, 3), B = 1:15, C = matrix(1:4, 2), D = 2)
thelist
lapply(thelist, sum)
sapply(thelist, sum) #return as vector

thenames = c("Lee", "Choi", "Chang")
thenames
lapply(thenames, nchar) #nchar returns number of character
sapply(thenames, nchar) #returns as vector

#aggregate() 
data("diamonds", package = "ggplot2")
View(diamonds)

aggregate(price ~ cut, diamonds, mean) 
#group by cut, returns mean of price
aggregate(price ~ cut + color, diamonds, mean)
aggregate(price ~ color + cut, diamonds, mean)

head(aggregate(price ~ cut, diamonds, mean))
head(aggregate(carat ~ cut, diamonds, mean), n = 3)

aggregate(cbind(price, carat) ~ cut, diamonds, mean)
#group by cut, returns mean of price
#group by cut, returns mean of carat
#combines with column
aggregate(price ~ cut, diamonds, mean)
aggregate(carat ~ cut, diamonds, mean)
aggregate(cbind(price, carat) ~ cut + color, diamonds, mean)






