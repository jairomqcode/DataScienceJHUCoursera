CODEBOOK.
INSTRUCCIONES.

El conjunto de datos que pertenece a este libro de códigos se encuentra en el archivo con nombre tidy_data.txt de este repositorio.


1. Datos:

El archivo de datos tidy_data.txt es un archivo de texto que contiene valores separados por espacios.

La primera fila contiene los nombres de las variables y las siguientes filas contienen los valores de estas variables.

2. Variables:

Cada fila contiene: 
- Un tema con 79 mediciones de señal promediadas.
- Una actividad 79 mediciones de señal promediadas.

3. Identificadores:
3.1. Tema: identificador de asunto, número entero.

3.2. Actividad: identificador de actividad con 6 valores posibles:
- WALKING: el sujeto estaba caminando.
- WALKING_UPSTAIRS: el sujeto subiendo las escaleras.
- WALKING_DOWNSTAIRS: el sujeto bajando las escaleras.
- SEATED: el sujeto estaba sentado.
- STANDING: el sujeto estaba de pie.
- LAYING: el sujeto estaba acostado.

4. Medidas:
- Todas las medidas poseen valores de punto flotante, normalizados y acotados dentro de [-1,1].

- Las medidas se clasifican en dos dominios:
1. Señales en el dominio del tiempo (variables con el prefijo DominioTiempo), resultantes de la captura de señales sin procesar de acelerómetros y giroscopios.

2. Señales en el dominio de la frecuencia (variables precedidas por el Dominio de Frecuencia), resultantes de la aplicación de una transformada rápida de Fourier (FFT) a algunas de las señales en el dominio del tiempo.

* Señales en el dominio del tiempo:

- Aceleración promedio del cuerpo en el dominio del tiempo en las direcciones X, Y y Z:
DominioTiempoBodyAcelerometroPromedioX
DominioTiempoBodyAcelerometroPromedioY
DominioTiempoBodyAcelerometroPromedioZ


- Desviación estándar de la aceleración del cuerpo en el dominio del tiempo en las direcciones X, Y y Z:
DominioTiempoBodyAcelerometroDesviaciónStándarX
DominioTiempoBodyAcelerometroDesviaciónStándarY
DominioTiempoBodyAcelerometroDesviaciónStándarZ


- Aceleración media de la gravedad en el dominio del tiempo en las direcciones X, Y y Z:
DominioTiempoGravityAcelerometroPromedioX
DominioTiempoGravityAcelerometroPromedioY
DominioTiempoGravityAcelerometroPromedioZ


- Desviación estándar de la aceleración de la gravedad en el dominio del tiempo en las direcciones X, Y y Z:
DominioTiempoGravityAcelerometroDesviacionStandarX
DominioTiempoGravityAcelerometroDesviacionStandarY
DominioTiempoGravityAcelerometroDesviacionStandarZ



- Tiron Promedio de aceleración del cuerpo en el dominio del tiempo (derivación de la aceleración en el tiempo) en las direcciones X, Y y Z:
DominioTiempoBodyAcelerometroJerkPromedioX
DominioTiempoBodyAcelerometroJerkPromedioY
DominioTiempoBodyAcelerometroJerkPromedioZ


- Desviación estándar del tirón de aceleración del cuerpo en el dominio del tiempo (derivación de la aceleración en el tiempo) en las direcciones X, Y y Z:
DominioTiempoBodyAcelerometroJerkDesviacionStandarX
DominioTiempoBodyAcelerometroJerkDesviacionStandarY
DominioTiempoBodyAcelerometroJerkDesviacionStandarZ


- Velocidad angular promedio del cuerpo en el dominio del tiempo en las direcciones X, Y y Z:
DominioTiempoBodyGiroscopioPromedioX
DominioTiempoBodyGiroscopioPromedioY
DominioTiempoBodyGiroscopioPromedioZ


- Desviación estándar de la velocidad angular del cuerpo en el dominio del tiempo en las direcciones X, Y y Z:
DominioTiempoBodyGiroscopioDesviacionStandarX
DominioTiempoBodyGiroscopioDesviacionStandarY
DominioTiempoBodyGiroscopioDesviacionStandarZ


