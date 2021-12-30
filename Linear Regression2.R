library("readxl")
production <- readxl::read_xlsx("electricity usage.xlsx")
View(production)
names(production) 
production <- data.frame(production)

x = production$Production
y = production$Electricity.usage
df <- data.frame(x, y)
View(df)

result.lm <- lm(formula = y ~ x, data = df)
result.lm
summary(result.lm)

