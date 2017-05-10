library(geojsonio)
library(rgdal)
library(stringr)
library(rgdal)     
library(maptools)
#mindkettőt import to qgis and save as geojson 
#https://osm.wno-edv-service.de/boundaries/

map = readOGR("telep_uj.geojson", "OGRGeoJSON")
map <- map[,c(2,4,5,7)]

bp = readOGR("bp_uj.geojson", "OGRGeoJSON")
bp$TEL_NEV <- bp$NAME
bp <- bp[,17]
bp$TEL_NEV
bp$TEL_NEV <- str_replace(bp$TEL_NEV,"st district", ". kerület")
bp$TEL_NEV <- str_replace(bp$TEL_NEV,"nd district", ". kerület")
bp$TEL_NEV <- str_replace(bp$TEL_NEV,"th district", ". kerület")
bp$TEL_NEV

bp$KIST_NEV <- "Budapest"
bp$MEGY_NEV <- "Pest"
bp$REG_NEV <- "Közép-magyarország"


teljes_map <- rbind(map,bp, makeUniqueIDs = TRUE)  


plot(teljes_map)

geojson_write(teljes_map, "my.geojson")


