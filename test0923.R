a <- 1
a
b <- 2
b
c <- 3
c
d <- 3.5
d
a + b
a + b + c
4 / b
5 * b
var1 <- c(1, 2, 3, 4, 5)
var1
var2 <- c(1:5)
var2
var3 <- seq(1,5)
var3
var4 <- seq(1, 10, by = 2)
var4
var5 <- seq(1, 10, by = 3)
var5
var5 + 1
var1 + var2
var4 + var5 #길이가 다르면 연산 불가

str1 = "a"
str1
str2 <- 'a'
str2
str3 <- "text"
str3
str4 <- "Hello World!!!"
str4
str5 <- c("a", "b", "c")
str5
str6 <- c("Hello!", "World", "is", "good!!")
str6
str7 <- "1"
str7
str7 + 1

x <- 4
5 * x
is.numeric(x) #참 거짓으로 결과 반환
i <- 5L
i
class(i)
is.integer(6.8)
is.numeric(6.8)
class(4L)
class(2.8)
4L * 2.8
class(4L * 2.8)
class(5L * 2L)
class(5L / 2L)

x <- "Data"
nchar(x)
nchar("Hello")
class(x)
nchar(1234567)

date <- as.Date("2021-09-23") #날짜 저장
date
class(date)
as.numeric(date) #실수형으로 형변환
class(date) 
date <- as.numeric(date)
class(date)

TRUE * 5 #TRUE값은 0을 제외한 모든 수
FALSE * 5 #FALSE값은 0
k <- TRUE
class(k)
is.logical(k)
2 == 3
2 != 3
2 < 3
2 <= 3
2 > 3
2 >= 3
"data" == "stats"

x <- c(1:10) #벡터에는 서로 다른 데이터 유형 혼용불가
x
x * 3
x + 2
x / 4
x ^ 2
sqrt(x)
class(x)
y <- -5:4
y
x + y
x - y
x * y
x / y
x ^ y
length(x)
length(y)
length(x + y)
x + c(1,2) #홀수 번째에는 1더하고 짝수 번째에는 2더함
x + c(1,2,3) #경고메세지 출력됨
x <= 5
x > y
x <- 10 : 1
y <- -4 : 5
any(x < y)
all(x > y)
x[1]
x[1:2]
# x[1,4] 오류 
x[c(1,4)]

