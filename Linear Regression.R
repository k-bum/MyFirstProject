
#################################################
## 회귀분석(Regression Analysis)
#################################################


## 단순 회귀분석

# 연구가설 : 제품 적절성은  제품 만족도에 정(正)의 영향을 미친다.
# 연구모델 : 제품적절성(독립변수) -> 제품 만족도(종속변수)

# 단순선형회귀 모델 생성  
# 형식) lm(formula= y ~ x 변수, data) # x:독립, y 종속, data=data.frame

product <- read.csv("product.csv", header=TRUE)
str(product) # 'data.frame':  264 obs. of  3 variables:

y = product$제품_만족도 # 종속변수
x = product$제품_적절성 # 독립변수
df <- data.frame(x, y)
View(df)

# 회귀모델 생성 
result.lm <- lm(formula = y ~ x, data=df)
#formula = 종속변수 ~ 설명변수(독립변수)

# (1) 회귀분석의 절편과 기울기 
result.lm # 회귀계수 

# [실습] 모델의 적합값과 잔차 보기 
names(result.lm)
#residuals = 잔차(random error)
fitted.values(result.lm)[1:2] #첫번째 ~ 두번째 데이터의 예측된 값
head(df, 2) # x=4, y=3 -> 첫번째 관측치
Y1 = 0.7789 + 0.7393 * 4 # -> 선형모델을 통한 예측치
Y2 = 0.7789 + 0.7393 * 3
Y1 # 3.7361
Y2 # 2.9968

# 오차(잔차:error) = 관측치 - 예측치 
3 - 3.7361  # -0.7361
2 - 2.9968  # -0.9968

residuals(result.lm)[1:2]
-0.7359630 + 3.735963

# [실습] 선형회귀분석 모델 시각화[오류 확인]
# x,y 산점도 그리기 
plot(formula = y ~ x, data = df)
# 회귀분석
result.lm <- lm(formula = y ~ x, data = df)
# 회귀선 
abline(result.lm, col = 'red')

# [실습] 선형회귀분석 결과 보기
summary(result.lm)


## 2.3 다중 회귀분석 

# - 여러 개의 독립변수 -> 종속변수에 미치는 영향 분석
# 연구가설 : 음료수 제품의 적절성(x1)과 친밀도(x2)는 제품 만족도(y)에 정의 영향을 미친다.
# 연구모델 : 제품 적절성(x1), 제품 친밀도(x2) -> 제품 만족도(y)

product <- read.csv("product.csv", header=TRUE)

#(1) 적절성 + 친밀도 -> 만족도  
y = product$제품_만족도 # 종속변수
x1 = product$제품_친밀도 # 독립변수2
x2 = product$제품_적절성 # 독립변수1
df2 <- data.frame(x1, x2, y)
View(df2)

result.lm <- lm(formula = y ~ x1 + x2, data = df2)

# 계수 확인 
result.lm
# 0.66731(y절편)      0.09593(x1)  0.68522(x2)  
summary(result.lm)
#유의수준 : 0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# 분산팽창요인 
install.packages("car") # vif() 함수 제공 패키지 설치
library(car) # 메모리 로딩

#단계 2 : 분산팽창요인(VIF)
vif(result.lm) 
vif(result.lm) > 10 # FALSE FALSE 
#vif가 10 이상일때 다중공선성이 있다고 판단

# [실습] 선형회귀분석 결과 보기
summary(result.lm)

# 표준화 계수
# 계수를 표준화(두 설명변수의 상관관계가 다를 수 있으므로)
# 표준화된 계수가 큰 변수일수록 영향력있는 설명변수이다.
install.packages("lm.beta")
library("lm.beta")
lm.beta(result.lm)

## 2.4 다중공선성 문제 해결과 모델 성능평가

# [실습] 다중공선성 문제 확인

# (1) 패키지 설치 및 데이터 로딩 
data(iris)
View(iris)

