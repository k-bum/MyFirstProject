x <- c(1, 2, 3)
mean(x)
max(x)
min(x)

str6 <- c("Hello!", "World", "is", "good!!")
paste(str6, collapse = " ") 

mean_x <- mean(x)
mean_x
str_paste <- paste(str6, collapse = " ")
str_paste

install.packages("ggplot2")
library("ggplot2")
x <- c("a", "b", "a", "c")
x
qplot(x)

mpg #mile per gallon
head(mpg, n = 10)
View(mpg)
class(mpg)
head(mpg, n = 10)
tail(mpg, n = 10)
summary(mpg)

qplot(data = mpg, x = hwy) #highway
qplot(data = mpg, x = cty) #city
qplot(data = mpg, x = drv, y = hwy) 
qplot(data = mpg, x = drv, y = hwy, geom = "line")
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot")
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot", colour = drv)

x <- c(80, 65, 77, 90, 99, 45, 86)
x
mean(x)
y <- mean(x)
y

x <- c(1, 2, 3, 4, 5)
x
y <- x + 5
y
if(sum(x) < sum(y)) {
  print(y)
  print(mean(y))
  print(var(y))
}
if(TRUE & FALSE) print(x)
if(TRUE | FALSE) print(x)

if(mean(x) > mean(y)) {
  print(paste("mean(x) is ", "larger than ", "mean(y"))
}else {
  print(paste("mean(y) is ", "larger than ", "mean(x)"))
}

ifelse(mean(x) > mean(y), print("mean(x) is larger than mean(y)"),
       print("mean(y) is larger than mean(x)"))

if(score >= 90) {
  print("A")
}else if(score >= 80) {
  print("B")
}else if(score >= 70) {
  print("C")
}else {
  print("F")
}

#switch
x <- "KHU"
switch(x, KHU = 100, SKKU = 200, SNU = 300)
