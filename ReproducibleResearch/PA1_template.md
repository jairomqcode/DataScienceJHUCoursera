# Titulo: Investigación Reproducible (Proyecto 1).
Autor: Jairo Mindiola Quintas

fecha: 15/12/2022.

repositorio: https://github.com/jairomqcode/DataScienceJHUCoursera.git

## Introducción del proyecto.

Ahora es posible recopilar una gran cantidad de datos sobre el movimiento personal utilizando dispositivos de monitoreo de actividad como Fitbit, Nike Fuelband o Jawbone Up. Este tipo de dispositivos son parte del movimiento del “yo cuantificado”, un grupo de entusiastas que se toman medidas sobre sí mismos regularmente para mejorar su salud, encontrar patrones en su comportamiento o porque son fanáticos de la tecnología. Pero estos datos siguen estando infrautilizados porque los datos sin procesar son difíciles de obtener y porque faltan métodos estadísticos y software para procesar e interpretar los datos.

Esta asignación hace uso de datos de un dispositivo de monitoreo de actividad personal. Este dispositivo recopila datos en intervalos de 5 minutos a lo largo del día. Los datos consisten en dos meses de datos de un individuo anónimo recopilados durante los meses de octubre y noviembre de 2012 e incluyen la cantidad de pasos dados en intervalos de 5 minutos cada día.

Los datos para esta tarea se pueden descargar del sitio web del curso:
* Dataset: *[Activity monitoring data][1]* 

[1]: https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip

Las variables incluidas en este conjunto de datos son:

* **pasos**: número de pasos dados en un intervalo de 5 minutos (los valores faltantes se codifican como NA).

* **fecha**: La fecha en que se tomó la medida en formato AAAA-MM-DD.

* **intervalo**: Identificador del intervalo de 5 minutos en el que se realizó la medición.

El conjunto de datos se almacena en un archivo de valores separados por comas (CSV) y hay un total de 17 568 observaciones en este conjunto de datos.


## Libreria:
```{r}
library("data.table")
library(ggplot2)
```

## Cargar y preprocesar los datos.
Url desde donde obtendremos los datos:
```{r}
archivoUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
```
Descargamos el archivo de datos:
```{r}
download.file(archivoUrl, destfile = paste0(getwd(), '/repdata%2Fdata%2Factivity.zip'), method = "curl")
unzip("repdata%2Fdata%2Factivity.zip",exdir = "data")
```

## Lectura de datos csv en data.table:
```{r}
activityDT <- data.table::fread(input = "data/activity.csv")
```

## ¿Cuál es la media del número total de pasos dados por día?
número total de pasos dados por día:
```{r}
Total_Steps <- activityDT[, c(lapply(.SD, sum, na.rm = FALSE)), .SDcols = c("steps"), by = .(date)] 
head(Total_Steps, 10)
```

Gráfica del histograma:
```{r}
g1 <- ggplot(Total_Steps, aes(x = steps)) + geom_histogram(fill = "blue", binwidth = 1000) + labs(title = "Daily Steps", x = "Steps", y = "Frequency")
```

Calcule e informe la media y la mediana del número total de pasos dados por día:
```{r}
prom <- Total_Steps[, .(Mean_Steps = mean(steps, na.rm = TRUE), Median_Steps = median(steps, na.rm = TRUE))]
```

## ¿Cuál es el patrón de actividad diaria promedio?
Gráfica de serie de tiempo (es decir, 𝚝𝚢𝚙𝚎 = "𝚕") del intervalo de 5 minutos (eje x) y la cantidad promedio de pasos dados, promediados en 
todos los días (eje y).
```{r}
IntervalDT <- activityDT[, c(lapply(.SD, mean, na.rm = TRUE)), .SDcols = c("steps"), by = .(interval)] 

g2 <- ggplot(IntervalDT, aes(x = interval , y = steps)) + geom_line(color="blue", size=1) + 
      labs(title = "Avg. Daily Steps", x = "Interval", y = "Avg. Steps per day")
```

