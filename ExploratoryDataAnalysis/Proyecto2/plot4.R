################################################################################
# Importamos desde la libreria data.table y ggplot2.
library("data.table")
library("ggplot2")
################################################################################


################################################################################
# Directorio:
setwd("/home/Jairomqcode/Documentos/")
path <- getwd()
################################################################################


################################################################################
# Descargar archivos en formato zip:
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")
################################################################################


################################################################################
# Cargue los marcos de datos NEI y SCC:
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))
################################################################################


################################################################################
# Subconjunto de datos NEI relacionados con la combustión de carbón
combustionRelated <- grepl("comb", SCC[, SCC.Level.One], ignore.case=TRUE)
coalRelated <- grepl("coal", SCC[, SCC.Level.Four], ignore.case=TRUE) 
combustionSCC <- SCC[combustionRelated & coalRelated, SCC]
combustionNEI <- NEI[NEI[,SCC] %in% combustionSCC]
################################################################################


################################################################################
# Archivo en formato png:
png("plot4.png")
# Grafico:
g <- ggplot(combustionNEI,aes(x = factor(year),y = Emissions/10^5)) + geom_bar(stat="identity", fill ="#1616db", width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
################################################################################


################################################################################
# Imprimir:
print(g)
dev.off()
################################################################################