library(leaflet)
library(maps)
library(rgdal)


map_france <- map("france", fill = TRUE, plot = FALSE)
regions <- rgdal::readOGR(
  "https://france-geojson.gregoiredavid.fr/repo/regions.geojson"
)

pal <- colorQuantile("Blues", NULL)

m <- leaflet(data = regions) %>%
  setView(lng = 5.7191036, lat = 46.71109, zoom = 12) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(fillColor = pal)

print(m)
