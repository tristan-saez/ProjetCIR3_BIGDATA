library(leaflet)
library(maps)
library(rgdal)

map_france <- map("france", fill = TRUE, plot = FALSE)
departements <- rgdal::readOGR(
  "departements.geojson"
)

cleaned <- read.csv("csv_cleaned.csv", sep=",")
code_dep <- c()

tot_dep_parsed <- data.frame(code_dep = unique(departements$code), dep = unique(departements$nom), nb_acc = 0)

for (value in cleaned$id_code_insee) {
  value <- ifelse(substr(value, start = 1, stop = 2) == 97, substr(value, start = 1, stop = 3), substr(value, start = 1, stop = 2))
  code_dep <- append(code_dep, value)
}


for (value in code_dep) {
  tot_dep_parsed$nb_acc[value == tot_dep_parsed$code_dep] <- tot_dep_parsed$nb_acc[value == tot_dep_parsed$code_dep] + 1
}

#View(tot_dep_parsed)

#Création de la palette de couleurs
pal <- colorNumeric(c("darkmagenta", "yellow", "darkcyan", "darkblue", "black"), domain = c(0:3100))

#Création de la map des départements
m <- leaflet(data = departements) %>%
  setView(lng = 1.7191036, lat = 46.71109, zoom = 5) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(color = ~pal(tot_dep_parsed$nb_acc), label = ~paste0("Nombre d'acidents en ", tot_dep_parsed$dep, " : ", tot_dep_parsed$nb_acc)) %>%
  addLegend(
    pal = pal,
    values = c(0, 3200),
    opacity = 1.0,
    title = "Accidents routiers en France en 2009 (départements)")

print(m)