Intervalo de 5 minutos, en promedio de todos los días del conjunto de datos, contiene la cantidad máxima de pasos
```{r}
int <- IntervalDT[steps == max(steps), .(max_interval = interval)]
```

## Valores faltantes:
Número total de valores faltantes en el conjunto de datos (es decir, el número total de filas con NA).
```{r}
nf <- nrow(activityDT[is.na(steps),])
```

Rellenar los valores faltantes con la mediana del conjunto de datos:
```{r}
rvf <- activityDT[is.na(steps), "steps"] <- activityDT[, c(lapply(.SD, median, na.rm = TRUE)), .SDcols = c("steps")]
```

Nuevo conjunto de datos que sea igual al conjunto de datos original pero con los datos faltantes completados:
```{r}
data.table::fwrite(x = activityDT, file = "data/tidyData.csv", quote = FALSE)
```

Histograma del número total de pasos dados cada día e informe la media y la mediana del número total de pasos dados por día. 
¿Estos valores difieren de las estimaciones de la primera parte de la tarea? 
¿Cuál es el impacto de imputar los datos que faltan en las estimaciones del número total diario de pasos?
Número total de pasos dados por día:
```{r}
Total_Steps <- activityDT[, c(lapply(.SD, sum)), .SDcols = c("steps"), by = .(date)]
```
Media y mediana del número total de pasos dados por día:
```{r}
prom2 <- Total_Steps[, .(Mean_Steps = mean(steps), Median_Steps = median(steps))]
```
Grafica:
```{r}
g3 <- ggplot(Total_Steps, aes(x = steps)) + geom_histogram(fill = "blue", binwidth = 1000) + labs(title = "Daily Steps", x = "Steps", y = "Frequency")
```

Type of Estimate | Mean_Steps | Median_Steps
--- | --- | ---
Parte 1 (con na) | 10766.19 | 10765
Parte 2 (llenar na con la mediana) | 9354.23 | 10395

## ¿Hay diferencias en los patrones de actividad entre los días de semana y los fines de semana?
Cree una nueva variable de factor en el conjunto de datos con dos niveles: 
"día de la semana" y "fin de semana", que indica si una fecha dada es un día de la semana o un día de fin de semana.
```{r}
activityDT <- data.table::fread(input = "data/activity.csv")
activityDT[, date := as.POSIXct(date, format = "%Y-%m-%d")]
activityDT[, `Day of Week`:= weekdays(x = date)]
activityDT[grepl(pattern = "Monday|Tuesday|Wednesday|Thursday|Friday", x = `Day of Week`), "weekday or weekend"] <- "weekday"
activityDT[grepl(pattern = "Saturday|Sunday", x = `Day of Week`), "weekday or weekend"] <- "weekend"
activityDT[, `weekday or weekend` := as.factor(`weekday or weekend`)]
head(activityDT, 10)
```
Haz un gráfico de panel que contenga un gráfico de series de tiempo (es decir, 𝚝𝚢𝚙𝚎 = "𝚕") del intervalo de 5 minutos (eje x) y el número promedio de 
pasos dados, promediados entre todos los días de la semana o los días de fin de semana (eje y).
```{r}
activityDT[is.na(steps), "steps"] <- activityDT[, c(lapply(.SD, median, na.rm = TRUE)), .SDcols = c("steps")]
IntervalDT <- activityDT[, c(lapply(.SD, mean, na.rm = TRUE)), .SDcols = c("steps"), by = .(interval, `weekday or weekend`)] 
g4 <- ggplot(IntervalDT , aes(x = interval , y = steps, color=`weekday or weekend`)) + geom_line() + 
      labs(title = "Avg. Daily Steps by Weektype", x = "Interval", y = "No. of Steps") + facet_wrap(~`weekday or weekend` , ncol = 1, nrow=2)
```

## Imprimir:
```{r}
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
```

