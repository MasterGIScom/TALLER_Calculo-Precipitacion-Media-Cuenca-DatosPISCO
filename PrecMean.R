library(raster)
library(sp)
library(sf)
library(latticeExtra)
library(ncdf4)
library(rgdal)
library(dplyr)
setwd("D:/MASTERGIS/PISCO")
# ..load the data .nc
raster_pp<-"DATOS PISCO/UnsPrecMonthly.nc" %>% raster::brick()
spplot(pisco_pm[[1]])

#...vector type 
cuanca_Ilave = readOGR(dsn = ".", layer = "santaWGS84")
plot(cuanca_Ilave, 
     axes = T, 
     asp=1, 
     col = "Cyan", 
     main = "Cuenca Ilave")
#...extract the mean precipitation values of the basin
pm_cuenca_Ilave = extract(x = pisco_pm,y = cuanca_Ilave, fun = mean)

plot(pm_cuenca_Ilave[1,],
     type = "l", col = "blue", ylim = c(0,300),
     ylab = "Precipitacion", xlab= "Tiempo", main = "Precipitacion media Areal Cuenca Ilave")+
  grid()
#...Export the values in csv file 
write.csv(t(pm_cuenca_Ilave), "Precipitacion_media_Areal_ilave.csv")