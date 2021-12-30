#산점도 plot
Nile #시계열 데이터
str(Nile)
plot(Nile, main = "Flow Changes in the Nile", xlab = "year", ylab = "Flow")
#main은 전체 그래프의 타이틀, xlab은 x(설명변수)축의 이름, y(반응변수)축의 이름을 나타냄.
plot(Nile, type = "p", main = "Flow Changes in the Nile", xlab = "year", ylab = "Flow")


DF <- read.csv("example_studentlist.csv")
View(DF)
names(DF)
str(DF)
DF
DF$age
plot(DF$age)
plot(DF$height, DF$weight) #첫번째 인자는 x축 두번째 인자는 y축
plot(DF$weight ~ DF$height) # ~앞이 y축 뒤가 x축
DF$sex <- as.factor(DF$sex) 
#plot함수의 변수는 반드시 수치형이거나 명목형이므로 실행이 되지 않는 경우
#as.factor를 이용해서 변환한 후 사용한다. 
plot(DF$height, DF$sex)
DF2 <- data.frame(DF$height, DF$weight)
DF2
plot(DF2)
DF3 <- cbind(DF2, DF$age)
#DF$age를 cbind를 이용하여 합친다. 
DF3
plot(DF3) #plot함수는 3개의 변수를 인자로 사용해도 변수 간의 관계를 모두 보여줌.

DF$sex
DF$sex <- ifelse(DF$sex == "남자", 1, 2)
DF$sex
plot(DF$weight ~ DF$height, pch = as.integer(DF$sex))
legend("topleft", c("man", "woman"), pch = DF$sex) #범례를 붙이는 것이 가능함.

plot(DF$weight ~ DF$height, ann = F)
title(main = "Kyung Hee University Student's Height and Weight Relationship")
title(xlab = "height")
title(ylab = "weight")
grid()

weightMean = mean(DF$height)
weightMean
FreqBlood = table(DF$bloodtype)
FreqBlood
barplot(FreqBlood)
title(main = "Blood type frequency")
title(xlab = "blood type")
title(ylab = "frequency")
Height = tapply(DF$height, DF$bloodtype, mean)
#혈액형 별로 키의 평균을 구해서 나타냄.
Height
barplot(Height, ylim = c(0, 200)) #ylim은 y축의 limit을 나타냄.

boxplot(DF$height)
boxplot(DF$height ~ DF$bloodtype) #혈액형 별로 키의 boxplot을 출력.

hist(DF$height)
hist(DF$height, breaks = 5) #breaks는 구간을 나타냄.
hist(DF$height, breaks = 10)
hist(DF$height, breaks = 10, prob = T)
hist(DF$height, breaks = 20)
hist(DF$height, breaks = 10, prob = T) #밀도로 나타난다(prob = T)
DiffPoint <- c(min(DF$height), 165, 170, 180, 185, 190)
#구간을 직접 설정해서 벡터로 저장하고 히스토그램을 그린다. 
hist(DF$height, breaks = DiffPoint)

x1 <- seq(1, 100, 1) #1부터 100까지 1간격으로 숫자를 생성
x1
y1 <- dbinom(x1, 100, 0.25) #이항분포
y1
#타입에 따라 달라진다.
plot(x1, y1, type = "p") #point
plot(x1, y1, type = "l") #line
plot(x1, y1, type = "h") #histogram
plot(x1, y1, type = "s")




