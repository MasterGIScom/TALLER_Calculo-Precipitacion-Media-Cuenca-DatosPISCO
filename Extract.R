library(sp)
library(dplyr)
library(ncdf4)
library(readxl) #Excel
library(raster)
library(rgdal)
setwd("D:/MASTERGIS/PISCO")
#..load the folder or file
Longitud_Latitud <- "EXCEL/Cooderanda.xlsx" %>% 
  read_excel() %>% arrange_all()
# ..load the data .nc
raster_pp<-"DATOS PISCO/UnsPrecMonthly.nc" %>% raster::brick()
#...coordinate assignement
sp::coordinates(Longitud_Latitud)<- ~XX+YY
plot(Longitud_Latitud)
# match the projection of raster with point to extract
raster::projection(Longitud_Latitud)<- raster::projection(raster_pp)
#...Extract the values
points_long_lati<- raster_pp[[1]] %>% raster::extract(Longitud_Latitud, cellnumbers=T)[,1]
data_long_lati<-raster_pp[points_long_lati] %>% t()
colnames(data_long_lati)<-as.character(Longitud_Latitud$NN) #assigment of subbasin colnames
View(data_long_lati)
#...Export the values in csv file 
write.csv (data_long_lati, "EXCEL/DailyRainfall2.csv")
#Display for the all the precipitation date
plot(as.numeric(data_long_lati),
     type="p",
     col="#1B9E77",
     lwd = 3,
     xlab="Número de datos",
     main='Precipitaciones de las cuenca del Rio Santa',
     ylab="Precipitaciones Mensuales (mm)")
length(as.numeric(data_long_lati))