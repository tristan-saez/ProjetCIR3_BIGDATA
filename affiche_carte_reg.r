library(leaflet)
library(maps)
library(rgdal)


#Ouverture des fichiers
regions <- read.csv("communes-departement-region.csv",header=TRUE, sep=",", fileEncoding="UTF-8")

cleaned <-read.csv("csv_cleaned.csv", sep=",")

population <-read.csv("Regions.csv", sep=";", fileEncoding="UTF-8")

#View(regions)
population_per_region <- population[c("CODREG","PTOT")]

region_code_insee <- regions[c("nom_region","code_region","code_commune_INSEE","code_departement","nom_departement")]


cleaned_with_region <- merge(cleaned, region_code_insee, by.x ="id_code_insee", by.y="code_commune_INSEE", all.x=TRUE)

cleaned_with_region_population <-merge(cleaned_with_region, population_per_region, by.x="code_region", by.y="CODREG", all.x=TRUE)


#On agrége sur les accidents en fonction des régions ("code_region" et "nom_region") et de la gravité des accidents ("descr_grav"). 
#length compte le nombree d'occurences
accidents_par_region_gravite <- aggregate(Num_Acc ~ code_region + nom_region + descr_grav, cleaned_with_region_population, length)
View(accidents_par_region_gravite)
View(accidents_par_region_gravite[order(accidents_par_region_gravite$nom_region)])
#agrège les données sur la population par région.
# calcule la somme de la population totale ("PTOT") pour chaque combinaison de valeurs des variables "code_region" et "nom_region"
habitants_par_region <- aggregate(PTOT ~ code_region + nom_region, cleaned_with_region_population, sum)

#fusionne acciden_par_region et habitants_par_region en fonctione de "code_region" et "nom_region"
accidents_population <- merge(accidents_par_region_gravite, habitants_par_region, by = c("code_region", "nom_region"))

#calcule le taux d'accidents pour 100 000 habitants pour chaque région 
#en effectuant une division entre le nombre d'accidents et la population totale, puis en multipliant le résultat par 100 000.
accidents_population$accidents_100k <- (accidents_population$Num_Acc / accidents_population$PTOT) * 100000

#sauvegarde des données qui nous intéressent
jeu_donnees <- accidents_population[c("code_region", "nom_region", "descr_grav", "accidents_100k")]




map_france <- map("france", fill = TRUE, plot = FALSE)
regions <- rgdal::readOGR(
  "https://france-geojson.gregoiredavid.fr/repo/regions.geojson"
)

View(jeu_donnees)
tot_reg <- c()


#Récupération des données de région et mise en forme pour la map
i <- 1
print(jeu_donnees$accidents_100k[i + 1])
for (value in unique(jeu_donnees$nom_region)) {
  tot_reg[value] <- jeu_donnees$accidents_100k[i] + jeu_donnees$accidents_100k[i + 1] + jeu_donnees$accidents_100k[i + 2]

  i <- i + 4
}

print(tot_reg)

tot_reg_parsed <- data.frame(region = regions$nom, acc = 0)

i <- 1
for (value in tot_reg_parsed$region) {
  print(value)
  tot_reg_parsed$acc[i] <- round(tot_reg[value] * 100000)
  if (is.na(tot_reg_parsed$acc[i])) tot_reg_parsed$acc[i] <- 0
  i <- i + 1
}

View(tot_reg_parsed)

#Création de la palette de couleurs
pal <- colorNumeric(c("darkmagenta", "yellow", "darkcyan", "darkblue", "grey"), domain = c(0:7000))

#Création de la map des régions
m <- leaflet(data = regions) %>%
  setView(lng = 5.7191036, lat = 46.71109, zoom = 12) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(color = ~pal(tot_reg_parsed$acc), label = ~paste0("Nombre d'acidents en ", tot_reg_parsed$region, ": ", tot_reg_parsed$acc)) %>%
  addLegend(
    pal = pal,
    values = c(0, 10000),
    labFormat = labelFormat(transform = function(x) ifelse(x == 10000, 32000, x)),
    opacity = 1.0,
    title = "Accidents routiers en France en 2009 (région)")

print(m)
