CODEBOOK.
INSTRUCCIONES.

1. Utilizamos la libreria: library(dplyr)
Enfocada en herramientas para trabajar con marcos de datos. Presenta los siguientes objetivos principales:
- Identifique las herramientas de manipulación de datos más importantes necesarias para el análisis de datos.
- Proporcione un rendimiento ultrarrápido para los datos en memoria al escribir piezas clave en C++.
- Utilice la misma interfaz para trabajar con datos sin importar dónde estén almacenados, ya sea en un marco de datos, una tabla de datos o una base de datos.
Referencia: https://www.r-project.org/nosvn/pandoc/dplyr.html

2. Asignamos al objeto filename el conjunto de datos descargado dentro de un archivo con extensión .zip llamado coursera_proyecto3_final.zip:

filename <- "coursera_proyecto3_final.zip"

Dentro del archivo coursera_proyecto3_final.zip se encuentra una carpeta de nombre UCI HAR Dataset que contiene el conjunto de datos de las pruebas.

Descarga de los datos:

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

3. Asignar cada dato a las variables:

3.1. Asignamos al objeto features los datos leidos que provienen de las pruebas, especificamente los que se encuentran en el archivo features.txt:

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

3.2. Asignamos al objeto activities los datos leidos que provienen de las pruebas, especificamente los que se encuentran en el archivo activity_labels.txt:

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

3.3. Asignamos al objeto subject_test los datos leidos que provienen de las pruebas, especificamente los que se encuentran en el archivo subject_test.txt:

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

3.4. Asignamos al objeto x_test los datos leidos que provienen de las pruebas, especificamente los que se encuentran en el archivo X_test.txt:

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

3.5. Asignamos al objeto y_test los datos leidos que provienen de las pruebas, especificamente los que se encuentran en el archivo y_test.txt:

y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

3.6. Asignamos al objeto subject_traint los datos leidos que provienen de las pruebas, especificamente los que se encuentran en el archivo subject_train.txt:

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

3.7. Asignamos al objeto x_train los datos leidos que provienen de las pruebas, especificamente los que se encuentran en el archivo X_train.txt:

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

3.8. Asignamos al objeto y_train los datos leidos que provienen de las pruebas, especificamente los que se encuentran en el archivo y_train.txt:

y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


4. Paso 1: fusiona los conjuntos de entrenamiento y prueba para crear un conjunto de datos.
4.1. Creamos X, fusionando x_train y x_test usando la función rbind():

X <- rbind(x_train, x_test)

4.2. Creamos Y, fusionando y_train y y_test usando la función rbind():

Y <- rbind(y_train, y_test)

4.3. Creamos Subject, fusionando subject_train y subject_test usando la función rbind():

Subject <- rbind(subject_train, subject_test)

4.4. Creamos Merged_Data, fusionando Subject, Y y X usando la función cbind():

Merged_Data <- cbind(Subject, Y, X)

5. Paso 2: extrae solo las medidas de la media y la desviación estándar de cada medida.
5.1. Creamos TidyData, subdividiendo Merged_Data y seleccionando solo columnas: suject, code, las mediciones en la media (mean) y desviación estándar (std) para cada medición: 

TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))


6. Paso 3: Utiliza nombres de actividades descriptivos para nombrar las actividades en el conjunto de datos:

TidyData$code <- activities[TidyData$code, 2]

7. Paso 4: Etiqueta apropiadamente el conjunto de datos con nombres de variables descriptivos.
7.1. La columna "code" en TidyData es renombrado como "activity":

names(TidyData)[2] = "activity"

7.2. El nombre "Acc" en las columnas es reemplazado por "Accelerometer":

names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))

7.3. El nombre "Gyro" en las columnas es reemplazado por "Gyroscope":

names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))

7.4. El nombre "BodyBody" en las columnas es reemplazado por "Body":

names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))

7.5. El nombre "Mag" en las columnas es reemplazado por "Magnitude":

names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))

7.6. El nombre "^t" en las columnas es reemplazado por "Time":

names(TidyData)<-gsub("^t", "Time", names(TidyData))

7.7. El nombre "^f" en las columnas es reemplazado por "Frequency":

names(TidyData)<-gsub("^f", "Frequency", names(TidyData))

7.8. El nombre "tBody" en las columnas es reemplazado por "TimeBody":

names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))

7.9. El nombre "angle" en las columnas es reemplazado por "Angle":

names(TidyData)<-gsub("angle", "Angle", names(TidyData))

7.10. El nombre "gravity" en las columnas es reemplazado por "Gravity":

names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))


8. Paso 5: a partir del conjunto de datos del paso 4, cree un segundo conjunto de datos ordenado e independiente con el promedio de cada variable para cada actividad y cada tema.

8.1. Creamos FinalData resumiendo TidyData, tomando las medias de cada variable para cada activity y cada suject, luego agrupados por subject y activity.

FinalData <- TidyData %>%

group_by(subject, activity) %>%

summarise_all(funs(mean))

8.2 Exportamos FinalData al archivo nombrado FinalData.txt:

write.table(FinalData, "FinalData.txt", row.name=FALSE)