- Tirón promedio de la velocidad angular del cuerpo en el dominio del tiempo (derivación de la velocidad angular en el tiempo) en las direcciones X, Y y Z:
DominioTiempoBodyGiroscopioJerkPromedioX
DominioTiempoBodyGiroscopioJerkPromedioY
DominioTiempoBodyGiroscopioJerkPromedioZ


- Desviación estándar de la sacudida de la velocidad angular del cuerpo en el dominio del tiempo (derivación de la velocidad angular en el tiempo) en las direcciones X, Y y Z:
DominioTiempoBodyGiroscopioJerkDesviacionStandarX
DominioTiempoBodyGiroscopioJerkDesviacionStandarY
DominioTiempoBodyGiroscopioJerkDesviacionStandarZ


- Promedio y desviación estándar de la magnitud en el dominio del tiempo de la aceleración del cuerpo:
DominioTiempoBodyAcelerometroMagnitudPromedio
DominioTiempoBodyAcelerometroMagnitudDesviacionStandar


- Promedio y desviación estándar de la magnitud en el dominio del tiempo de la aceleración de la gravedad:
DominioTiempoGravityAcelerometroMagnitudPromedio
DominioTiempoGravityAcelerometroMagnitudDesviacionStandar


- Promedio y desviación estándar de la magnitud en el dominio del tiempo de la sacudida de la aceleración del cuerpo (derivación de la aceleración en el tiempo):
DominioTiempoBodyAcelerometroJerkMagnitudPromedio
DominioTiempoBodyAcelerometroJerkMagnitudDesviacionStandar


- Promedio y desviación estándar de la magnitud en el dominio del tiempo de la velocidad angular del cuerpo:
DominioTiempoBodyGiroscopioJerkMagnitudPromedio
DominioTiempoBodyGiroscopioJerkMagnitudDesviacionStandar


 * Señales en el dominio de Frecuencias:
 - Aceleración promedio del cuerpo en el dominio de frecuencia en las direcciones X, Y y Z:
 DominioFrecuenciaBodyAcelerometroPromedioX 
 DominioFrecuenciaBodyAcelerometroPromedioY
 DominioFrecuenciaBodyAcelerometroPromedioZ
 
 
 - Desviación estándar de la aceleración del cuerpo en el dominio de frecuencia en las direcciones X, Y y Z:
 DominioFrecuenciaBodyAcelerometroDesviacionStandarX 
 DominioFrecuenciaBodyAcelerometroDesviacionStandarY 
 DominioFrecuenciaBodyAcelerometroDesviacionStandarZ
 
 
 - Promedio ponderado de los componentes de frecuencia de la aceleración del cuerpo en el dominio de la frecuencia en las direcciones X, Y y Z:
 DominioFrecuenciaBodyAcelerometroPromedioFreqX 
 DominioFrecuenciaBodyAcelerometroPromedioFreqY 
 DominioFrecuenciaBodyAcelerometroPromedioFreqZ
 
 
 - Tirón de aceleración corporal promedio en el dominio de la frecuencia (derivación de la aceleración en el tiempo) en las direcciones X, Y y Z:
 DominioFrecuenciaBodyAcelerometroJerkPromedioX 
 DominioFrecuenciaBodyAcelerometroJerkPromedioY 
 DominioFrecuenciaBodyAcelerometroJerkPromedioZ
 
 
 - Desviación estándar del tirón de aceleración del cuerpo en el dominio de la frecuencia (derivación de la aceleración en el tiempo) en las direcciones X, Y y Z:
DominioFrecuenciaBodyAcelerometroJerkDesviacionStandarX 
DominioFrecuenciaBodyAcelerometroJerkDesviacionStandarY 
DominioFrecuenciaBodyAcelerometroJerkDesviacionStandarZ


 - Promedio ponderado de los componentes de frecuencia del tirón de aceleración del cuerpo en el dominio de la frecuencia (derivación de la aceleración en el tiempo) en las direcciones X, Y y Z:
 DominioFrecuenciaBodyAcelerometroJerkPromedioFreqX 
 DominioFrecuenciaBodyAcelerometroJerkPromedioFreqY 
 DominioFrecuenciaBodyAcelerometroJerkPromedioFreqZ
 
 
 - Velocidad angular media del cuerpo en el dominio de la frecuencia en las direcciones X, Y y Z:
 DominioFrecuenciaBodyGiroscopioPromedioX 
 DominioFrecuenciaBodyGiroscopioPromedioY 
 DominioFrecuenciaBodyGiroscopioPromedioZ
 
 
 - Desviación estándar de la velocidad angular del cuerpo en el dominio de la frecuencia en las direcciones X, Y y Z:
