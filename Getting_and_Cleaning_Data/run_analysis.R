## INICIAMOS EL PROYECTO:
## Cargamos los paquetes que necesitamos:
library(dplyr)

## Descargamos el conjunto de datos:
#Asignamos un valor al objeto: nombre del archivo que guardara la data descargada...
filename <- "coursera_proyecto3_final.zip"

#Metódos utilizados en esta parte:
#1. file.exists(): verifica si el archivo o la carpeta existe. Devuelve un vector lógico 
#que indica si existen los archivos nombrados por su argumento.
#2. download.file(): se puede usar para descargar un solo archivo como se describe en url
#de Internet y almacenarlo.
#3. unzip(): desempaqueta todos los archivos y los distribuye dentro del directorio de 
#trabajo actual.
#4. read.table(): para leer un archivo que contiene datos tabulares en R.
#5. col.names(): se utiliza para cambiar el nombre y reemplazar los nombres de las 
#columnas del marco de datos en R.

#Comprobamos si el archivo ya existe:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}
#Comprobando si existe una carpeta:
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
#Asignación de los marcos de datos:
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
# símbolo $: podemos extraer subconjuntos usando nombres. Este método permite extraer un sólo 
#elemento a la vez, funciona para data frames y listas, y para el caso de los data frame, el 
#elemento extraido siempre será una columna.
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


##OBJETIVOS:
#Metódos utilizados en esta parte:
#1. rbind():  significa enlace de fila. En términos más simples, unión de múltiples filas 
# para formar un solo lote. Puede incluir unir dos marcos de datos, vectores y más.
#2. cbind(): se puede usar para combinar vectores, matrices y marcos de datos por columna.

##Paso 1: fusiona los conjuntos de entrenamiento y prueba para crear un conjunto de datos.
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

##Paso 2: extrae solo las medidas de la media y la desviación estándar de cada medida.
#Datos ordenados:
#1. El operador %>% es útil para concatenar múltiples operaciones dplyr. Dicho operador nos
#nos permite escribir una secuencia de operaciones de izquierda a derecha.
#2. select(): es una función del paquete dplyr R que se usa para seleccionar variables de 
#marco de datos por nombre, por índice, y también se usa para cambiar el nombre de las variables
#al seleccionar y soltar variables por nombre.
#3. contains(): selecciona columnas que contienen una cadena.
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))
##print(TidyData)

##Paso 3: Utiliza nombres de actividades descriptivos para nombrar las actividades en el conjunto de datos.
TidyData$code <- activities[TidyData$code, 2]
##print(TidyData$code)

##Paso 4: Etiqueta apropiadamente el conjunto de datos con nombres de variables descriptivos.
#1. names(): se usa para obtener o establecer el nombre de un objeto.
#2. gsub(): se usa para reemplazar las cadenas con cadenas o valores de entrada. 
#En cada caso reemplazamos la primera cadena por la segunda cadena...
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

##Paso 5: a partir del conjunto de datos del paso 4, cree un segundo conjunto de datos 
#ordenado e independiente con el promedio de cada variable para cada actividad y cada tema.
FinalData <- TidyData %>%
  #1. group_by(): agrupa un conjunto de filas seleccionado en un conjunto de filas 
  #de resumen de acuerdo con los valores de una o más columnas o expresiones.
  group_by(subject, activity) %>%
  #2. summarise(): reduce múltiples valores a un solo valor. Se usa típicamente en datos 
  #agrupados creados por group_by(). La salida tendrá una fila para cada grupo.
  summarise_all(funs(mean))
#3. write.table(): se usa para exportar un marco de datos o matriz a un archivo en el lenguaje R. 
#Esta función convierte un marco de datos en un archivo de texto en el lenguaje R y se puede usar 
#para escribir marcos de datos en una variedad de archivos separados por espacios.
write.table(FinalData, "FinalData.txt", row.name=FALSE)


##Etapa de control final.
#Comprobación de nombres de variables:
print(str(FinalData))

##Datos finales:
print(FinalData)
