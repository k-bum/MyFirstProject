q <- c("A", "B", "AB", "O", "B", "AB", "O", "AB", "O", "A", "A", "B")
q
class(q)
q2 <- as.factor(q)
q2
class(q2)
as.numeric(q2) 
q2 <- factor(x = c("A", "B", "AB", "O", "B", "AB", "O", "AB", "O", "A", "A", "B"), levels =  c("A", "B", "AB","O"), ordered = TRUE)
q2

z <- c(1, 2, NA, 8, 3, NA, 3)
z
is.na(z) 
table(is.na(z))
mean(z)
mean(z, na.rm = T)
is.null(z)

library(dplyr)
x <- c(1:5)
x
mean(x)
z <- c(1, 2, NA, 8, 3, NA, 3)
z
sum(is.na(z))
z %>% is.na() %>% sum()
z %>% mean(na.rm = TRUE)

x <- 10:1
y <- -4:5
x
y
q <- c("Hockey", "Football", "Baseball", "Curling", "Rugby", "Lacrosse",
       "Basketball", "Tennis", "Cricket", "Soccer")
q
theDF <- data.frame(x, y, q)
theDF
theDF <- data.frame(First = x, Second = y, Sport = q)
theDF
nrow(theDF) 
ncol(theDF) 
dim(theDF) 
names(theDF) 
names(theDF[3])
names(theDF)[3]
rownames(theDF)
rownames(theDF) <- c("one", "two", "three", "four", "five", "six", "seven",
                     "eight", "nine", "ten")
rownames(theDF)
theDF
rownames(theDF) <- NULL
theDF
head(theDF) 
head(theDF, n = 3) 
tail(theDF)
class(theDF) 

theDF$Sport
theDF
theDF[4,3] 
theDF[3, c(2:3)]
theDF[3, 2:3]
theDF[c(3:5), 2]
theDF[c(3:5), 2:3]
theDF[,3]
theDF[,2:3]
theDF[2,] 
theDF[2:4,]
theDF[,c("First", "Sport")]
theDF[,"Sport"] 
class(theDF[,"Sport"]) #character
theDF["Sport"]
class(theDF["Sport"]) #data.frame
theDF[["Sport"]]
class(theDF[["Sport"]])

list(1, 2, 3)
list(c(1:3))
list(theDF, 1:10)
list3 <- list(c(1:3), 3:7)
list5 <- list(theDF, 1:10, list3)
list5
names(list5)
names <- c("data.frame", "vector", "list")
names(list5)
list5
list6 <- list(theDataFrame = theDF, TheVector = 1:10, TheList = list3)
names(list6)
list6
list5[[1]]
list5[["data.frame"]]
list5[[1]]$Sport
length(list5)
list5[[4]] <- 2
length(list5)
list5[['NewElement']] <- 3:6
length(list5)

#matrix 
A <- matrix(1:10, nrow = 5)
B <- matrix(21:30, nrow = 5)
C <- matrix(21:40, nrow = 5)
A
B
C
ncol(A)
dim(A)
A + B
A * B
A == B
colnames(A)
rownames(A)
colnames(A) <- c('left', 'right')
rownames(A) <- c('1st', '2nd', '3rd', '4th', '5th')
A

#array 
theArray <- array(1:12, dim = c(2, 6, 1))
theArray
theArray <- array(1:12, dim = c(2, 3, 2))
theArray
theArray[1,,]
theArray[1,,1]
theArray[,,1]
