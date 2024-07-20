#ANALIZAMOS TODOS LOS DATOS DESCARGADOS Y DEPURAMOS LOS DATOS HASTA LLEGAR A UN PEQUEÑO SET DE DATOS
#REDUCIMOS LOS DATOS PARA QUE SEAN MÁS MANEJABLES EN EL EJERCICIO Y CREAMOS UN FICHERO CON ESE PEQUEÑO SET DE DATOS
#QUE CARGAREMOS EN EL PANEL

library(dplyr)
library(readr)
library(ggplot2)
library(readr)
library(curl)
show_col_types = FALSE

#CARGAMOS LA BASE DE DATOS CON UNA SELECCION AMPLIA DE DATOS QUE NOS PARECEN INTERESANTES
#REALIZAMOS UN ANALISIS DESCRIPTIVO EXPLORATORIO PARA FAMILIARIZARNOS Y DEPURAR LOS DATOS
#datos_brutos <- read_csv("ESS1e06_7-ESS2e03_6-ESS3e03_7-ESS4e04_6-ESS5e03_5-ESS6e02_6-ESS7e02_3-ESS8e02_3-ESS9e03_2-ESS10SC-subset.csv")

##VISUALIZAR LAS VARIABLES SELECCIONADAS

#colnames(datos_brutos)

##AGRUPAR VARIABLES QUE EN DISTINTAS RONDAS HAN TENIDO NOMBRES DIFERENTES

# Fusionar las columnas age y agea en una nueva columna llamada ages
datos <- datos_brutos %>%
  mutate(ages = coalesce(age, agea))

# Fusionar las columnas regiones y regioaes en una nueva columna llamada region
#Detectamos que en estas columnas hay muchos datos faltantes, usamos un gráfico para visualizar en qué rondas sí disponemos de datos

datos <- datos %>%
  mutate(region = coalesce(regiones, regioaes))

#Vamos a añadir una columna con el año correspondiente a la ronda para utilizarlo en el análisis
# Crear un data frame con la correspondencia entre rondas y años
ess_rounds <- data.frame(
  essround = 1:11,
  year = c(2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016, 2018, 2020, 2022)
)

# Hacemos un join para añadir la columna 'year' a 'datos'
datos <- datos %>%
  left_join(ess_rounds, by = "essround")

# Ahora 'datos' tiene una nueva columna 'year' correspondiente a cada ronda
#print(head(datos))

# Crear SUBCONJUNTOS de datos
datos_con_region <- datos %>% filter(!is.na(region))
datos_sin_region <- datos %>% filter(is.na(region))

# Listar las ediciones (essround) que tienen datos de regiones
ediciones_con_region <- datos_con_region %>%
  distinct(essround,year) %>%
  arrange(essround)

# Listar las ediciones (essround) que no tienen datos de regiones
ediciones_sin_region <- datos_sin_region %>%
  distinct(essround,year) %>%
  arrange(essround)

# Mostrar el listado de ediciones
#print(ediciones_con_region)


# Existen otras variables muy interesantes relacionadas con Educación y Empleo que por el momento no sabemos-podemos preprocesar. 
# Elegimos un subset de datos sencillo, ya planteado en el RETO 1, y si disponemos de más tiempo ampliaremos el alcance del proyecto
#colnames(datos)

#REVISAMOS LAS CARACTERÍSTICAS DE LAS VARIABLES NUMERICAS

# Seleccionamos solo las columnas numéricas
#datos_numericos <- datos %>% select_if(is.numeric)

# Creamos la tabla descriptiva
#datos_panel_Des <- describe(datos_numericos)

# Mostramos la tabla descriptiva
#print(datos_panel_Des)

#Creamos un subset de los datos con los que queremos/podemos trabajar dado el tiempo disponible

# Existen otras variables muy interesantes relacionadas con Educación y Empleo que por el momento no sabemos-podemos preprocesar. 
# Elegimos un subset de datos sencillo, ya planteado en el RETO 1, y si disponemos de más tiempo ampliaremos el alcance del proyecto

##Variables seleccionadas

##datos_panel <- subset(datos, select = c("gndr", "yrbrn", "agea","regiones", "edulvla", "emplrel","isco08", "happy","health", "aesfdrk"))
##datos_panel <- subset(datos, select = c("essround","year","gndr", "ages", "emplrel", "happy","health", "aesfdrk", "region"))
datos_panel <- subset(datos, select = c("year","gndr", "ages", "emplrel", "happy","health", "aesfdrk", "region"))

#Antes de calcular las medias hay que eliminar los outliers de las columnas happy, health y aesfdrk
#Filtramos los datos
datos_filtrados <- filter(datos_panel, happy <= 10)
datos_filtrados <- filter(datos_filtrados, emplrel <= 3)
datos_filtrados <- filter(datos_filtrados, ages <= 70)
datos_filtrados <- filter(datos_filtrados, gndr != 9)
datos_filtrados <- filter(datos_filtrados, aesfdrk<=4)
datos_filtrados <- filter(datos_filtrados, health <= 5)

# Renombrar las columnas del subconjunto
datos_filtrados <- datos_filtrados %>%
  rename(
    SEGURIDAD = aesfdrk,
    EDAD = ages,
    REL_LABORAL = emplrel,
    GENERO = gndr,
    FELICIDAD = happy,
    SALUD = health,
    REGION= region,
    YEAR=year
  )


# Crear la tabla con las medias de las variables agrupadas por año
medias_por_ano <- datos_filtrados %>%
  group_by(YEAR) %>%
  summarise(
    MEDIA_FELICIDAD = mean(FELICIDAD, na.rm = TRUE),
    MEDIA_SALUD = mean(SALUD, na.rm = TRUE),
    MEDIA_SEGURIDAD = mean(SEGURIDAD, na.rm = TRUE)
  )

# Crear la tabla con las medias de las variables agrupadas por region
medias_por_region <- datos_filtrados %>%
  group_by(REGION) %>%
  summarise(
    MEDIA_FELICIDAD = mean(FELICIDAD, na.rm = TRUE),
    MEDIA_SALUD = mean(SALUD, na.rm = TRUE),
    MEDIA_SEGURIDAD = mean(SEGURIDAD, na.rm = TRUE)
  )

#Por ahora no eliminamos los datos faltantes
#datos_panel<- na.omit(datos_panel)

# Seleccionamos solo las columnas numéricas
#datos_numericos <- datos_panel %>% select_if(is.numeric)

# Creamos la tabla descriptiva que mostraremos en el panel
datos_panel_Des <- describe(datos_filtrados)

# Mostramos la tabla descriptiva
#print(datos_panel_Des)

# Guardar los subconjuntos en archivos CSV para tenerlos disponibles más facilmente desde el panel si fuese necesario
write_csv(datos_con_region, "datos_con_region.csv")
write_csv(datos_sin_region, "datos_sin_region.csv")
write_csv(datos_panel, "datos_panel.csv")
write_csv(datos_filtrados, "datos_filtrados.csv")
write_csv(datos_panel_Des, "datos_panel_Des.csv")
