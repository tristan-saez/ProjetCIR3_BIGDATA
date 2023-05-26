
data <- read.csv("cleaned_with_region_population.csv", sep=",", fileEncoding="UTF-8")

date <- data$date

mois <- format(as.Date(date, "%m/%d/%Y %H:%M"), "%m")

# Afficher les mois
#View(mois)

total <- length(mois)

# Utilisation de la fonction 'prop.table' pour diviser les données par le total
mois_divisees <- prop.table(table(mois))

# Affichage des résultats
print(mois_divisees)

noms_mois <- c("jan", "fev", "mar", "avr", "mai", "juin", "juil", "aout", "sep", "oct", "nov", "dec")

# Création de l'histogramme avec les noms des mois
png(file="graphiqe/histogramme_acc_par_mois.png")
barplot(mois_divisees*100, 
        main = "Moyenne des accidents par mois",
        xlab = "Mois",
        ylab = "moyenne(en %)",
        names.arg = noms_mois,
        col = c("red","green","yellow","purple"),
        ylim=c(0,10))
box()
dev.off()
