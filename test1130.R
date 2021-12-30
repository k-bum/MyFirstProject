prop <- runif(3500000, min = 15500, max = 17000)
#최소 최댓값을 만족하는 범위에서 350만개를 추출(표준분표 내에서)
prop 
prop <- as.integer(prop)
#정수로 변환
prop
samples <- integer(10^6) 
#정수로 10^6개의 sample을 생성
samples

s <- prop[sample(prop, 20, replace = T)]
#prop에서 20개의 sample을 중복가능하게 추출0
s
mean_s <- mean(s)
mean_s

for(i in 1:10^6) {
  s <- prop[sample(prop, 20, replace = T)]
  mean_s <- mean(s)
  samples[i] <- mean_s
}

FreqHeights <- table(samples)
FreqHeights
hist(samples, breaks = 1000, prob = T)

x <- seq(from = 15000, to = 16200, length.out = 10000)
#15000부터 16000까지 10000개를 추출해서 x에 저장
x
ylim <- c(0, 0.01)
plot(x , dnorm(x, mean = 16000, sd = 52.7), main = "Normal",
     type = 'l', ylim = ylim)
#평균이 16000이고 표준편차가 52.7인 정규분포에서 가져와서 x에 매칭 




