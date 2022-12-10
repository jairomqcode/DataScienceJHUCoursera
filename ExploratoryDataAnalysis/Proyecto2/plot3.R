################################################################################
# Importamos el paquete data.table y ggplot2 desde la libreria.
library("data.table")
library("ggplot2")
################################################################################


################################################################################
setwd("/home/Jairomqcode/Documentos")
# Utilizamos la función getwd() para encontrar el directorio de trabajo.
path <- getwd()
################################################################################


################################################################################
# La función download.file() se puede utilizar para descargar un archivo de Internet.
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
# Extraiga archivos o enumere un archivo zip.
unzip(zipfile = "dataFiles.zip")
################################################################################


################################################################################
# readRDS(): función para escribir un solo objeto R en un archivo y restaurarlo.
# SCC: El nombre de la fuente indicado por una cadena de dígitos (consulte la 
# tabla de clasificación del código fuente).
# ED: emisiones de datos PM25.rds, este archivo contiene un marco de datos con 
# todos los datos de emisiones de PM2.5 para 1999, 2002, 2005 y 2008. Para cada 
# año, la tabla contiene el número de toneladas de PM2.5 emitidas por un tipo 
# específico de fuente durante todo el año.
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))
################################################################################


################################################################################
# Subconjunto de datos NEI por Baltimore.
baltimoreNEI <- NEI[fips=="24510",]
################################################################################


################################################################################
# Formato png para el archivo.
png("plot3.png")
################################################################################


################################################################################
# Grafico:
g <- ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) + geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE) + facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))
################################################################################


################################################################################
print(g)
dev.off()
################################################################################