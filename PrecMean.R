library(raster)
library(sp)
library(sf)
library(ncdf4)
library(rgdal)
library(dplyr)
setwd("D:/MASTERGIS/PISCO")
# ..load the data .nc
raster_Pisco <- '' %>% raster::brick()
spplot(pisco_pm[[1]])

#...vector type 
cuanca_santa <-  readOGR()
plot(cuanca_santa, 
     axes = T, 
     asp=1, 
     col = "Cyan", 
     main = "Cuenca del rio Santa")
#...extract the mean precipitation values of the basin
pm_cuenca_santa <-  extract(x = raster_Pisco,y = cuanca_santa, fun = mean)

plot(pm_cuenca_santa[1,],
     type = "l", 
     col = "blue", 
     ylim = c(0,300),
     ylab = "Precipitacion media mensual", 
     xlab= "Tiempo en meses del año 1981 al 2021", 
     main = "Precipitacion media Areal Cuenca Santa")+ grid()
#...Export the values in csv file 
write.csv(t(pm_cuenca_santa), "EXCEL/Pm_santa.csv")
