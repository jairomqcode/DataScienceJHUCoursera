################################################################################
#Archivo plot1.R
# 
# Información:
# Datos recopilados del Repositorio de aprendizaje automático de UC Irvine,
# para generar un histograma de potencia activa global (kilovatios).
################################################################################


################################################################################
# Paso 1: Obtener datos.
# 
# read.csv(): se usa para importar un archivo CSV a un DataFrame. El formato de 
# archivo CSV es la forma más fácil de almacenar datos científicos, analíticos o
# estructurados (bidimensionales con filas y columnas). Los datos en CSV están 
# separados por un delimitador más comúnmente coma (,) pero también puede usar 
# cualquier carácter.
#
# header: si nuestro archivo tiene encabezados, para ser interpretados como 
# nombres de columna, definimos este argumento como TRUE.
#
# sep: es el caracter que es usado como separador de columnas. Por defecto es “;”.
# 
# na.strings: representamos los datos (cadenas) faltantes. 
#
# nrows: representa el número de filas.
#
# check.names: los nombres de las variables en el data frames se verifican para 
# asegurarse de que sean nombres de variables sintácticamente válidos. Si es 
# necesario, se ajustan (por make.names) para que lo sean, y también para 
# garantizar que no haya duplicados.
# 
# stringsAsFactors: convierte automáticamente los datos de texto a factores. Si 
# este no es el comportamiento que deseamos, definimos este argumento como FALSE.
# 
# comment.char: es un vector de caracteres de longitud uno que contiene un solo 
# carácter o una cadena vacía.
# 
# quote: el conjunto de caracteres de comillas. Para deshabilitar las citas por 
# completo, use quote = "". Consulte scanel comportamiento de las comillas 
# incrustadas entre comillas. Las citas solo se consideran para las columnas 
# leídas como caracteres, que son todas a menos que colClassesse especifique.
#
# as.Date(): as.Date: funciones de conversión de fecha hacia y desde caracteres.
# 
# format: formato de fecha.

dato_total = read.csv("/home/Jairomqcode/Documentos/ExploratoryDataAnalysis/household_power_consumption.txt", 
                      header=TRUE, sep=';', na.strings="?", nrows=2075259, check.names=FALSE,
                      stringsAsFactors=FALSE, comment.char="", quote='\"')
dato_total$Date = as.Date(dato_total$Date, format="%d/%m/%Y")
################################################################################


################################################################################
# Paso 2: Subconjunto de datos.
#
# subset: consiste en obtener una submuestra de los datos originales, con el fin
# de obtener elementos específicos basados en alguna condición lógica.
#
# rm: significa eliminar o remover.
#
dato = subset(dato_total, subset=(Date >= "2007-02-01" & Date <= "2007-02-02")); rm(dato_total)
################################################################################


################################################################################
# Paso 3: convertir datos.
# datetime: fecha y hora.
#
# paste (): toma múltiples elementos de los múltiples vectores y los concatena 
# en un solo elemento.
#
# La función as.POSIXct() en R se usa para convertir la configuración predeterminada
# de tipo de carácter para UTC y 1970 en un objeto POSIXct.

datetime <- paste(as.Date(dato$Date), dato$Time)
dato$Datetime <- as.POSIXct(datetime)
################################################################################


################################################################################
# Paso 4: Histograma.
# La función "hist" cálcula un histograma de los valores de datos dados. 
# main: título principal.
# xlab: etiqueta para el eje x.
# ylab: etiqueta para el eje y.
# col: un color que se utilizará para rellenar las barras.

hist(dato$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency", col="Red")
################################################################################


################################################################################
# Paso 5: Guardar el archivo.
#
dev.copy(png, file="plot1.png", height=480, width=480); dev.off()
################################################################################
