################################################################################
## Reproducible Research.
## Proyecto 1.
################################################################################


################################################################################
## Importar desde la libreria:
library("data.table")
library(ggplot2)
################################################################################

################################################################################
## Cargar y preprocesar los datos.
## Descomprimir los datos para obtener un archivo csv.
## Url desde donde obtendremos los datos:
archivoUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
## Descargamos el archivo de datos:
download.file(archivoUrl, destfile = paste0(getwd(), '/repdata%2Fdata%2Factivity.zip'), method = "curl")
## Formato de archivo:
unzip("repdata%2Fdata%2Factivity.zip",exdir = "data")
################################################################################


################################################################################
## Lectura de datos csv en data.table:
activityDT <- data.table::fread(input = "data/activity.csv")
################################################################################


################################################################################
## ¿Cuál es la media del número total de pasos dados por día?
## Calcular el número total de pasos dados por día:
Total_Steps <- activityDT[, c(lapply(.SD, sum, na.rm = FALSE)), .SDcols = c("steps"), by = .(date)] 
head(Total_Steps, 10)
################################################################################


################################################################################
## Gráfica del histograma:
g1 <- ggplot(Total_Steps, aes(x = steps)) + geom_histogram(fill = "blue", binwidth = 1000) +
  labs(title = "Daily Steps", x = "Steps", y = "Frequency")
################################################################################


################################################################################
## Calcule e informe la media y la mediana del número total de pasos dados por día:
prom <- Total_Steps[, .(Mean_Steps = mean(steps, na.rm = TRUE), Median_Steps = median(steps, na.rm = TRUE))]
################################################################################


################################################################################
## ¿Cuál es el patrón de actividad diaria promedio?
## Haga una gráfica de serie de tiempo (es decir, 𝚝𝚢𝚙𝚎 = "𝚕") del intervalo
## de 5 minutos (eje x) y la cantidad promedio de pasos dados, promediados en 
## todos los días (eje y).
IntervalDT <- activityDT[, c(lapply(.SD, mean, na.rm = TRUE)), .SDcols = c("steps"), by = .(interval)] 
g2 <- ggplot(IntervalDT, aes(x = interval , y = steps)) + geom_line(color="blue", size=1) + labs(title = "Avg. Daily Steps", x = "Interval", y = "Avg. Steps per day")
## ¿Qué intervalo de 5 minutos, en promedio de todos los días del conjunto de 
## datos, contiene la cantidad máxima de pasos?
int <- IntervalDT[steps == max(steps), .(max_interval = interval)]
################################################################################


################################################################################
## Imputación de valores faltantes:
## Calcule e informe el número total de valores faltantes en el conjunto de datos
## (es decir, el número total de filas con NA)
nf <- activityDT[is.na(steps), .N ]
## Alternativa:
nf2 <- nrow(activityDT[is.na(steps),])
################################################################################


################################################################################
## Diseñe una estrategia para completar todos los valores que faltan en el 
## conjunto de datos. La estrategia no necesita ser sofisticada. Por ejemplo, 
## podría usar la media/mediana de ese día, o la media de ese intervalo de 5 
## minutos, etc.
## Rellenar los valores faltantes con la mediana del conjunto de datos.
rvf <- activityDT[is.na(steps), "steps"] <- activityDT[, c(lapply(.SD, median, na.rm = TRUE)), .SDcols = c("steps")]
################################################################################


################################################################################
## Cree un nuevo conjunto de datos que sea igual al conjunto de datos original 
## pero con los datos faltantes completados.
data.table::fwrite(x = activityDT, file = "data/tidyData.csv", quote = FALSE)
################################################################################


################################################################################
## Haga un histograma del número total de pasos dados cada día y calcule e 
## informe la media y la mediana del número total de pasos dados por día. 
## ¿Estos valores difieren de las estimaciones de la primera parte de la tarea? 
## ¿Cuál es el impacto de imputar los datos que faltan en las estimaciones del 
## número total diario de pasos?
## Número total de pasos dados por día:
Total_Steps <- activityDT[, c(lapply(.SD, sum)), .SDcols = c("steps"), by = .(date)]
## Media y mediana del número total de pasos dados por día:
prom2 <- Total_Steps[, .(Mean_Steps = mean(steps), Median_Steps = median(steps))]
## Grafica:
g3 <- ggplot(Total_Steps, aes(x = steps)) + geom_histogram(fill = "blue", binwidth = 1000) + labs(title = "Daily Steps", x = "Steps", y = "Frequency")
################################################################################


################################################################################
## ¿Hay diferencias en los patrones de actividad entre los días de semana y los 
## fines de semana?
## Cree una nueva variable de factor en el conjunto de datos con dos niveles: 
## "día de la semana" y "fin de semana", que indica si una fecha dada es un día 
## de la semana o un día de fin de semana.
## Simplemente recreando la actividad DT desde cero y luego haciendo que el nuevo
## factor sea variable. (No es necesario, solo quiero tener claro en qué consiste 
## todo el proceso).
activityDT <- data.table::fread(input = "data/activity.csv")
activityDT[, date := as.POSIXct(date, format = "%Y-%m-%d")]
activityDT[, `Day of Week`:= weekdays(x = date)]
activityDT[grepl(pattern = "Monday|Tuesday|Wednesday|Thursday|Friday", x = `Day of Week`), "weekday or weekend"] <- "weekday"
activityDT[grepl(pattern = "Saturday|Sunday", x = `Day of Week`), "weekday or weekend"] <- "weekend"
activityDT[, `weekday or weekend` := as.factor(`weekday or weekend`)]
head(activityDT, 10)
## Haz un gráfico de panel que contenga un gráfico de series de tiempo (es decir,
## 𝚝𝚢𝚙𝚎 = "𝚕") del intervalo de 5 minutos (eje x) y el número promedio de 
## pasos dados, promediados entre todos los días de la semana o los días de fin 
## de semana (eje y). Consulte el archivo README en el repositorio de GitHub para
## ver un ejemplo de cómo debería verse este gráfico usando datos simulados.
activityDT[is.na(steps), "steps"] <- activityDT[, c(lapply(.SD, median, na.rm = TRUE)), .SDcols = c("steps")]
IntervalDT <- activityDT[, c(lapply(.SD, mean, na.rm = TRUE)), .SDcols = c("steps"), by = .(interval, `weekday or weekend`)] 

g4 <- ggplot(IntervalDT , aes(x = interval , y = steps, color=`weekday or weekend`)) + geom_line() + labs(title = "Avg. Daily Steps by Weektype", x = "Interval", y = "No. of Steps") + facet_wrap(~`weekday or weekend` , ncol = 1, nrow=2)


################################################################################
## Imprimir:
print(Total_Steps)
print(g1)
print(prom)
print(IntervalDT)
print(g2)
print(int)
print(nf)
print(rvf)
print(prom2)
print(g3)
print(g4)
################################################################################

