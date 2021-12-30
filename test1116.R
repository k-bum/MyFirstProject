library(ggplot2)
library(dplyr)
library(ggthemes)
#그래프를 이미지로 저장
#export -> save as image, save as pdf, copy clipboard

#산점도
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + 
  xlim(3 ,6) + ylim(10, 30)

ggplot(mpg, aes(x = cty, y = hwy)) + geom_point(size = 2, color = "red")
View(midwest)
dim(midwest)
DF <- midwest %>% filter(poptotal <= 500000 & popasian <= 10000)
dim(DF)
View(DF)
library(scales)
library(ggplot2)
library(dplyr)
library(reshape2)
library(ggthemes)

ggplot(DF, aes(x = poptotal, y = popasian, options(scipen = 99))) + 
  geom_point(size = 2, color = "grey44")
ggplot(DF, aes(x = poptotal, y = popasian, options(scipen = 0))) + 
  geom_point(size = 3, color = "skyblue") + 
  scale_y_continuous(labels = comma)

#실습
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()
ggplot(data = midwest, aes(x = poptotal, y = popasian)) + 
  geom_point() + xlim(0, 500000) + ylim(0, 10000)
options(scipen = 99)
options(scipen = 0)

mpg <- as.data.frame(ggplot2::mpg)
df_mpg <- mpg %>% group_by(drv) %>% summarise(mean_hwy = mean(hwy))
df_mpg
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) +
  geom_col()
ggplot(data = df_mpg, aes(x = reorder(drv, mean_hwy), y = mean_hwy)) +
  geom_col()

#y축 지정하지 않으면 count(빈도)가 설정
ggplot(data = mpg, aes(x = drv)) + geom_bar()
ggplot(data = mpg, aes(x = hwy)) + geom_bar()

#실습
mpg <- as.data.frame(mpg)
str(mpg)
library(dplyr)
df_mpg <- mpg %>% filter(class == "suv") %>% group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% arrange(desc(mean_cty)) %>% head(5)
df_mpg
str(df_mpg)
ggplot(df_mpg, aes(x =  manufacturer, y = mean_cty)) + geom_bar(stat = "identity")
ggplot(mpg, aes(x = class)) + geom_bar()

mpg <- as.data.frame(ggplot2::mpg)
View(mpg)
df_mpg <- mpg %>% group_by(manufacturer) %>% filter(class == "suv") %>% summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))%>% 
  head(5)
df_mpg
ggplot(df_mpg, aes(x = reorder(manufacturer, -mean_cty), y = mean_cty)) + geom_col()
ggplot(data = mpg, aes(x = class)) + geom_bar(color = "blue", fill = "white")

economics
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()
#상자 밖 점 : 극단치

df_mpg <- mpg %>% filter(class == "compact" | class == "subcompact" | class == "suv")
df_mpg
ggplot(df_mpg, aes(x = class, y = cty)) + geom_boxplot()

class_mpg <- mpg %>% filter(class %in% c("compact", "subcompact", "suv"))
class_mpg
ggplot(data = class_mpg, aes(x = class, y = cty)) + geom_boxplot()
