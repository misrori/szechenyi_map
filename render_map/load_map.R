regio_map = readOGR("../geo_map/regio.geojson", "OGRGeoJSON")
megye_map = readOGR("../geo_map/megye.geojson", "OGRGeoJSON")

get_regio <-function(){
pal <- colorNumeric(c("blue", "red"), 1:max(regio_map$osszeg, na.rm = T))

popup <- paste0("<strong>Name: </strong>", 
                regio_map$LOCALNAME, 
                "<br>",
                "<strong>Összeg: </strong>",
                regio_map$osszeg)
regio <- 
leaflet(regio_map) %>%
  addPolygons( weight = 1, smoothFactor = 0.5,
               opacity = 1.0, fillOpacity = 0.5,popup=popup, label=~LOCALNAME,
               fillColor = pal(regio_map$osszeg),layerId = ~LOCALNAME,
               highlightOptions = highlightOptions(color = "white", weight = 2,
                                                   bringToFront = TRUE))
return(regio)
}




get_megye <-function(){
  pal <- colorNumeric(c("blue", "red"), 1:max(megye_map$osszeg, na.rm = T))
  
  popup <- paste0("<strong>Name: </strong>", 
                  megye_map$MEGY_NEV, 
                  "<br>",
                  "<strong>Összeg: </strong>",
                  megye_map$osszeg)
  megye <- 
    leaflet(megye_map) %>%
    addPolygons( weight = 1, smoothFactor = 0.5,
                 opacity = 1.0, fillOpacity = 0.5,popup=popup, label=~MEGY_NEV,
                 fillColor = pal(megye_map$osszeg),layerId = ~MEGY_NEV,
                 highlightOptions = highlightOptions(color = "white", weight = 2,
                                                     bringToFront = TRUE))
  return(megye)
}