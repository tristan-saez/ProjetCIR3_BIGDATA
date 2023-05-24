
data <- read.csv("cleaned_with_region_population.csv", sep=",", fileEncoding="UTF-8")

age <- data[c("an_nais","age")]
age$age <- age$age - 14

age <- age[age$age> 15,]

x <- age$age
x <- as.numeric(unlist(x))
png(file="histogramme_acc_par_age.png")
hist(x,col=c("#E59F13","#FA650E"), xlab = "Age", ylab = "Nombre d'accident ", main = "Quantity of Accidents by Age Group", xlim=c(16,85))
box()
dev.off()

