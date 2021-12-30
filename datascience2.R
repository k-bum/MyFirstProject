install.packages("corrgram")
install.packages("corrgram", dependencies = T, 
                 INSTALL_opts = "--no-lock")
install.packages("Rcpp", dependencies = T, 
                 INSTALL_opts = '--no-lock')
library(corrgram)
install.packages("mclust")
library(mclust)
library("ggplot2")
install.packages("cluster")
library(cluster)

#Clustering Analysis
#1. 유클리디안 거리
#유클리드 거리(Euclidean distance)는 두 점 사이의 거리를 계산하는 
#방법으로 이 거리를 이용하여 유클리드 공간을 정의한다.

#[실습] 유클리디안 거리 계산법
#단계 1 : matrix객체 생성
x <- matrix(1:9, nrow = 3, by = T)
x

#단계 2 : 유클리드 거리 계산식의 R코드
#1행과 2행 변량의 유클리드 거리 구하기
sqrt(sum((x[1, ] - x[2, ])^2))
#1행과 3행 변량의 유클리드 거리 구하기
sqrt(sum((x[1, ] - x[3, ])^2))
#2행과 3행 변량의 유클리드 거리 구하기
sqrt(sum((x[2, ] - x[3, ])^2))

#단계 3 : 유클리디안 거리 생성
dist <- dist(x, method = "euclidean")
dist

#2. 계층적 군집분석(탐색적 분석)

#[실습] 유클리디안 거리를 이용한 군집화
#단계 1 : 군집분석(Clustering)을 위한 패키지 설치
install.packages("cluster")
library(cluster)

#단계 2 : 데이터셋 생성
x <- matrix(1:9, nrow = 3, by = T)
x

#단계 3 : matrix 대상 유클리드 거리 생성 함수
dist <- dist(x, method = "euclidean")
#data 간의 거리를 계산한다. 결과는 벡터로 반환.
dist

#단계 4 : 유클리드 거리 matrix를 이용한 클러스터링
hc <- hclust(dist) #클러스터링 적용
hc

#단계 5 : 클러스터 시각화
plot(hc, hang = -1) #1과 2 군집 형성

##[실습] 신입사원 면접시험 결과 군집분석
interview <- read.csv("interview.csv", header = T)
View(interview)
interview$합격여부 <- as.factor(interview$합격여부)
names(interview) #attribute 확인

#유클리디안 거리 계산
interview_df <- interview[c(2:7)] #no 제거
interview_df
idist <- dist(interview_df, method = "euclidean")
head(idist)
#계층적 군집분석
hc <- hclust(idist)
hc
#군집분석 시각화
plot(hc, hang = -1)
#군집 단위 테두리 생성
rect.hclust(hc, k = 3, border = "red")

##[실습] 군집별 특징 보기
#단계 1 : 각 그룹별 서브셋 만들기
g1 <- subset(interview, no = 108 | no == 110 | no == 107 | no == 112 | no == 115)
g2 <- subset(interview, no = 102 | no == 101 | no == 104 | no == 106 | no == 113)
g3 <- subset(interview, no = 105 | no == 114 | no == 109 | no == 103 | no == 111)
g1
g2
g3
#단계 2 : 그룹 요약통계량
View(interview)
table(interview$no)
summary(g1)
summary(g2)
summary(g3)

#3. 군집수 자르기
#단계 1 : 유클리디안 거리 계산
interview_df <- interview[c(2:7)] #no 제거
interview_df
idist <- dist(interview_df)
#계층형 군집분석
hc <- hclust(idist)
plot(hc, hang = -1)
rect.hclust(hc, k = 3, border = "red")
#단계 2 : 군집수 자르기
ghc <- cutree(hc, k = 3)
ghc
interview$ghc <- ghc
View(interview)
head(interview)
table(interview$ghc)
head(interview, 9)
#단계 3 : 요약통계량 구하기
g1 <- subset(interview, ghc == 1)
summary(g1)
g2 <- subset(interview, ghc == 2)
summary(g2)
g1 <- subset(interview, ghc == 3)
summary(g3)
