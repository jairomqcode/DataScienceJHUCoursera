1. Descargar el conjunto de datos: Dataset, descargado y extraído en la carpeta llamada UCI HAR Dataset.


2. Asignar cada dato a las variables:
2.1. Las características para esta base de datos provienen de las señales sin procesar de 3 ejes del acelerómetro y el giroscopio.
features <- features.txt

2.2. Lista de actividades realizadas al tomarse las medidas correspondientes y sus etiquetas.
activities <- activity_labels.txt

2.3. Datos de prueba, de sujetos de prueba voluntarios observados.
subject_test <- test/subject_test.txt

2.4. Datos de prueba de características registradas.
x_test <- test/X_test.txt

2.5. Datos de prueba de etiquetas de código de actividades.
y_test <- test/y_test.txt

2.6. Datos de entrenamiento de sujetos voluntarios observados.
subject_train <- test/subject_train.txt

2.7. Características grabadas datos del entrenamiento.
x_train <- test/X_train.txt

2.8. Datos de entrenamiento de etiquetas de código de actividades.
y_train <- test/y_train.txt


3. Paso 1: fusiona los conjuntos de entrenamiento y prueba para crear un conjunto de datos.
3.1. Creamos X, fusionando x_train y x_test usando la función rbind()

3.2. Creamos Y, fusionando y_train y y_test usando la función rbind()

3.3. Creamos Subject, fusionando subject_train y subject_test usando la función rbind()

3.4. Creamos Merged_Data, fusionando Subject, Y y X usando la función cbind()


4. Paso 2: extrae solo las medidas de la media y la desviación estándar de cada medida.
4.1. Creamos TidyData, subdividiendo Merged_Data y seleccionando solo columnas: suject, code, las mediciones en la media (mean) y desviación estándar (std) para cada medición.


5. Paso 3: Utiliza nombres de actividades descriptivos para nombrar las actividades en el conjunto de datos.
5.1. Números completos en la columna de código de TidyData son reemplazados con la actividad correspondiente tomada de la segunda columna de la variable de actividades.


6. Paso 4: Etiqueta apropiadamente el conjunto de datos con nombres de variables descriptivos.
6.1. La columna "code" en TidyData es renombrado como "activity"
6.2. El nombre "Acc" en las columnas es reemplazado por "Accelerometer"
6.3. El nombre "Gyro" en las columnas es reemplazado por "Gyroscope"
6.4. El nombre "BodyBody" en las columnas es reemplazado por "Body"
6.5. El nombre "Mag" en las columnas es reemplazado por "Magnitude"
6.6. El nombre "^t" en las columnas es reemplazado por "Time"
6.7. El nombre "^f" en las columnas es reemplazado por "Frequency"
6.8. El nombre "tBody" en las columnas es reemplazado por "TimeBody"
6.9. El nombre "angle" en las columnas es reemplazado por "Angle"
6.10. El nombre "gravity" en las columnas es reemplazado por "Gravity"


7. Paso 5: a partir del conjunto de datos del paso 4, cree un segundo conjunto de datos ordenado e independiente con el promedio de cada variable para cada actividad y cada tema.
7.1. Creamos FinalData resumiendo TidyData, tomando las medias de cada variable para cada activity y cada suject, luego agrupados por subject y activity.
7.2 Exportamos FinalData al archivo nombrado FinalData.txt.
