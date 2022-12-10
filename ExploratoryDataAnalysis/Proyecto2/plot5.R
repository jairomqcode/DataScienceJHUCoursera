################################################################################
# Importamos desde las libreria de R data.table y ggplot2.
library("data.table")
library("ggplot2")
################################################################################


################################################################################
# Directorio:
setwd("/home/Jairomqcode/Documentos/")
path <- getwd()
################################################################################


################################################################################
# Descargamos el archivo con los datos:
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")
################################################################################


################################################################################
# Cargar los data frames:
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))
################################################################################


################################################################################
# Subconjunto de datos NEI relacionados con la combustión de carbón:
combustionRelated <- grepl("comb", SCC[, SCC.Level.One], ignore.case=TRUE)
coalRelated <- grepl("coal", SCC[, SCC.Level.Four], ignore.case=TRUE) 
combustionSCC <- SCC[combustionRelated & coalRelated, SCC]
combustionNEI <- NEI[NEI[,SCC] %in% combustionSCC]
################################################################################


################################################################################
# Formato de archivo:
png("plot5.png")
# Grafico:
g <- ggplot(combustionNEI,aes(x = factor(year),y = Emissions/10^5)) + geom_bar(stat="identity", fill ="#2319e3", width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
################################################################################


################################################################################
# Impresion:
print(g)
dev.off()
################################################################################