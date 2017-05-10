library(rgdal)     
map = readOGR("MO_map.geojson", "OGRGeoJSON")

plot(map)

map$id <- 1:3174
#write.csv(as.data.frame(map$TEL_NEV), "varosok.csv")


geojson_write(map, "my.geojson")

map$TEL_NEV
