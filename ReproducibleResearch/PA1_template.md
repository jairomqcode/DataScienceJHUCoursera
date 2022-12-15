# Titulo: Investigación Reproducible (Proyecto 1).
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
library("data.table")
library(ggplot2)
