library(ggplot2)

data <- read.csv(file = "csv_cleaned.csv", header = TRUE,  sep = ",")

#Représentations graphiques du nombre d’accidents en fonction des conditions atmosphériques

# HISTOGRAMME
barplot <- ggplot(data, aes(x = descr_athmo, y = nrow(data))) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(x = "Conditions Atmosphériques", y = "Nombre d'accidents", 
       title = "Nombre d'accidents en fonction des conditions atmosphériques") +
  theme_minimal()

print(barplot)
ggsave("barplot.png", width = 11, height = 8)

# PIE
x_athmo <- c(59532, 7296, 2642, 1532, 731, 696, 674, 415, 125)

pie(x_athmo, labels = c("Normale", "Pluie légère", "Temps couvert", 
"Pluie forte", "Temps éblouissant", "Neige – grêle",
"Autre", "Brouillard – fumée", "Vent fort – tempête"))

#Représentations graphiques du nombre d’accidents en fonction de la description de la surface
# HISTOGRAMME surement PLUS LISIBLE
barplot_surf <- ggplot(data, aes(x = descr_etat_surf, y = nrow(data))) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(x = "Conditions de la Surface", y = "Nombre d'accidents", 
  title = "Nombre d'accidents en fonction des conditions de la surface de la route") +
  theme_minimal()

print(barplot_surf)
ggsave("barplot_surf.png", width = 11, height = 8)

# PIE
x_surf <- c(59310, 12350, 859, 395, 381, 215, 81, 34, 18)

pie(x_surf, labels = c("Normale", "Mouillée", "Verglacée", "Autre", "Enneigée", 
    "Corps gras – huile", "Flaques", "Boue", "Inondée"))


# Nombre d’accidents selon la gravité----------------
x_grav <- c(31004, 25672, 14891, 2076)

pie(x_grav, labels = c("Indemne", "Blessé léger", "Blessé hospitalisé", "Tué"))


# Nombre d’accidents par tranches d’heure-------------------
heure <- format(strptime(data$date, format = "%Y-%m-%d %H:%M:%S"), "%H")

barplot_heure <- ggplot(data, aes(x = heure, y = nrow(data))) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(x = "Tranches d'heure", y = "Nombre d'accidents", 
  title = "Nombre d’accidents par tranches d’heure") +
  theme_minimal()

print(barplot_heure)
ggsave("barplot_heure.png", width = 11, height = 8)

# Nombre d’accidents par jour--------------------

# Conversion de la chaîne de caractères en objet de type "Date"
date <- as.Date(data$date)

# Récupération du jour de la semaine
jour_semaine <- weekdays(date)


# Affichage du barplot  
barplot_jour <- ggplot(data, aes(x = jour_semaine, y = nrow(data))) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(x = "Jours", y = "Nombre d'accidents", 
  title = "Nombre d’accidents par jour") +
  theme_minimal()

print(barplot_jour)
ggsave("barplot_jour.png", width = 11, height = 8)
# jour_semaine <- factor(jour_semaine, levels = c("Lundi",
#  "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"), ordered = TRUE)

# Nombre d’accidents par mois--------------------

# Récupération du jour de la semaine
mois <- months(date)

# Affichage du barplot  
barplot_mois <- ggplot(data, aes(x = mois, y = nrow(data))) +
  geom_bar(stat = "identity", fill = "#4674af") +
  labs(x = "Mois", y = "Nombre d'accidents", 
  title = "Nombre d’accidents par mois") +
  theme_minimal()

print(barplot_mois)
ggsave("barplot_mois.png", width = 11, height = 8)

# Nombre d’accidents par ville---------------------
i <- 1
while (i != 21) {
  if (i <= 9) {
     data$ville[data$ville == paste("PARIS 0", i, sep = "")] <- "PARIS"
  }else{
    data$ville[data$ville == paste("PARIS", i, sep = " ")] <- "PARIS"
  }
   i <- i + 1
}

# Regroupement des villes et comptage du nombre d'occurrences
groupe_villes <- aggregate(Num_Acc ~ ville, data, length)
dix_villes <- head(groupe_villes[order(-groupe_villes$Num_Acc), ], 10)
# print(dix_villes)

# Histogramme du Nombre d’accidents par villes
barplot_villes <- ggplot(dix_villes, aes(x = ville, y = Num_Acc)) +
  geom_bar(stat = "identity", fill = "#4674af") +
  labs(x = "Villes", y = "Nombre d'accidents", 
  title = "Nombre d’accidents par villes") +
  theme_minimal()

print(barplot_villes)
ggsave("barplot_villes.png", width = 11, height = 8)