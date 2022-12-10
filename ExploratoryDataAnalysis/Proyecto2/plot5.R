################################################################################
# Libreria data.table y ggplot2.
library("data.table")
library("ggplot2")
################################################################################


################################################################################
# Directorio:
setwd("/home/Jairomqcode/Documentos/")
path <- getwd()
################################################################################


################################################################################
# Descarga de archivo y formato .zip:
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")
################################################################################


################################################################################
# Cargar los data frames NEI y SCC:
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))
################################################################################


################################################################################
# Subconjunto de los datos NEI que corresponde a los vehículos:
vehiclesSCC <- SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE), SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]
################################################################################


################################################################################
# Subconjunto de los datos NEI de los vehículos al fip de Baltimore
baltimoreVehiclesNEI <- vehiclesNEI[fips=="24510",]
################################################################################


################################################################################
# Formato de la imagen de archivo: 
png("plot5.png")
################################################################################


################################################################################
# Grafico:
g <- ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) + geom_bar(stat="identity", fill ="#FF9999" ,width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))
################################################################################


################################################################################
# Impresiones:
print(g)
dev.off()
################################################################################