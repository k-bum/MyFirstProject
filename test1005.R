for(i in 1:9) {
  result = i * 3
  print(result)
}

x <- c(1, 3, 5, 7, 9) 
for(i in x) {
  print(i)
}

x <- 1
while(1) {
  x <- 2 * x
  print(x)
  if(x > 100) break
}

i = 1
repeat{
  result = 2 * i
  print(result)
  if(i >= 9) break
  i = i + 1
} 

i <- 0
while(i <= 10) {
  i = i + 1
  if(i %% 2 == 0) next 
  print(i)
}

i <- 0
while(i <= 10) {
  if(i %% 2 == 0) next
  i = i + 1
  print(i)
}

i <- 0
while(i <= 10) {
  i = i + 1
  if(i %% 2 == 1) next
  print(i)
}

install.packages("readxl")
library("readxl")
df_exam <- read_excel("C:/R work/excel_exam.xlsx")
df_exam
mean(df_exam$english) 
mean(df_exam$science)
df_exam_novar <- read_excel("C:/R work/excel_exam_novar.xlsx", col_names =  F)
df_exam_novar
df_exam_sheet <- read_excel("C:/R work/excel_exam_sheet.xlsx", sheet = 3)

df_exam_sheet
df_csv_exam <- read.csv("C:/R work/csv_exam.csv")
df_csv_exam
class(df_csv_exam)
class(df_csv_exam$id)
class(df_csv_exam$FINAL)

df_csv_exam <- read.csv("C:/R work/csv_exam.csv", stringsAsFactors = F)
class(df_csv_exam$FINAL)

df_midterm <- data.frame(english = c(90, 80, 60, 70), math = c(50, 60, 100, 20), class = c(1, 1, 2, 3))
df_midterm
write.csv(df_midterm, file = "C:/R work/df_midterm.csv")
