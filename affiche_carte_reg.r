library(leaflet)
library(rgdal)

departements <- rgdal::readOGR(
  "departements.geojson"
)
regions <- rgdal::readOGR(
  "regions.geojson"
)

cleaned <- read.csv("csv_cleaned.csv", sep = ",")
regions_csv <- read.csv("departements-regions.csv")
code_dep <- c()

tot_dep_parsed <- data.frame(code_dep = unique(departements$code), dep = unique(departements$nom), nb_acc = 0)
tot_reg_parsed <- data.frame(reg = unique(regions$nom), nb_acc = 0)

for (value in cleaned$id_code_insee) {
  value <- ifelse(substr(value, start = 1, stop = 2) == 97, substr(value, start = 1, stop = 3), substr(value, start = 1, stop = 2))
  code_dep <- append(code_dep, value)
}

#Calcul du taux d'accidents pour chaque département
for (value in code_dep) {
  tot_dep_parsed$nb_acc[value == tot_dep_parsed$code_dep] <- tot_dep_parsed$nb_acc[value == tot_dep_parsed$code_dep] + 1
}


#Calcul du taux d'accidents grave pour chaque région
for (value in tot_dep_parsed$code_dep) {
  tot_reg_parsed$nb_acc[tot_reg_parsed$reg == regions_csv$nom_reg[regions_csv$num_dep == value]] <- tot_reg_parsed$nb_acc[tot_reg_parsed$reg == regions_csv$nom_reg[regions_csv$num_dep == value]] + tot_dep_parsed$nb_acc[tot_dep_parsed$code_dep == value]
}

# View(tot_reg_parsed)
# View(tot_dep_parsed)
print(sum(tot_dep_parsed$nb_acc))

#Création de la palette de couleurs
pal <- colorNumeric(c("darkmagenta", "yellow", "darkcyan", "darkblue", "black"), domain = c(0:6600))

#Création de la map des départements
m <- leaflet(data = regions) %>%
  setView(lng = 1.7191036, lat = 46.71109, zoom = 5) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(color = ~pal(tot_reg_parsed$nb_acc), label = ~paste0("Taux d'acidents graves en ", tot_reg_parsed$reg, " : ", tot_reg_parsed$nb_acc)) %>%
  addLegend(
    pal = pal,
    values = c(0, 6600),
    opacity = 1.0,
    title = "Accidents routiers en France en 2009 (régions)")

print(m)