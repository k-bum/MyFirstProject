install.packages("data.table")
library(data.table)
DF = fread("example_studentlist.csv", data.table = F)
#csv파일을 읽는 함수 : fread()
DF
dim(DF)
names(DF)
mean(DF$height, na.rm = T)
#DF의 height변수의 평균을 구한다.
sort(DF$height)
#DF$height을 오름차순으로 정리해서 출력한다. 
median(DF$height, na.rm = T)
#중앙값
range(DF$height, na.rm = T) 
#가장 큰 값과 가장 작은 값을 보여준다. (숫자의 범위)
quantile(DF$height, na.rm = T) #사분위수
IQR(DF$height, na.rm = T) 
#25%에 해당하는 값과 75%에 해당하는 값의 차
# 176.1 - 165.3 = 10.8
summary(DF$height, na.rm = T)
#요약통계량 출력
boxplot(DF$height)
#수염상자 그림으로 보여준다. 
cor(DF$height, DF$weight) #공분산(상호관계가 얼마나 밀접한지)
#일반적으로 0.7이상일 때 상관관계가 있다고 해석
#양수인 경우에 양의 상관관게, 음수인 경우에 음의 상관관계

DF2 = DF
DF2[2, 7] = NA
DF2[4, 8] = NA
DF2
cor(DF2$height, DF2$weight)
cor(DF2$height, DF2$weight, use = "complete.obs")
#use = "complete.obs" NA값 처리
var(DF2$height, na.rm = T) #분산
sd(DF2$height, na.rm = T) #표준편차

DF <- read.csv("example_salary.csv", stringsAsFactors = T, na = "-")
DF
dim(DF)
names(DF)
head(DF, 5)

colnames(DF)
colnames(DF) <- c("Age", "Salary", "SpecialSalary", "WorkingTime",
                  "NumberOfWorker", "Career", "Sex")
names(DF)
str(DF)
Mean <- mean(DF$Salary, na.rm = T)
Mean
Mid <- median(DF$Salary, na.rm = T)
Mid
Range <- range(DF$Salary, na.rm = T)
#가장 큰 값과 작은 값을 출력
Range
w <- which(DF$Salary == 4064286)
#salary가 4064286과 같은 데이터의 행 번호를 저장한다.
w
DF[w,] #w행의 모든 정보를 출력
w <- which(DF$Salary <= 4064286)
w
DF[w,]
library("dplyr")
DF %>% filter(DF$Salary == 4064286)
Qnt <- quantile(DF$Salary, na.rm = T)
Qnt
Salary <- list(평균월급 = Mean, 중앙값월급 = Mid, 월급범위 = Range,
                월급사분위 = Qnt)
Salary

DF <- read.csv("example_salary.csv", stringsAsFactors = F, na = "-")
head(DF, 5)
colnames(DF)
colnames(DF) <- c("age", "salary", "specialsalary", "workingTime",
                  "numberOfWorker", "career", "sex")
temp <- tapply(DF$salary, DF$sex, mean, na.rm = T)
#sex를 기준으로 salary의 mean을 구한다.
temp

install.packages("reshape2")
library("reshape2")
library("ggplot2")
melt <- melt(temp)
melt
colnames(melt) <- c("Sex", "Salary")
melt
ggplot(melt, aes(x = Sex, y = Salary, fill = Sex)) + 
         geom_bar(stat = "identity") #막대그래프로 보여준다.

tapply(DF$salary, DF$sex, sd, na.rm = T)
#sex를 기준으로 salary의 표준편차를 구한다.
tapply(DF$salary, DF$sex, range, na.rm = T)
#sex를 기준으로 salary의 최댓값과 최솟값을 구한다.
temp2 <- tapply(DF$salary, DF$career, mean, na.rm = T)
temp2
melt2 <- melt(temp2)
melt2
colnames(melt2) <- c("Career", "Salary")
melt2
ggplot(melt2, aes(x = Career, y = Salary, group = 1)) + 
         geom_line(colour = "skyblue2", size = 4) + 
         coord_polar() + ylim(0, max(melt2$Salary))
#size는 선의 굵기를 결정

tapply(DF$salary, DF$career, sd, na.rm = T)
tapply(DF$salary, DF$career, range, na.rm = T)

#salary가 조건을 만족하는 모든 행을 w에 저장
w <- which(DF$salary > 3000000)
w
DF[w, ] #데이터프레임은 반드시 행과 열을 모두 입력해야한다.
#salary가 조건을 만족하는 행의 모든 정보를 list에 저장
a1 <- DF[which(DF$salary == 1172399), ]
a1
a2 <- DF[which(DF$salary == 1685204), ]
a2
a3 <- DF[which(DF$salary == 1117605), ]
a3
a4 <- DF[which(DF$salary == 1245540), ]
a4
a5 <- DF[which(DF$salary == 1548036), ]
a5
list <- list(a1, a2, a3, a4, a5)
list

#outlier 찾기와 제거하기 
DF <- read.csv("example_cancer.csv", stringsAsFactors = F, na = "기록없음")
View(DF)
mean(DF$age)
summary(DF$age)
boxplot(DF$age)
grid() #차트에 격자무늬를 표시
quantile(DF$age) #72 - 55 = 17
distIQR <- IQR(DF$age, na.rm = T) #사분위범위 저장
distIQR
#이상치 처리
posIQR <- quantile(DF$age, probs = c(0.25, 0.75), na.rm = T)
#하위 25% 값과 상위 75% 값을 1사분위와 3사분위로 나누어서 저장
posIQR
DownWhisker <- posIQR[[1]] - distIQR*1.5
#하한 사분위수에서 사분위 범위의 1.5배를 뺀 값
UpWhisker <- posIQR[[2]] + distIQR*1.5
#상한 사분위수에 사분위 범위의 1.5배를 더한 값
DownWhisker; UpWhisker
outlier <- subset(DF, subset = (DF$age < DownWhisker | DF$age > UpWhisker))
#DowbWhiskter보다 작거나 UpWhisker보다 큰 값을 이상치로 저장
outlier
dim(outlier)
