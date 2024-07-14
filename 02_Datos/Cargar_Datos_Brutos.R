#---
#  title: "REPRODUCIBILIDAD de PROYECTOS DE CIENCIA DE DATOS reto 2"
#author: ROSALIA GIMENEZ MILLAN (21615274/25393948Q)
#output: html_notebook
#---
  


#CARGAMOS LA BASE DE DATOS CON UNA SELECCION AMPLIA DE DATOS QUE NOS PARECEN INTERESANTES
#REALIZAMOS UN ANALISIS DESCRIPTIVO EXPLORATORIO PARA FAMILIARIZARNOS Y DEPURAR LOS DATOS

#ACTUALMENTE CARGAMOS LOS DATOS EN LOCAL *** INTENTAR CARGAR LOS DATOS DIRECTAMENTE DESDE LA WEB DEL ESS

library(readr)

# CARGA PAQUETES PARA DEPURAR BBDD Y FUNCIONES AUXILIARES

### AÑADIR UN COMENTARIO SOBRE CADA PACKAGE INDICANDO PARA QUÉ SE USA

pkgs2use<- c('tidyverse','readxl')

inst.load.pkg <- function(pkg){ 
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}
invisible(lapply(pkgs2use,inst.load.pkg))
rm(pkgs2use,inst.load.pkg)

# Si no está instalado el paquete forcats, se instala y carga; en caso contrario únicamente se carga...
if(!require(forcats)){install.packages('forcats')
  library(forcats)
}
# Si no está instalado el paquete HistData, se instala y carga; en caso contrario únicamente se carga...
if(!require(HistData)){install.packages('HistData')
  library(HistData)
}
# Si no está instalado el paquete psych, se instala y carga; en caso contrario únicamente se carga...
if(!require(psych)){install.packages('pysch')
  library(psych)
}
# Si no está instalado el paquete summarytools, se instala y carga; en caso contrario únicamente se carga...
if(!require(summarytools)){install.packages('summarytools')
  library(summarytools)
}
# Si no está instalado el paquete ggplot2, se instala y carga; en caso contrario únicamente se carga...
if(!require(ggplot2)){install.packages('ggplot2')
  library(ggplot2)
}
# Si no está instalado el paquete patchwork, se instala y carga; en caso contrario únicamente se carga...
if(!require(patchwork)){install.packages('patchwork')
  library(patchwork)
}
if(!require(RcmdrMisc)) install.packages('RcmdrMisc')
library(RcmdrMisc)

if(!require(leaps)) install.packages('leaps')
library(leaps)

if(!require(ROCR)) {install.packages("ROCR")
  require(ROCR)}

if(!require(DescTools)) {install.packages("DescTools")
  require(DescTools)}

if(!require(effects)) {install.packages("effects")
  require(effects)}

if(!require(car)) {install.packages("car")
  require(car)}

if(!require(Hmisc)) {install.packages("Hmisc")
  require(Hmisc)}

if(!require(curl)) {install.packages("curl")
  require(curl)}

library(curl)

# URL del conjunto de datos
url <- "https://stessdissprodwe.blob.core.windows.net/data/download/4/generate_datafile/a9e7e889540fa08a80265e0f0045377f.zip?st=2024-07-14T20%3A43%3A43Z&se=2024-07-14T21%3A45%3A43Z&sp=r&sv=2023-11-03&sr=b&skoid=1b26ad26-8999-4f74-9562-ad1c57749956&sktid=93a182aa-d7bd-4a74-9fb1-84df14cae517&skt=2024-07-14T20%3A43%3A43Z&ske=2024-07-14T21%3A45%3A43Z&sks=b&skv=2023-11-03&sig=rCnF7EcdRqWeZ6e3%2BUO8O%2BSq7cOicwNbeTycsPO8AoU%3D"

# Nombre del archivo donde se guardará el conjunto de datos
destfile <- "datos_ess.zip"

# Descargar el archivo
curl_download(url, destfile)

# Descomprimir el archivo (si es un archivo comprimido)
unzip(destfile, exdir = "datos_ess")

# Listar los archivos descomprimidos
files <- list.files("datos_ess", full.names = TRUE)
print(files)

# Cargar datos CSV
data_file <- files[grepl("\\.csv$", files)]  # Filtra archivos CSV

if (length(data_file) > 0) {
  datos_brutos <- read.csv(data_file[1])
  print(head(datos_brutos))  # Mostrar las primeras filas de los datos
} else {
  stop("No se encontró un archivo CSV en el archivo descargado")
  #Cargamos la libreria readr para poder cargar los datos 
  datos_brutos<-read_csv("Datos_brutos_Reto2.csv")
}

