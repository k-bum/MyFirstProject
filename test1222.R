df <- read.csv("province.csv")
View(df)
names(df)
View(df)
str(df)
table(df$group)
order(df$name) #ㄱㄴㄷ순으로 정렬했을 때 행번호 출력
df[25, ]
df[order(df$name), ] #정렬된 순으로 출력
df[order(df$area, decreasing = TRUE), ]

df$group <- ifelse(df$area >= mean(df$area), "Group A", "Group B")
df$group

str(df)
df$population <- as.factor(df$population)
class(df$population)
df$population <- as.numeric(df$population)
df$population
df$density <- df$population / df$area
df$density
View(df)

count <- table(df$group)
count

barplot(count, main = "지역 면적 구분", xlab = "구분", ylab = "빈도도")
bp <- barplot(df$density, names.arg = df$name, main = "행정구역별 인구밀도", col = "lightcyan")
df$density <- round(df$population/ df$area, 1)
text(x= bp, y = df$density, labels = df$density, col = "red", cex = 1.7)

df2 <- read.csv("subway.csv")
View(df2)
str(df2)
library(dplyr)
df2_line1 <- df2 %>% filter(name == "1호선")
df2_line1
df2_201905 <- df2 %>% filter(date == 201905)
df2_201905
df2_201905_top5 <- df2 %>% filter(date == 201905) %>% select(name, passenger) %>% 
  arrange(passenger) %>% head(5)
df2_201905_top5
library(ggplot2)
ggplot(df2_201905_top5, aes(x = name, y = passenger)) + geom_point(color = "blue")

df2_passenger <- df2 %>% filter(date >= 201801 & date <= 201812)
df2_passenger

bs <- read.csv("SeoulBusStationCoordinate.csv")
View(bs)
str(bs)
names(bs) <- c("line_num", "line_name", "x", "y")
names(bs)
gangnam_bus <- bs %>% filter(x <= 127.027926 & x >= 127.023631 &
                               y <= 37.503323 & y >= 37.498659) %>% 
  select(line_num, line_name)
gangnam_bus
nrow(gangnam_bus)

bs_board <- read.csv("BUS_STATION_BOARDING_202105.csv")
str(bs_board)
names(bs_board) <- c("use_date", "line_num", "line_name", "id", "stat-name",
                     "in_board", "out_board", "reg_date")
str(bs_board)

tmp1 <- bs_board %>% filter(bs_board$id == gangnam_bus[1, 1]) %>% group_by(line_num, line_name) %>% 
  summarise(p1 = sum(in_board), p2 = sum(out_board))
tmp1
tmp1 <- bs_board %>% filter(bs_board$id == gangnam_bus[2, 1]) %>% group_by(line_num, line_name) %>% 
  summarise(p1 = sum(in_board), p2 = sum(out_board))
tmp1
tmp1 <- bs_board %>% filter(bs_board$id == gangnam_bus[3, 1]) %>% group_by(line_num, line_name) %>% 
  summarise(p1 = sum(in_board), p2 = sum(out_board))
tmp1
tmp1 <- bs_board %>% filter(bs_board$id == gangnam_bus[4, 1]) %>% group_by(line_num, line_name) %>% 
  summarise(p1 = sum(in_board), p2 = sum(out_board))
tmp1
str(tmp1)

for(i in 1 : nrow(gangnam_bus)) {
  tmp2 <- bs_board %>% filter(bs_board$id == gangnam_bus[i, 1]) %>% group_by(line_num, line_name) %>% 
    summarise(p1 = sum(in_board), p2 = sum(out_board))
  print(tmp2)
}

for(i in 1:21) {
  gangnam <- bs_board %>% filter(id == gangnam_bus[i, 1])
  gangnam_bs_board1 <- gangnam %>% group_by(line_num)
  print(dim(gangnam_bs_board1))
}
View(gangnam_bs_board1) 

for(i in 1:21) {
  gangnam <- bs_board %>% filter(id == gangnam_bus[i, 1])
  
  if(i == 1) {
    gangnam_bs_board2 <- gangnam %>% group_by(line_num)
  }
  
  else {
    tmp <- gangnam %>% group_by(line_num)
    gangnam_bs_board2 <- rbind(gangnam_bs_board2, tmp)
  }
  print(dim(gangnam_bs_board2))
}

library(openxlsx)
write.xlsx(x = gangnam_bs_board2, file = "total2.xlsx", rowNames = TRUE)

#파일명 지정하기 
for(i in 1:21){
  filename <- sprintf("%s.xlsx", gangnam_bus[i, 1])
  print(filename)
  filename <- paste("data", filename, sep = "", collapse = NULL)
  #여러 개의 문자를 합친다.
  print(filename)
}

for(i in 1:21) {
  tmp1 <- bs_board %>% filter(id == gangnam_bus[i, 1]) %>% group_by(line_num) %>% 
    summarise(p1 = sum(in_board), p2 = sum(out_board))
  filename <- sprintf("%s.xlsx", gangnam_bus[i, 1])
  base = './Data'
  filename <- paste(base, filename, sep = "/", collapse = NULL)
  write.xlsx(x = tmp1, file = filename, rowNames = T)
}














