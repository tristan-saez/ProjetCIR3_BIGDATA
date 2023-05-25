library(leaflet)
library(rgdal)

departements <- rgdal::readOGR(
  "departements.geojson"
)

cleaned <- read.csv("csv_cleaned.csv", sep=",")
code_dep <- c()

tot_dep_parsed <- data.frame(code_dep = unique(departements$code), dep = unique(departements$nom), nb_acc = 0, nb_acc_grave = 0, nb_taux = 0)


for (value in cleaned$id_code_insee) {
  value <- ifelse(substr(value, start = 1, stop = 2) == 97, substr(value, start = 1, stop = 3), substr(value, start = 1, stop = 2))
  code_dep <- append(code_dep, value)
}

#View(code_dep)

i <- 1
for (value in code_dep) {
  tot_dep_parsed$nb_acc[value == tot_dep_parsed$code_dep] <- tot_dep_parsed$nb_acc[value == tot_dep_parsed$code_dep] + 1
  if(cleaned$descr_grav[i] == 1 | cleaned$descr_grav[i] == 2) tot_dep_parsed$nb_acc_grave[value == tot_dep_parsed$code_dep] <- tot_dep_parsed$nb_acc_grave[value == tot_dep_parsed$code_dep] + 1

  i <- i + 1
}

tot_dep_parsed$nb_taux <- round((tot_dep_parsed$nb_acc_grave / tot_dep_parsed$nb_acc) * 100, 2)

#View(tot_dep_parsed)

#Création de la palette de couleurs
pal <- colorQuantile("YlGnBu", domain = c(0:100), n = 9)

#Création de la map des départements
m <- leaflet(data = departements) %>%
  setView(lng = 1.7191036, lat = 46.71109, zoom = 5) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(color = ~pal(tot_dep_parsed$nb_taux), label = ~paste0("Taux d'acidents graves en ", tot_dep_parsed$dep, " : ", tot_dep_parsed$nb_taux,"%")) %>%
  addLegend(
    pal = pal,
    values = c(0, 100),
    opacity = 1.0,
    title = "Taux d'accidents graves en France en 2009")

print(m)