DominioFrecuenciaBodyGiroscopioDesviacionStandarX 
DominioFrecuenciaBodyGiroscopioDesviacionStandarY 
DominioFrecuenciaBodyGiroscopioDesviacionStandarZ


- Promedio ponderado de los componentes de frecuencia de la velocidad angular del cuerpo en el dominio de la frecuencia en las direcciones X, Y y Z:
DominioFrecuenciaBodyGiroscopioPromedioFreqX 
DominioFrecuenciaBodyGiroscopioPromedioFreqY 
DominioFrecuenciaBodyGiroscopioPromedioFreqZ


- Promedio, desviación estándar y promedio ponderado de los componentes de frecuencia de la magnitud de la aceleración del cuerpo en el dominio de la frecuencia:
DominioFrecuenciaBodyAcelerometroMagnitudPromedio 
DominioFrecuenciaBodyAcelerometroMagnitudDesviacionStandar
DominioFrecuenciaBodyAcelerometroMagnitudPromedioFreq

- Promedio, desviación estándar y promedio ponderado de los componentes de frecuencia de la magnitud en el dominio de la frecuencia de la sacudida de la aceleración del cuerpo (derivación de la aceleración en el tiempo):
DominioFrecuenciaCuerpoAcelerometroJerkMagnitudPromedio DominioFrecuenciaCuerpoAcelerometroJerkMagnitudDesviacionStandar DominioFrecuenciaCuerpoAcelerometroJerkMagnitudPromedioFreq


- Promedio, desviación estándar y promedio ponderado de los componentes de frecuencia de la magnitud en el dominio de la frecuencia de la velocidad angular del cuerpo:
DominioFrecuenciaCuerpoGiroscopioMagnitudPromedio
DominioFrecuenciaCuerpoGiroscopioMagnitudDesviacionStandar DominioFrecuenciaCuerpoGiroscopioMagnitudPromedioFreq


- Promedio, desviación estándar y promedio ponderado de los componentes de frecuencia de la magnitud en el dominio de la frecuencia de la sacudida de la velocidad angular del cuerpo (derivación de la velocidad angular en el tiempo):
DominioFrecuenciaCuerpoGiroscopioJerkMagnitudPromedio DominioFrecuenciaCuerpoGiroscopioJerkMagnitudDesviacionStandar DominioFrecuenciaCuerpoGiroscopioJerkMagnitudPromedioFreq



5. Transformaciones:
- El archivo zip que contiene los datos de origen se encuentra en "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
- Los conjuntos de datos de entrenamiento y prueba se fusionaron para crear un conjunto de datos.
- Las mediciones de la media y la desviación estándar se extrajeron para cada medición y las demás se descartaron.
- Los identificadores de actividad (originalmente codificados como números enteros entre 1 y 6) fueron reemplazados por nombres de actividad descriptivos.
- Los nombres de las variables se reemplazaron con nombres de variables descriptivos. Ejemplo: tBodyAcc-mean()-X se expandió a DominioTiempoBodyAcelerometroPromedioX, donde Se eliminaron los caracteres especiales (es decir, (, ) y -). expandido a DominioFrecuencia y DominioTiempo respectivamente. Acc, Gyro, Mag, Freq, mean y std fueron reemplazados por Acelerómetro, Giroscopio, Magnitud, Frecuencia, Promedio y Desviación Stándar respectivamente.
- A partir del conjunto de datos del paso 4, se creó el conjunto de datos final con el promedio de cada variable para cada actividad y cada tema.
- La recopilación de los datos de origen y las transformaciones enumeradas anteriormente se implementaron mediante el script run_analysis.R
