
data <- read.csv("cleaned_with_region_population.csv", sep=",", fileEncoding="UTF-8")

#Récupèretaion de l'age et l'année de naissance
age <- data[c("an_nais","age")]

#On adapte l'age à la date de l'accident soit 2009
age$age <- age$age - 14

#On récupère uniquement les données où la personne est au-dessus de 15 ans
age <- age[age$age> 15,]

x <- age$age
#On change une liste à un vecteur sans oublier de mettre le sous format numérique(character avant)
x <- as.numeric(unlist(x))
#Extraire l'histogramme en png
png(file="histogramme_acc_par_age.png")
hist(x,col=c("#E59F13","#FA650E"), xlab = "Age", ylab = "Nombre d'accident ", main = "Quantity of Accidents by Age Group", xlim=c(16,85))
#sert à entourer l'histogramme
box()
dev.off()

