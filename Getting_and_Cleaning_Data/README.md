Getting and Cleaning Data Project

Autor: Jairo Mindiola Quintas.


OBJETIVOS DEL PROYECTO:

1. Tomar un conjunto de datos y ordenarlos (Utilizando la programación en R como herramienta).

2. Un enlace a un repositorio de Github que contiene los script (código en R) para realizar el análisis de los datos.

3. Un archivo README.md en el repositorio. Explicando cómo funcionan todos los scripts y cómo están conectados.

4. Un libro de códigos denominado CodeBook.md que describa las variables, los datos y cualquier transformación o el trabajo que realizó para limpiar los datos.


DESCRIPCIÓN DEL PROYECTO:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

DATOS DEL PROYECTO:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  


ARCHIVOS:
1. codeBook.md: contiene la explicación de cada parte del código, específicamente, las variables, los datos, los procesos realizados, como las transformaciones realizadas para la limpieza y ordenamiento de los datos.

ruta: Getting_and_Cleaning_Data/codebook.md
Link: https://github.com/jairomqcode/DataScienceJHUCoursera/blob/7207082276df2db61ca31a527c6010e7a2cc4b91/Getting_and_Cleaning_Data/codebook.md

2. run_analysis.R: este archivo contiene el código que se realizó para el procesamiento de los datos del proyecto, donde se cumplen cada uno de los pasos que se plantean dentro de los objetivos del proyecto, que se describen a continuación:
2.1. Merges the training and the test sets to create one data set.
2.2. Extracts only the measurements on the mean and standard deviation for each measurement.
2.3. Uses descriptive activity names to name the activities in the data set.
2.4. Appropriately labels the data set with descriptive variable names.
2.5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

ruta: Getting_and_Cleaning_Data/run_analysis.R
link: https://github.com/jairomqcode/DataScienceJHUCoursera/blob/7207082276df2db61ca31a527c6010e7a2cc4b91/Getting_and_Cleaning_Data/run_analysis.R

3. finalData.txt: este archivo contiene todos los datos finales exportados, los cuales, fueron procesados bajo las instrucciones descritas en el código del run_analysis.R.

ruta: Getting_and_Cleaning_Data/FinalData.txt
link: https://github.com/jairomqcode/DataScienceJHUCoursera/blob/7207082276df2db61ca31a527c6010e7a2cc4b91/Getting_and_Cleaning_Data/FinalData.txt


