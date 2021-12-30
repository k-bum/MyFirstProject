library(dplyr)
df <- read.csv("province.csv")
View(df)
names(df)
class(df$name)
class(df$population)
class(df$area)
df
order(df$name) #순서를 지정하고 데이터를 행마다 조회 가능
df[order(df$name),]
df[25,]

mean(df$area)
df$group <- ifelse(df$area >= mean(df$area), "Group A", "Group B")
df$group
df$population <- as.integer(df$population)
df$density <- df$population / df$area
df$density

df2 <- read.csv("subway.csv")
View(df2)
names(df2)
class(df2$name)
class(df2$date)
class(df2$passenger)

df2_1호선 <- df2 %>% filter(name == "1호선")
df2_1호선
df2_201905 <- df2 %>% filter(date == 201905) %>% select(date, passenger)
df2_201905
df2_201905_top5 <- df2_201905 %>% arrange(passenger) %>% head(5)
df2_201905_top5
df2_2018 <- df2 %>% filter(date >= 201801 & date <= 201812) 
df2_2018
