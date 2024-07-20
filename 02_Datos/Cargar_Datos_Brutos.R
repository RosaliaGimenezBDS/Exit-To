#---
#  title: "REPRODUCIBILIDAD de PROYECTOS DE CIENCIA DE DATOS reto 2"
#author: ROSALIA GIMENEZ MILLAN (21615274/25393948Q)
#output: html_notebook
#---
  
#CARGAMOS LA BASE DE DATOS CON UNA SELECCION AMPLIA DE DATOS QUE NOS PARECEN INTERESANTES
#REALIZAMOS UN ANALISIS DESCRIPTIVO EXPLORATORIO PARA FAMILIARIZARNOS Y DEPURAR LOS DATOS

library(readr)
library(curl)

show_col_types = FALSE

datos_brutos <- read_csv("ESS1e06_7-ESS2e03_6-ESS3e03_7-ESS4e04_6-ESS5e03_5-ESS6e02_6-ESS7e02_3-ESS8e02_3-ESS9e03_2-ESS10SC-subset.csv")


#Por el momento cargamos los datos desde local - podríamos interactuar con el usuario administrador y preguntarle si quiere actualizar los datos
#avisandole de que necesita crear una cuenta en ESS para poder acceder a la descarga de los datos actualizados
#Si disponemos de tiempo, volveremos a este punto más adelante en el proyecto

# URL del conjunto de datos
#url <- "https://stessdissprodwe.blob.core.windows.net/data/download/4/generate_datafile/a9e7e889540fa08a80265e0f0045377f.zip?st=2024-07-14T20%3A43%3A43Z&se=2024-07-14T21%3A45%3A43Z&sp=r&sv=2023-11-03&sr=b&skoid=1b26ad26-8999-4f74-9562-ad1c57749956&sktid=93a182aa-d7bd-4a74-9fb1-84df14cae517&skt=2024-07-14T20%3A43%3A43Z&ske=2024-07-14T21%3A45%3A43Z&sks=b&skv=2023-11-03&sig=rCnF7EcdRqWeZ6e3%2BUO8O%2BSq7cOicwNbeTycsPO8AoU%3D"

# Nombre del archivo donde se guardará el conjunto de datos
#destfile <- "datos_ess.zip"

# Intentar descargar y cargar los datos del ESS
#tryCatch({
  # Descargar el archivo
 # curl_download(url, destfile)
  
  # Descomprimir el archivo (si es un archivo comprimido)
  #unzip(destfile, exdir = "datos_ess")
  
  # Listar los archivos descomprimidos
  #files <- list.files("datos_ess", full.names = TRUE)
  #print(files)
  
  # Cargar datos CSV
  #data_file <- files[grepl("\\.csv$", files)]  # Filtra archivos CSV
  
  #if (length(data_file) > 0) {
   # datos_brutos <- read.csv(data_file[1])
    #print(head(datos_brutos))  # Mostrar las primeras filas de los datos
#  } else {
#    stop("No se encontró un archivo CSV en el archivo descargado")
#  }
#}, error = function(e) {
  # En caso de error, cargar los datos locales
#  message("Error en la descarga o procesamiento de los datos del ESS. Cargando datos locales...")
#  datos_brutos <- read_csv("Datos_brutos_Reto2.csv")
#  print(head(datos_brutos))  # Mostrar las primeras filas de los datos locales
#})

