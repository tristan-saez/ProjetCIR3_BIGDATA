library(leaflet)
library(rgdal)
library(mapview)

departements <- rgdal::readOGR(
  "departements.geojson"
)
regions <- rgdal::readOGR(
  "regions.geojson"
)

cleaned <- read.csv("csv_cleaned.csv", sep = ",")
regions_csv <- read.csv("departements-regions.csv")
code_dep <- c()

tot_dep_parsed <- data.frame(code_dep = unique(departements$code), dep = unique(departements$nom), nb_acc = 0, nb_acc_grave = 0, nb_taux = 0)
tot_reg_parsed <- data.frame(reg = unique(regions$nom), nb_acc = 0, nb_acc_grave = 0, nb_taux = 0)

for (value in cleaned$id_code_insee) {
  value <- ifelse(substr(value, start = 1, stop = 2) == 97, substr(value, start = 1, stop = 3), substr(value, start = 1, stop = 2))
  code_dep <- append(code_dep, value)
}

#Calcul du taux d'accidents pour chaque département
i <- 1
for (value in code_dep) {
  tot_dep_parsed$nb_acc[value == tot_dep_parsed$code_dep] <- tot_dep_parsed$nb_acc[value == tot_dep_parsed$code_dep] + 1
  if(cleaned$descr_grav[i] == 1 | cleaned$descr_grav[i] == 2) tot_dep_parsed$nb_acc_grave[value == tot_dep_parsed$code_dep] <- tot_dep_parsed$nb_acc_grave[value == tot_dep_parsed$code_dep] + 1

  i <- i + 1
}

tot_dep_parsed$nb_taux <- round((tot_dep_parsed$nb_acc_grave / tot_dep_parsed$nb_acc) * 100, 2)


#Calcul du taux d'accidents grave pour chaque région
for (value in tot_dep_parsed$code_dep) {
  tot_reg_parsed$nb_acc[tot_reg_parsed$reg == regions_csv$nom_reg[regions_csv$num_dep == value]] <- tot_reg_parsed$nb_acc[tot_reg_parsed$reg == regions_csv$nom_reg[regions_csv$num_dep == value]] + tot_dep_parsed$nb_acc[tot_dep_parsed$code_dep == value]
  tot_reg_parsed$nb_acc_grave[tot_reg_parsed$reg == regions_csv$nom_reg[regions_csv$num_dep == value]] <- tot_reg_parsed$nb_acc_grave[tot_reg_parsed$reg == regions_csv$nom_reg[regions_csv$num_dep == value]] + tot_dep_parsed$nb_acc_grave[tot_dep_parsed$code_dep == value]
}

tot_reg_parsed$nb_taux <- round((tot_reg_parsed$nb_acc_grave / tot_reg_parsed$nb_acc) * 100, 2)

# View(tot_reg_parsed)
# View(tot_dep_parsed)

#Création de la palette de couleurs
pal <- colorQuantile("YlGnBu", domain = c(0:100), n = 9)

#Création de la map des départements
m <- leaflet(data = regions) %>%
  setView(lng = 1.7191036, lat = 46.71109, zoom = 5) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(color = ~pal(tot_reg_parsed$nb_taux), label = ~paste0("Taux d'acidents graves en ", tot_reg_parsed$reg, " : ", tot_reg_parsed$nb_taux, "%")) %>%
  addLegend(
    pal = pal,
    values = c(0, 100),
    opacity = 1.0,
    title = "Taux d'accidents graves en France en 2009")

print(m)

##############################################################################
##### Les lignes suivantes servent à enregistrer les différentes cartes ######
##############################################################################

# mapshot(m, file = "~/Documents/ProjetCir3/ProjetCIR3_BIGDATA/ProjetCIR3_BIGDATA/cartes/carte_regions_metro_taux.png", selfcontained = FALSE)

# #Mayotte
# m <- setView(m, lng = 45.16545500000001, lat = -12.8245115, zoom = 11)
# print(m)
# mapshot(m, file = "~/Documents/ProjetCir3/ProjetCIR3_BIGDATA/ProjetCIR3_BIGDATA/cartes/carte_regions_mayotte_taux.png", selfcontained = FALSE)

# #Guyane française
# m <- setView(m, lng = -53.07822999999999, lat = 3.9517949999999997, zoom = 8)
# print(m)
# mapshot(m, file = "~/Documents/ProjetCir3/ProjetCIR3_BIGDATA/ProjetCIR3_BIGDATA/cartes/carte_regions_guyane_taux.png", selfcontained = FALSE)

# #La Réunion
# m <- setView(m, lng = 55.532062499999995, lat = -21.114533, zoom = 10)
# print(m)
# mapshot(m, file = "~/Documents/ProjetCir3/ProjetCIR3_BIGDATA/ProjetCIR3_BIGDATA/cartes/carte_regions_reunion_taux.png", selfcontained = FALSE)

# #Guadeloupe
# m <- setView(m, lng = -61.27238249999999, lat = 16.1922065, zoom = 10)
# print(m)
# mapshot(m, file = "~/Documents/ProjetCir3/ProjetCIR3_BIGDATA/ProjetCIR3_BIGDATA/cartes/carte_regions_guadeloupe_taux.png", selfcontained = FALSE)

# #Martinique
# m <- setView(m, lng = -61.02281400000001, lat = 14.635540500000001, zoom = 10)
# print(m)
# mapshot(m, file = "~/Documents/ProjetCir3/ProjetCIR3_BIGDATA/ProjetCIR3_BIGDATA/cartes/carte_regions_martinique_taux.png", selfcontained = FALSE)

##############################################################################