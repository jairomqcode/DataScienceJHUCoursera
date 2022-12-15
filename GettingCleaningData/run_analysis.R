################################################################################
## Proyecto de limpieza y ordenamiento de datos (Proyecto Samsung).
################################################################################



################################################################################
## INFORMACIÓN DEL CONJUNTO DE DATOS:
# Los experimentos se han llevado a cabo con un grupo de 30 voluntarios en un rango 
# de edad de 19 a 48 años. Cada persona realizó seis actividades (CAMINAR, 
# CAMINAR_ARRIBA, CAMINAR_ABAJO, SENTADO, DE PIE, ACOSTADO) usando un teléfono 
# inteligente (Samsung Galaxy S II) en la cintura. Usando su acelerómetro y 
# giroscopio incorporados, capturamos la aceleración lineal de 3 ejes y la velocidad
# angular de 3 ejes a una velocidad constante de 50 Hz. Los experimentos han sido 
# grabados en video para etiquetar los datos manualmente. El conjunto de datos 
# obtenido se dividió aleatoriamente en dos conjuntos, donde se seleccionó el 
# 70 % de los voluntarios para generar los datos de entrenamiento y el 30 % para 
# los datos de prueba.

# Las señales de los sensores (acelerómetro y giroscopio) se preprocesaron aplicando
# filtros de ruido y luego se muestrearon en ventanas deslizantes de ancho fijo 
# de 2,56 segundos y 50% de superposición (128 lecturas/ventana). La señal de 
# aceleración del sensor, que tiene componentes gravitacionales y de movimiento 
# del cuerpo, se separó mediante un filtro de paso bajo de Butterworth en aceleración
# del cuerpo y gravedad. Se supone que la fuerza gravitacional tiene solo componentes
# de baja frecuencia, por lo que se utilizó un filtro con una frecuencia de corte 
# de 0,3 Hz. De cada ventana se obtuvo un vector de características mediante el 
# cálculo de variables del dominio del tiempo y la frecuencia.

# En el siguiente enlace se puede ver un vídeo del experimento con un ejemplo de
# las 6 actividades grabadas con uno de los participantes:
# https://youtu.be/XOEN9W05_4A


## INFORMACIÓN DE ATRIBUTOS:
# Para cada registro en el conjunto de datos se proporciona:
# 1. Aceleración triaxial del acelerómetro (aceleración total) y la aceleración corporal estimada.
# 2. Velocidad angular triaxial del giroscopio.
# 3. Un vector de 561 características con variables en el dominio del tiempo y la frecuencia.
# 4. Su etiqueta de actividad.
# 5. Un identificador del sujeto que realizó el experimento.
################################################################################



################################################################################
## Archivo: run_analysis.R.
# Se tomo el conjunto de datos recopilados del acelerometro del telefono samsung 
# galaxys para proceder a realizar una limpieza de los mismos, obteniendo como 
# resultado un conjunto de datos ordenados, el cual, se guardo en un archivo de 
# nombre tidydata.txt.
################################################################################



################################################################################
## Importamos la libreria:
library(dplyr)
################################################################################



################################################################################
##Obtener datos desde una url:
archivoUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
archivozip <- "UCI HAR Dataset.zip"

#1.file.exists(): verifica si el archivo o la carpeta existe. Devuelve un vector 
# lógico que indica si existen los archivos nombrados por su argumento.

#2.download.file(): se puede usar para descargar un solo archivo como se describe 
# en url de Internet y almacenarlo.

#3.unzip(): desempaqueta todos los archivos y los distribuye dentro del directorio de 
#trabajo actual.

if (!file.exists(archivozip)){download.file(archivoUrl, archivozip, method="curl")}

##Descomprima el archivo zip que contiene datos si el directorio de datos aún no existe:
rutadedatos<- "UCI HAR Dataset"
if (!file.exists(rutadedatos)){unzip(archivozip)}
################################################################################



################################################################################
#1. read.table(): se usa para leer archivos que contiene datos tabulares en R.

#2. file.path(): crea una ruta a un archivo específico en un directorio de trabajo.

#3. as.is: lanza un objeto para que coincida con la clase de otro objeto.

#4. c(): se usa para crear un vector con valores proporcionados explícitamente. 
# El método predeterminado combina sus argumentos para formar un vector. Todos 
# los argumentos se convierten en un tipo común del valor devuelto y se eliminan 
# todos los atributos excepto los nombres.

## LEER DATOS:
# leer los datos de entrenamiento:
sujetoentrenamiento <- read.table(file.path(rutadedatos, "train", "subject_train.txt"))
valoresentrenamiento <- read.table(file.path(rutadedatos, "train", "X_train.txt"))
actividadentrenamiento <- read.table(file.path(rutadedatos, "train", "y_train.txt"))

# leer los datos de pruebas:
sujetoprueba <- read.table(file.path(rutadedatos, "test", "subject_test.txt"))
Valoresprueba <- read.table(file.path(rutadedatos, "test", "X_test.txt"))
actividadprueba <- read.table(file.path(rutadedatos, "test", "y_test.txt"))

# leer las caracteristicas:
caracteristicas <- read.table(file.path(rutadedatos, "features.txt"), as.is = TRUE)

