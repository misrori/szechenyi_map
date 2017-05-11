library(rgdal)
library(data.table)
library(geojsonio)
library(leaflet)
adat <- data.table(read.csv('data_eredmeny/szechenyi2020_adatok.csv'))
adat[varos=='Devecser',]$KISTERSEG <- 'Devecseri'
################################################################################
#                                HELYSÉG                                       #
################################################################################
map = readOGR("geo_adatok/telep_uj.geojson", "OGRGeoJSON")
map <- map[,c(2,4,6,8)]

helyseg<- adat[,list('osszeg'=sum(osszeg, na.rm = T),'nyertes_palyazat'=.N), by=varos]

plot(map)

helyseg_map <- merge(map,helyseg, by.x='TEL_NEV', by.y='varos')

geojson_write(helyseg_map, "geo_map/helyseg.geojson")


helyseg_map[helyseg_map$TEL_NEV=='Budapest',]


pal <- colorNumeric(c("blue", "red"), 1:max(helyseg_map$osszeg, na.rm = T))

popup <- paste0("<strong>Name: </strong>", 
                helyseg_map$TEL_NEV, 
                "<br>",
                "<strong>Összeg: </strong>",
                helyseg_map$osszeg
                )



leaflet(helyseg_map) %>%
  addPolygons( weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,popup=popup, label=~TEL_NEV,
              fillColor = pal(helyseg_map$osszeg),
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE))


################################################################################
#                              KISTÉRSÉG                                       #
################################################################################
map = readOGR("geo_adatok/kisterseg_2013.geojson", "OGRGeoJSON")
map <- map[,c(3,4,6)]

kist<- adat[,list('osszeg'=sum(osszeg, na.rm = T),'nyertes_palyazat'=.N), by=KISTERSEG]


kist_map <- merge(map,kist, by.x='KIST_NEV', by.y='KISTERSEG')

geojson_write(kist_map, "geo_map/kist.geojson")

pal <- colorNumeric(c("blue", "red"), 1:max(kist_map$osszeg, na.rm = T))

popup <- paste0("<strong>Name: </strong>", 
                kist_map$KIST_NEV, 
                "<br>",
                "<strong>Összeg: </strong>",
                kist_map$osszeg)

leaflet(kist_map) %>%
  addPolygons( weight = 1, smoothFactor = 0.5,
               opacity = 1.0, fillOpacity = 0.5,popup=popup, label=~KIST_NEV,
               fillColor = pal(kist_map$osszeg),
               highlightOptions = highlightOptions(color = "white", weight = 2,
                                                   bringToFront = TRUE))

################################################################################
#                                  MEGYE                                       #
################################################################################
map = readOGR("geo_adatok/megye_2013.geojson", "OGRGeoJSON")
map <- map[,c(3,4)]

megye<- adat[,list('osszeg'=sum(osszeg, na.rm = T),'nyertes_palyazat'=.N), by=MEGYE]

megye_map <- merge(map,megye, by.x='MEGY_NEV', by.y='MEGYE')

geojson_write(megye_map, "geo_map/megye.geojson")

pal <- colorNumeric(c("blue", "red"), 1:max(megye_map$osszeg, na.rm = T))

popup <- paste0("<strong>Name: </strong>", 
                megye_map$MEGY_NEV, 
                "<br>",
                "<strong>Összeg: </strong>",
                megye_map$osszeg)

leaflet(megye_map) %>%
  addPolygons( weight = 1, smoothFactor = 0.5,
               opacity = 1.0, fillOpacity = 0.5,popup=popup, label=~MEGY_NEV,
               fillColor = pal(megye_map$osszeg),
               highlightOptions = highlightOptions(color = "white", weight = 2,
                                                   bringToFront = TRUE))


################################################################################
#                                  Régió                                       #
################################################################################
map = readOGR("geo_adatok/regio.geojson", "OGRGeoJSON")

map <- map[,3]

regio<- adat[,list('osszeg'=sum(osszeg, na.rm = T),'nyertes_palyazat'=.N), by=REGIO]

regio_map <- merge(map,regio, by.x='LOCALNAME', by.y='REGIO')

geojson_write(regio_map, "geo_map/regio.geojson")

pal <- colorNumeric(c("blue", "red"), 1:max(regio_map$osszeg, na.rm = T))

popup <- paste0("<strong>Name: </strong>", 
                regio_map$LOCALNAME, 
                "<br>",
                "<strong>Összeg: </strong>",
                regio_map$osszeg)

leaflet(regio_map) %>%
  addPolygons( weight = 1, smoothFactor = 0.5,
               opacity = 1.0, fillOpacity = 0.5,popup=popup, label=~LOCALNAME,
               fillColor = pal(regio_map$osszeg),
               highlightOptions = highlightOptions(color = "white", weight = 2,
                                                   bringToFront = TRUE))




