library(sp)
library(dplyr)
library(ncdf4)
library(readxl) #Excel
library(raster)
library(rgdal)
setwd("")
#..load the folder or file
coor <- "EXCEL/coordenadas.xlsx" %>% 
  read_excel() %>% arrange_all()

# ..load the data .nc
pisco<-"DATOS PISCO/UnsPrecMonthly.nc" %>% raster::brick()

#...coordinate assignement
sp::coordinates(coor)<- ~X+Y

# match the projection of raster with point to extract
raster::projection(coor)<- raster::projection(pisco)
#...Extract the values
point_values<- raster::extract(pisco[[1]], coor, cellnumbers=T)[,1]
data_values<-t(pisco[point_values])

#assigment of subbasin colnames
colnames(data_values)<-as.character(coor$Nombre) 

#...Export the values in csv file 
write.csv (data_values, "EXCEL/PrecMonthlySanta.csv")
#Display for the all the precipitation date
plot(as.numeric(data_values),
     type="p",
     col="#1B9E77",
     lwd = 3,
     xlab="Número de datos",
     main='Precipitaciones de las cuenca del Rio Santa',
     ylab="Precipitaciones Mensuales (mm)")