# (2) iris 데이터 셋으로 다중회귀분석 (Sepal 꽃받침, Petal 꽃잎)
fit <- lm(formula = Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, data = iris)
#3개의 설명변수(꽃받침의 길이, 꽃받침의 너비, 꽃잎의 길이)
vif(fit)
vif(fit)>10 # VIF가 10 이상인 것은 다중공선성 문제 의심 
#다중공선성이 의심되면 해당 변수는 제거해도 무방하다고 판단

# (3) iris 변수 간의 상관계수 구하기
cor(iris[,-5]) # 변수간의 상관계수 보기(Species 제외) 
# 변수 간 상관관계가 높은지 확인
# x변수들 간 계수값이 높을 수도 있다. -> 해당 변수 제거(모형 수정) <- Petal.Length

# [실습] 데이터 셋 생성과 회귀모델 생성

# (2) 변수 제거 및 다중회귀분석 - Petal.Length 변수를 제거한 후 회귀분석 
# petal.length가 vif가 가장 크기 때문에 제거
# - 학습데이터 이용 모델 생성 
model <- lm(formula = Sepal.Length ~ Sepal.Width + Petal.Width, data = iris)

# (3) 회귀방정식 도출 
model 
vif(model)
#vif값이 줄어들었으므로 다중공선성 문제 해결
summary(model)

# 첫 번째 관측치 보기
head(iris, 1)

Y = 3.4573 + 0.3391 * 3.5 + 0.9721 * 0.2 # <- 첫번째 예측치
Y

# 오차(잔차:error) = 관측치 - 예측치 
5.1 - 4.83857 # 0.26143

# (4) 예측치 생성 - predict()함수
# - 회귀분석 결과를 대상으로 회귀방정식을 적용한 새로운 값 예측(Y값)
pred <- predict(model, iris)# x변수만 data set에서 찾아서 값 예측
pred # iris 데이터 셋의 y 예측치(회귀방정식 적용) 
iris$Sepal.Length # test 데이터 셋의 y 관측치  
length(pred) 

# (5) 회귀모델 평가 
cor(pred, iris$Sepal.Length)
summary(pred); summary(iris$Sepal.Length)


##  2.5 기본가정 충족으로 회귀분석 수행

# [실습] 기본가정 충족으로 회귀분석 수행 

# 1. 회귀모델 생성 
# (1) 변수 모델링 : y:Sepal.Length <- x:Sepal.Width,Petal.Length,Petal.Width
formula = Sepal.Length ~ Sepal.Width + Petal.Width

# (2) 회귀모델 생성 
model <- lm(formula = formula,  data = iris)
model

# 2. 잔차[오차] 분석

# (1) 독립성과 등분산성 검정  
install.packages('lmtest')
library(lmtest) # 자기상관 진단 패키지 설치 
dwtest(model) # 더빈 왓슨 값(통상 1~3 사이)

# 등분산성 검정 
plot(model, which =  1) 
methods('plot') # plot()에서 제공되는 객체 보기 

# 1. A plot of residuals against fitted values
# 2. A normal Q-Q plot
# 3. A Scale-Location plot of sqrt(| residuals |) against fitted values


# (2) 잔차 정규성 검정
attributes(model) # coefficients(계수), residuals(잔차), fitted.values(적합값)
res <- residuals(model) # 잔차 추출 
shapiro.test(res) # 정규성 검정 - p-value = 0.9349 >= 0.05
# 귀무가설 : 정규성과 차이가 없다.

# 정규성 시각화  
hist(res, freq = F) 
qqnorm(res)


# 3. 다중공선성 검사 
library(car)
vif(model)
vif(model) > 10 # TRUE 

# 4. 회귀모델 생성/평가 
formula = Sepal.Length ~ Sepal.Width + Petal.Width 
model <- lm(formula = formula,  data=iris)
summary(model) # 모델 평가

# predicted residual error sum of squares (PRESS) 
