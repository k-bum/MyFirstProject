library(dplyr)

bs <- read.csv("SeoulBusStationCoordinate.csv")
names(bs)
names(bs) <- c('id', 'name_bs', 'x', 'y')
names(bs)
summary(bs)
head(bs)
dim(bs)
class(bs$x)
class(bs$y)
View(bs)
gangnam_bs <- bs %>% filter(y <= 37.503323 & y >= 37.498659 &
                              x <= 127.027926 & x >= 127.023631)
dim(gangnam_bs)
View(gangnam_bs)
gangnam_bs[1, 1]
gangnam_bs[2 ,1]
gangnam_bs[21, 1]

pass <- read.csv("BUS_STATION_BOARDING_202105.csv")
names(pass)
names(pass) <- c('date', 'num_line', 'name_line', 'id', 'name_bs', 'in_bor', 'out_bor', 'reg')
names(pass)
dim(pass)

tmp1 <- pass %>% filter(id == gangnam_bs[1, 1]) %>% group_by(num_line, name_line) %>% 
  summarise(p1 = sum(in_bor), p2 = sum(out_bor))
View(tmp1)
print(tmp1)

for(i in 1 : 21) {
 tmp2 <- pass %>% filter(id == gangnam_bs[i, 1]) %>% group_by(num_line, name_line) %>% 
   summarise(p1 = sum(in_bor), p2 = sum(out_bor))
 print(tmp2)
}

for(i in 1 : 21) {
  gangnam <- pass %>% filter(id == gangnam_bs[i, 1])
  gangnam_pass1 <- gangnam %>% group_by(num_line)
  print(dim(gangnam_pass1))
}
View(gangnam_pass1)

for(i in 1:21) {
  gangnam <- pass %>% filter(id == gangnam_bs[i, 1]) 
  
  if(i == 0) {
    gangnam_pass <- gangnam %>% group_by(num_line)
  }
  
  else {
    tmp <- gangnam %>% group_by(num_line)
    gangnam_pass <- rbind(gangnam_pass, tmp)
  }
  print(dim(gangnam_pass))
}
View(gangnam_pass)

install.packages("openxlsx")
library(openxlsx)
write.xlsx(x = gangnam_pass, file = 'total.xlsx', row.names = T)

for(i in 1 : 21) {
  filename <- sprintf("%s.xlsx", gangnam_bs[i, 1])
  print(filename)
  filename <- paste('data', filename, sep = "/", collapse= NULL)
  print(filename)
}

