# leer etiquetas de actividad:
actividad <- read.table(file.path(rutadedatos, "activity_labels.txt"))
colnames(actividad) <- c("actividadId", "actividadetiqueta")
################################################################################



################################################################################
##Paso 1: combine los conjuntos de datos de entrenamiento y prueba para crear un conjunto 
# de datos.
################################################################################
#1. rbind(): se puede utilizar para combinar varios vectores, matrices y/o marcos
# de datos por filas.

#2. cbind(): se utiliza para combinar vectores, matrices y/o marcos de datos por 
# columnas.

#3. rm: Se utiliza para borrar objetos de la memoria.

# Concatenaremos cada conjunto de datos individual para crear una sola tabla de datos.
actividadhumana <- rbind(cbind(sujetoentrenamiento, valoresentrenamiento, actividadentrenamiento), cbind(sujetoprueba, Valoresprueba, actividadprueba))

# Eliminar tablas de datos individuales para ahorrar memoria.
rm(sujetoentrenamiento, valoresentrenamiento, actividadentrenamiento, sujetoprueba, Valoresprueba, actividadprueba)

# Asignar nombres a columnas.
colnames(actividadhumana) <- c("subject", caracteristicas[, 2], "activity")



################################################################################
##Paso 2: extraiga solo las medidas sobre la media y la desviación estándar para cada medida.
################################################################################
#1. grepl(): es una función incorporada que busca coincidencias de una cadena o 
# vector de cadena.

mantenercolumnas <- grepl("subject|activity|mean|std", colnames(actividadhumana))

# Dejando los datos unicamente de las siguientes columnas:
actividadhumana <- actividadhumana[, mantenercolumnas]
################################################################################



################################################################################
##Paso 3: Usar nombres de actividades descriptivas para nombrar las actividades 
# en el conjunto de datos.
################################################################################
#1. $: su usa para extraer subconjuntos usando nombres. Este método permite extraer
# un sólo elemento a la vez, funciona para data frames y listas, y para el caso 
# de los data frame, el elemento extraido siempre será una columna.

#2. factor(): se utilizan para representar datos categóricos.

actividadhumana$activity <- factor(actividadhumana$activity, levels = actividad[, 1], labels = actividad[, 2])
################################################################################



##############################################################################
##Paso 4: Etiquete adecuadamente el conjunto de datos con nombres de variables 
# descriptivos.
##############################################################################
# Nombres de columnas:
columnasactividadhumana <- colnames(actividadhumana)

# Eliminar caracteres especiales:
#1. gsub(): se usa para reemplazar las cadenas con cadenas o valores de entrada.
columnasactividadhumana <- gsub("[\\(\\)-]", "", columnasactividadhumana)

# Cambiamos los nombres de abreviaturas por nombres mas descriptivos:
#1. cambiamos el nombre ^f por Dominio de frecuencia.
columnasactividadhumana <- gsub("^f", "DominioFrecuencia", columnasactividadhumana)

#2. cambiamos el nombre ^t por Dominio de tiempo:
columnasactividadhumana <- gsub("^t", "DominioTiempo", columnasactividadhumana)

#3. cambiamos el nombre Acc por Acelerometro:
columnasactividadhumana <- gsub("Acc", "Acelerometro", columnasactividadhumana)

#4. cambiamos el nombre Gyro por Giroscopio:
columnasactividadhumana <- gsub("Gyro", "Giroscopio", columnasactividadhumana)

#5. cambiamos el nombre Mag por Magnitud:
columnasactividadhumana <- gsub("Mag", "Magnitud", columnasactividadhumana)

#6. cambiamos el nombre Freq por Frecuencia:
humanActivityCols <- gsub("Freq", "Frequency", columnasactividadhumana)

#7. cambiamos el nombre mean por Promedio:
columnasactividadhumana <- gsub("mean", "Promedio", columnasactividadhumana)

#8. cambiamos el nombre std por Desviación estándar:
columnasactividadhumana <- gsub("std", "DesviacionStandar", columnasactividadhumana)

# cambiamos el nombre BodyBody por Cuerpo:
columnasactividadhumana <- gsub("BodyBody", "Cuerpo", columnasactividadhumana)

# Usar las nuevas etiquetas como nombres de columna:
colnames(actividadhumana) <- columnasactividadhumana


##############################################################################
##Paso 5 - Cree un segundo conjunto ordenado e independiente con el promedio de 
# cada variable para cada actividad y cada tema.
##############################################################################
# Agrupar por tema y actividad, resumir utilizando la media:

#1. group_by(): es del paquete dplyr que se usa para agrupar filas por valores 
# de columna en el DataFrame.

#2. summarise_each(): resumir y mutar varias columnas. Aplicar una o más funciones 
# a una o más columnas.

#3. operador %>%: es útil para concatenar múltiples operaciones dplyr. El operador %>% 
# nos permite escribir una secuencia de operaciones de izquierda a derecha.

Recursosactividadhumana <- actividadhumana %>% group_by(subject, activity) %>% summarise_all(funs(mean))

# salida al archivo "tidy_data.txt"....
print(write.table(Recursosactividadhumana, "tidy_data.txt", row.names = FALSE))