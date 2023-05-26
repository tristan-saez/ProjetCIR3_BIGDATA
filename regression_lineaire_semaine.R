

library(ggplot2)


data <- read.csv("cleaned_with_region_population.csv", sep=",", fileEncoding="UTF-8")

date <- data$date
mois <- format(as.Date(date, "%m/%d/%Y %H:%M"), "%m/%d")

mois <- data.frame(mois)
mois$week <- as.numeric(strftime(as.Date(mois$mois, format="%m/%d"), format="%V"))

mois$week <- factor(mois$week)


week_tmp <-table(mois$week)

week_tmp <-as.data.frame(week_tmp)

#Regression pour les semaines

week_accident <- data.frame(Var1 = factor(week_tmp$Var1), Freq = week_tmp$Freq)
week_accident$CumFreq <- cumsum(week_accident$Freq)


#lm([target] ~ [predictor / features], data = [data source])
regression <- lm(CumFreq ~ as.numeric(Var1), data = week_accident)
coefficients <- summary(regression)$coefficients

intercept <- coefficients[1, 1]
slope <- coefficients[2, 1]

# Créez la formule de régression en tant que chaîne de caractères
formula <- paste("Y(chapeau) =", round(intercept, 2), "+", round(slope, 2), "* x")

print(coefficients)

week_seq <- seq(min(as.numeric(week_accident$Var1)), max(as.numeric(week_accident$Var1)), length.out = 100)
predictions <- predict(regression, newdata = data.frame(Var1 = week_seq))

ggplot(week_accident, aes(x = Var1, y = CumFreq)) +
  geom_point() +
  geom_line(data = data.frame(Var1 = week_seq, CumFreq = predictions), aes(x = Var1, y = CumFreq), color = "red") +
  labs(title = paste("Régression linéaire des accidents:", formula), x = "Semaines", y = "Accidents")
ggsave("graphique/regression_semaine.png", width = 6, height = 4, dpi = 300)


summary(regression)

regression_summary <- summary(regression)

#View(regression_summary) pour comprendre les affectations de données

confidence_intervals <- confint(regression, level=0.95)
print(confidence_intervals)

r_squared <- regression_summary$r.squared
r_squared_adjusted <- regression_summary$adj.r.squared

print(r_squared)
print(r_squared_adjusted)

r_squared <- regression_summary$r.squared
r_squared_adjusted <- regression_summary$adj.r.squared

print(r_squared)
print(r_squared_adjusted)

week_accident$Var1 <- as.numeric(as.character(week_accident$Var1))
week_accident$CumFreq <- as.numeric(as.character(week_accident$CumFreq))

correlation <- cor(week_accident$Var1, week_accident$CumFreq)
print(correlation)

confidence_intervals <- confint(regression, level=0.95)
print(confidence_intervals)

residuals <- resid(regression)

plot(week_accident$Var1, residuals, ylab="Residus", xlab="Semaines", main="Residus selon les semaines")
