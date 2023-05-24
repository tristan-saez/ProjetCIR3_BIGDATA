setwd("C:/Users/Vincent/Desktop/Projet-Big-Data/Test")

getwd()
library("car")
library("readxl")

data <- read.csv("cleaned_with_region_population.csv", sep=",", fileEncoding="UTF-8")

date <- data$date

mois <- format(as.Date(date, "%m/%d/%Y %H:%M"), "%m/%d")

mois <- data.frame(mois)
mois$mois <- format(as.Date(date, "%m/%d/%Y %H:%M"), "%m")

mois$mois <- factor(mois$mois)

mois_tmp <-table(mois$mois)
mois_tmp <- as.data.frame(mois_tmp)

#Mois
mois_accident <- data.frame(Var1 = factor(mois_tmp$Var1), Freq = mois_tmp$Freq)

#lm([target] ~ [predictor / features], data = [data source])
regression <- lm(Freq ~ as.numeric(Var1), data = mois_accident)
coefficients <- summary(regression)$coefficients

print(coefficients)

mois_seq <- seq(min(as.numeric(mois_accident$Var1)), max(as.numeric(mois_accident$Var1)), length.out = 100)
predictions <- predict(regression, newdata = data.frame(Var1 = mois_seq))

ggplot(mois_accident, aes(x = Var1, y = Freq)) +
  geom_point() +
  geom_line(data = data.frame(Var1 = mois_seq, Freq = predictions), aes(x = Var1, y = Freq), color = "red") +
  labs(title = "Régression linéaire des accidents", x = "Mois", y = "Accidents")

confidence_intervals <- confint(regression)


regression_summary <- summary(regression)
#View(regression_summary) pour comprendre les affectations de données


r_squared <- regression_summary$r.squared
r_squared_adjusted <- regression_summary$adj.r.squared

print(r_squared)
print(r_squared_adjusted)

mois_accident$Var1 <- as.numeric(as.character(mois_accident$Var1))
mois_accident$Freq <- as.numeric(as.character(mois_accident$Freq))

correlation <- cor(mois_accident$Var1, mois_accident$Freq)

regression_summary
print(confidence_intervals)
print(correlation)

