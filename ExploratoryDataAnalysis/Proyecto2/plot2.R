################################################################################
# Importamos el paquete data.table desde la libreria.
library("data.table")
################################################################################


################################################################################
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
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
################################################################################


################################################################################
NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
totalNEI <- NEI[fips=='24510', lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]
# Exportamos el archivo o grafico en formato png.
png(filename='plot2.png')
# La función barplot(): crea un gráfico de barras, con barras verticales u horizontales.
barplot(totalNEI[, Emissions], names = totalNEI[, year], xlab = "Years", ylab = "Emissions", main = "Emissions over the Years"); dev.off()