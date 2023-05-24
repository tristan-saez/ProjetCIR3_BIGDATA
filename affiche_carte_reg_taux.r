library(leaflet)
library(maps)
library(rgdal)

map_france <- map("france", fill = TRUE, plot = FALSE)
departements <- rgdal::readOGR(
  "https://france-geojson.gregoiredavid.fr/repo/departements.geojson"
)
regions <- rgdal::readOGR(
  "regions.geojson"
)

cleaned <- read.csv("csv_cleaned.csv", sep = ",")
regions_csv <- read.csv("departements-regions.csv")

tot_dep_parsed <- data.frame(code_dep = unique(departements$code), dep = unique(departements$nom), nb_acc = 0, nb_acc_grave = 0, nb_taux = 0)
tot_reg_parsed <- data.frame(reg = unique(regions$nom), nb_acc = 0, nb_acc_grave = 0, nb_taux = 0)

code_dep <- substr(cleaned$id_code_insee, start = 1, stop = 2)

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
pal <- colorQuantile("YlGnBu", domain = c(0:100), n = 12)

#Création de la map des départements
m <- leaflet(data = regions) %>%
  setView(lng = 1.7191036, lat = 46.71109, zoom = 5) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(color = ~pal(tot_reg_parsed$nb_taux), label = ~paste0("Taux d'acidents graves en ", tot_reg_parsed$reg, ": ", tot_reg_parsed$nb_taux)) %>%
  addLegend(
    pal = pal,
    values = c(0, 100),
    opacity = 1.0,
    title = "Taux d'accidents graves en France en 2009")

print(m)