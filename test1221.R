ceiling(3.2)
ceiling(3.8)
ceiling(-1.2)
ceiling(-3.8)

floor(3.2)
floor(3.8)
floor(-3.8)

round(3.2)
round(3.6)
round(32.1234, 2)
round(-0.51)
round(-1.2346, 3)

abs(-1)
abs(-12)
abs(12)

as.Date("2021/12/06")
as.Date('12/07/2021')
as.Date('2021/12/06', format = '%Y/%m/%d')
as.Date('12/06/2021', format = '%m/%d/%Y')
as.Date('12062021', format = '%m/%d/%Y')
as.Date('12062021', format = '%m%d%Y')
seq(as.Date('2021/12/01'), as.Date('2021/12/25'), 1)
seq(as.Date('2021/01/01'), as.Date('2021/12/25'), 'month')    
tmp <- seq(as.Date('2021/12/01'), as.Date('2021/12/25'), 1)
tmp
as.character(tmp, '%Y') #4digit year
as.character(tmp, '%m')
as.character(tmp, '%d')
as.character(tmp, '%a') #월화수목금토일
as.character(tmp, '%A') #월요일 화요일 수요일 목요일 금요일 토요일 일요일
as.character(tmp, '%y') #2digit year
as.character(tmp, '%b') #1-12
as.character(tmp, '%B') #1월-12월

Sys.Date()
weekdays(Sys.Date()) #오늘 날짜
weekdays(as.Date('1998-02-09')) #2007년 3월 20일의 요일
weekdays(as.Date('1998-10-09'))
Sys.Date() - as.Date('1998-02-09') #오늘 날짜부터 1998-02-09까지 며칠을 살았는지
Sys.Date() - as.Date('1998-10-09')
as.integer(Sys.Date() - as.Date('1998-02-09'))
difftime(Sys.Date(), as.Date('1998-02-09')) 
as.integer(difftime(Sys.Date(), as.Date('1998-02-09')))

library(lubridate)
today()
date <- now()
date
year(date)
month(date)
day(date)
wday(date, label = T) 
wday(date)
date + years(1)
date + months(1)
date + days(1)

tmp <- matrix(1:9, c(3, 3))
tmp
apply(tmp, 1, sum) #행렬에서 각 행의 합을 출력
apply(tmp, 2, sum) #행렬에서 각 열의 합을 출력
apply(tmp, 1, mean)
apply(tmp, 2, mean)
apply(tmp, 2, function(x) {x*2}) #행렬에서 각 숫자의 2배를 출력
lapply(tmp, mean, na.rm = T) #list로 바꿈
