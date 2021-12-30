#ggplot2 패키지 그래프의 구성
#ggplot()
#geom() : 그래프의 형태를 결정
#theme() : 그래프의 디자인을 결정

##ggplot2를 이용한 시각화
#ggplot 사용할 데이터를 x축, y축, color등의 그래프 요소에 매핑
#aes() 함수 사용
#geom() 다양한 그래프 중 어떤 그래프를 그릴지 결정
install.packages("ggthemes")
library("ggplot2")
library("ggthemes")
DF <- read.csv("example_studentlist.csv")
DF
g1 <- ggplot(DF, aes(x = height, y = weight, colour = bloodtype))
#DF를 이용해 x축에는 키, y축에슨 몸무게, 혈액형에 따라 다른 색 설정
g1 + geom_point() #산점도
g1 + geom_line() #꺾은선 그래프
g1 + geom_line() + geom_point() 
g1 + geom_line(size = 5) + geom_point(size = 10) #사이즈 지정 가능

#바 그래프
ggplot(DF, aes(x = bloodtype)) + geom_bar()
ggplot(DF, aes(x = bloodtype, fill = sex)) + geom_bar()
#성별에 따라 다른 색 지정
ggplot(DF, aes(x = bloodtype, fill = sex)) + geom_bar(position = "dodge")
ggplot(DF, aes(x = bloodtype, fill = sex)) + geom_bar(position = "dodge", width = 0.3)
#그래프의 폭을 지정 가능

heightByblo <- tapply(DF$height, DF$bloodtype, mean)
#혈액형 기준으로 분류하고 키의 평균값을 저장
heightByblo
DF2 <- as.data.frame(heightByblo)
DF2
rownames(DF2)
DF2$bloodtype <- rownames(DF2)
#DF2에 bloodtype이라는 변수를 만들고 DF2의 rowname을 저장함.
DF2$bloodtype
DF2
rownames(DF2) <- NULL #DF2의 rowname 초기화
DF2
ggplot(DF2, aes(x = bloodtype, y = heightByblo, fill = bloodtype)) +
  geom_bar(stat = "identity") + scale_fill_brewer()
ggplot(DF2, aes(x = bloodtype, y = heightByblo, fill = bloodtype)) +
  geom_bar(stat = "identity") + scale_fill_manual(values = c("#FFFFFF", "#FFCC00", "#FF6600", "#FF3300"))
#scale_fill_manual를 통해서 사용자가 직접 색깔을 지정 가능

#산점도 그리기
DF <- read.csv("example_studentlist.csv")
DF
g1 <- ggplot(DF, aes(x = weight, y = height))
g1 + geom_point()
g1 + geom_point(aes(colour = sex), size = 7)
g1 + geom_point(aes(colour = sex, shape = sex), size = 7)
g1 + geom_point(aes(colour = sex, shape = bloodtype), size = 7)
#색깔로 성별을 구분하고 모양으로 혈액형을 구분한다. size는 7

#히스토그램
library("dplyr")
ggplot(data = diamonds)
ggplot(data = diamonds) + geom_histogram(aes(x = carat))
ggplot(data = diamonds, aes(x = carat)) + geom_histogram()
ggplot(data = diamonds) + geom_density(aes(x = carat), fill = "grey50")
ggplot(data = diamonds) + geom_density(aes(x = carat), fill = "blue")

ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point()
ggplot(data = diamonds) + geom_point(aes(x = carat, y = price))

g1 <- ggplot(data = diamonds, aes(x = carat, y = price))
g2 <- geom_point(aes(colour = color))
#앞의 color는 옵션의 이름이고, 뒤의 color는 diamonds dataset의 열의 이름
g1 + g2

g3 <- ggplot(data = diamonds)
g4 <- geom_point(aes(x = carat, y = price, color = color))
g3 + g4

ggplot(diamonds, aes(y = carat, x = 1)) + geom_boxplot()
ggplot(diamonds, aes(y = carat, x = cut)) + geom_boxplot()
ggplot(diamonds, aes(y = carat, x = cut)) + geom_violin()
ggplot(diamonds, aes(y = carat, x = cut)) + geom_point() + geom_violin()
ggplot(diamonds, aes(y = carat, x = 1)) + geom_violin() + geom_point()

#꺾은선 그래프
economics
View(economics) #시계열 자료
names(economics)
ggplot(economics, aes(x = date, y = pop)) + geom_line()

install.packages("lubridate")
library("lubridate")
economics$year <- year(economics$date)
economics$month <- month(economics$date, label = TRUE)
View(economics)
names(economics)

econ2000 <- economics[which(economics$year >= 2000),]
View(econ2000)
library("scales")

g1 <- ggplot(econ2000, aes(x = month, y = pop))
g2 <- geom_line(aes(color = factor(year), group = year))
g1 + g2
g3 <- scale_color_discrete(name = "Year")
g1 + g2 + g3
g4 <- scale_y_continuous(labels = scales::comma)
g = g1 + g2 + g3 + g4
g
g + labs(title = "Population Growth", x = "Month", y = "Population")

#theme 그래프 전체의 느낌에 영향을 주는 요소
library(ggthemes)
g <- ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point(aes(color = color))
g
g + theme_economist() + scale_color_economist()
g + theme_excel() + scale_color_excel()
g + theme_tufte()
g + theme_wsj()



