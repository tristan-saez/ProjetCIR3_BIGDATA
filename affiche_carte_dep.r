map_france <- map("france", fill = TRUE, plot = FALSE)
departements <- rgdal::readOGR(
  "https://france-geojson.gregoiredavid.fr/repo/departements.geojson"
)

cleaned <-read.csv("csv_cleaned.csv", sep=",")

View(departements)

#Création de la palette de couleurs
pal <- colorNumeric(c("darkmagenta", "yellow", "darkcyan", "darkblue", "black"), domain = c(0:32000))

#Création de la map des départements
m <- leaflet(data = departements) %>%
  setView(lng = 5.7191036, lat = 46.71109, zoom = 12) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(color = ~pal(tot_reg_parsed$acc), label = ~paste0("Nombre d'acidents en ", tot_reg_parsed$region, ": ", tot_reg_parsed$acc)) %>%
  addLegend(
    pal = pal,
    values = c(0, 32000),
    labFormat = labelFormat(transform = function(x) ifelse(x == 10000, 32000, x)),
    opacity = 1.0,
    title = "Accidents routiers en France en 2009 (région)")

print(m)