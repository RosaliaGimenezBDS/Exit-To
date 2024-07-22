#ANALIZAMOS TODOS LOS DATOS DESCARGADOS Y DEPURAMOS LOS DATOS HASTA LLEGAR A UN PEQUEÑO SET DE DATOS
#REDUCIMOS LOS DATOS PARA QUE SEAN MÁS MANEJABLES EN EL EJERCICIO Y CREAMOS UN FICHERO CON ESE PEQUEÑO SET DE DATOS QUE CARGAREMOS EN EL PANEL
#TRAS AVANZAR EN EL PROYECTO, DECIDIMOS CREAR UN SET DE DATOS REPRESENTADOS NUMÉRICAMENTES Y OTRO CON LOS DATOS CATEGORICOS FACTORIZADOS

library(dplyr)
library(readr)
library(ggplot2)
library(readr)
library(curl)
library(psych)
show_col_types = FALSE

#EN EL FICHERO ANTERIOR CARGAMOS LA BASE DE DATOS CON UNA SELECCION AMPLIA DE DATOS QUE NOS PARECEN INTERESANTES
#AQUÍ REALIZAMOS UNA SELECCIÓN TRAS EL ANALISIS DESCRIPTIVO EXPLORATORIO PARA FAMILIARIZARNOS Y DEPURAR LOS DATOS
#datos_brutos <- read_csv("ESS1e06_7-ESS2e03_6-ESS3e03_7-ESS4e04_6-ESS5e03_5-ESS6e02_6-ESS7e02_3-ESS8e02_3-ESS9e03_2-ESS10SC-subset.csv")

## VISUALIZAR LAS VARIABLES SELECCIONADAS

#colnames(datos_brutos)

## AGRUPACIÓN DE VARIABLES QUE EN DISTINTAS RONDAS HAN TENIDO NOMBRES DIFERENTES

# Fusionar las columnas age y agea en una nueva columna llamada ages
datos <- datos_brutos %>%
  mutate(ages = coalesce(age, agea))

# Fusionar las columnas regiones y regioaes en una nueva columna llamada region
#Detectamos que en estas columnas hay muchos datos faltantes, usamos un gráfico para visualizar en qué rondas sí disponemos de datos

datos <- datos %>%
  mutate(region = coalesce(regiones, regioaes))

#Añadir una columna con el año correspondiente a cada ronda para utilizarlo en el análisis en el Panel
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

# Crear SUBCONJUNTOS de datos - borrar?
#datos_con_region <- datos %>% filter(!is.na(region))
#datos_sin_region <- datos %>% filter(is.na(region))



# Listar las ediciones (essround) que tienen datos de regiones
#ediciones_con_region <- datos_con_region %>%
#  distinct(essround,year) %>%
#  arrange(essround)

# Listar las ediciones (essround) que no tienen datos de regiones
#ediciones_sin_region <- datos_sin_region %>%
#  distinct(essround,year) %>%
#  arrange(essround)

# Mostrar el listado de ediciones
#print(ediciones_con_region)

# Existen otras variables muy interesantes relacionadas con Educación y Empleo que por el momento no sabemos-podemos preprocesar. 
# Elegimos un subset de datos sencillo, ya planteado en el RETO 1, y si disponemos de más tiempo ampliaremos el alcance del proyecto
#colnames(datos)

## REVISAMOS LAS CARACTERÍSTICAS DE LAS VARIABLES NUMERICAS

# Seleccionamos solo las columnas numéricas
#datos_numericos <- datos %>% select_if(is.numeric)

# Creamos la tabla descriptiva
#datos_panel_Des <- describe(datos_numericos)

# Mostramos la tabla descriptiva
#print(datos_panel_Des)

#Creamos un subset de los datos con los que queremos/podemos trabajar dado el tiempo disponible

# Existen otras variables muy interesantes relacionadas con Educación y Empleo que por el momento no sabemos-podemos preprocesar. 
# Elegimos un subset de datos sencillo, ya planteado en el RETO 1, y si disponemos de más tiempo ampliaremos el alcance del proyecto

##datos_panel contiene las Variables seleccionadas para el proyecto con todos los valores incluidos outliers

##datos_panel <- subset(datos, select = c("gndr", "yrbrn", "agea","regiones", "edulvla", "emplrel","isco08", "happy","health", "aesfdrk"))
##datos_panel <- subset(datos, select = c("essround","year","gndr", "ages", "emplrel", "happy","health", "aesfdrk", "region"))
datos_panel <- subset(datos, select = c("year","gndr", "ages", "emplrel", "happy","health", "aesfdrk", "region"))

#Antes de calcular las medias hay que eliminar los outliers de las columnas happy, health y aesfdrk
#Filtramos los datos
#datos_panel_filtrados contiene todas las variables pero sin los outliers y con nombres de variables más significativos (dejamos YEAR por miedo a la Ñ)
datos_panel_filtrados <- filter(datos_panel, happy <= 10)
datos_panel_filtrados <- filter(datos_panel_filtrados, emplrel <= 3)
datos_panel_filtrados <- filter(datos_panel_filtrados, ages <= 70)
datos_panel_filtrados <- filter(datos_panel_filtrados, gndr != 9)
datos_panel_filtrados <- filter(datos_panel_filtrados, aesfdrk<=4)
datos_panel_filtrados <- filter(datos_panel_filtrados, health <= 5)

# Renombrar las columnas del subconjunto
datos_panel_filtrados <- datos_panel_filtrados %>%
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

#Por ahora no eliminamos los datos faltantes
#datos_panel<- na.omit(datos_panel)

# Seleccionamos solo las columnas numéricas
#datos_numericos <- datos_panel %>% select_if(is.numeric)

# Creamos la tabla descriptiva que mostraremos en el panel
datos_panel_Des <- describe(datos_panel_filtrados)

# Mostramos la tabla descriptiva
#print(datos_panel_Des)

# Crear SUBCONJUNTOS de datos filtrados con o sin region
#datosF_con_region <- datos_panel_filtrados %>% filter(!is.na(REGION))
#datosF_sin_region <- datos_panel_filtrados %>% filter(is.na(REGION))

#Para mejorar la visualización de los datos en la tabla transformamos datos numéricos en su correspondiente categoría
#datos_tabla contiene los datos para las tablas del panel ya que están en formato categórico, sin outliers

datos_tabla<- datos_panel_filtrados

# Convertir la columna 'genero' a categórico con etiquetas 'Hombre' y 'Mujer'
datos_tabla$GENERO <- factor(datos_panel_filtrados$GENERO, 
                       levels = c(1, 2), 
                       labels = c("Hombre", "Mujer"))

# Convertir la columna 'rel_laboral' a categórico con etiquetas 'Empleado', 'Autónomo' y 'Negocio familiar'
datos_tabla$REL_LABORAL <- factor(datos_panel_filtrados$REL_LABORAL, 
                            levels = c(1, 2, 3), 
                            labels = c("Empleado", "Autónomo", "Negocio familiar"))

# Convertir la columna 'Salud' a categórico con etiquetas 'Muy buena', 'Buena', 'Normal', 'Mala' y 'Muy mala'
datos_tabla$SALUD <- factor(datos_panel_filtrados$SALUD, 
                                  levels = c(1, 2, 3,4,5), 
                                  labels = c("Muy buena", "Buena", "Normal", "Mala", "Muy mala"))

# Convertir la columna 'Seguridad' a categórico con etiquetas 'Muy seguro', 'Seguro', 'Inseguro' y 'Muy inseguro'
datos_tabla$SEGURIDAD <- factor(datos_panel_filtrados$SEGURIDAD, 
                            levels = c(1, 2, 3,4), 
                            labels = c("Muy seguro", "Seguro", "Inseguro", "Muy inseguro"))

# Los datos de FELICIDAD inicialmente los dejamos en la escala numérica, pero finalmente tmb los categorizamos de '0 extremadamente infeliz a 10 extremadamente feliz'
datos_tabla$FELICIDAD <- factor(datos_panel_filtrados$FELICIDAD, 
                                levels = c(0,1, 2, 3,4,5,6,7,8,9,10), 
                                labels = c("Extremadamente infeliz","1","2","3","4","5","6","7","8","9","Extremadamente Feliz"))


#Convertir la columna 'Región' a categórica con sus etiquetas correspondientes
datos_tabla$REGION <- factor(datos_tabla$REGION, 
                       levels = c(11, 12, 13, 21, 22, 23, 24, 30, 41, 42, 43, 51, 52, 53, 61, 62, 63, 64, 70), 
                       labels = c("Galicia", "Principado de Asturias", "Cantabria", "País Vasco", 
                                  "Comunidad Foral de Navarra", "La Rioja", "Aragón", "Comunidad de Madrid", 
                                  "Castilla y León", "Castilla-La Mancha", "Extremadura", "Cataluña", 
                                  "Comunidad Valenciana", "Illes Balears", "Andalucía", "Región de Murcia", 
                                  "Ciudad Autónoma de Ceuta", "Ciudad Autónoma de Melilla", "Canarias"))



## TRATAMIENTOS DESCRIPTIVOS DE LOS DATOS

# Crear la tabla con las medias de las variables agrupadas por año
medias_por_year <- datos_panel_filtrados %>%
  group_by(YEAR) %>%
  summarise(
    MEDIA_FELICIDAD = mean(FELICIDAD, na.rm = TRUE),
    MEDIA_SALUD = mean(SALUD, na.rm = TRUE),
    MEDIA_SEGURIDAD = mean(SEGURIDAD, na.rm = TRUE)
  )

# Crear la tabla con las medias de las variables agrupadas por region 
medias_por_region_year <- datos_panel_filtrados %>%
  group_by(REGION) %>%
  summarise(
    MEDIA_FELICIDAD = mean(FELICIDAD, na.rm = TRUE),
    MEDIA_SALUD = mean(SALUD, na.rm = TRUE),
    MEDIA_SEGURIDAD = mean(SEGURIDAD, na.rm = TRUE)
  )

# Crear la tabla con las medias de las variables agrupadas por region y año
medias_por_region_year <- datos_panel_filtrados %>%
  group_by(REGION, YEAR) %>%
  summarise(
    MEDIA_FELICIDAD = round(mean(FELICIDAD, na.rm = TRUE),2),
    MEDIA_SALUD = round(mean(SALUD, na.rm = TRUE),2),
    MEDIA_SEGURIDAD = round(mean(SEGURIDAD, na.rm = TRUE),2)
  )

#Convertir la columna 'Región' a categórica con sus etiquetas correspondientes
medias_por_region_year$REGION <- factor(medias_por_region_year$REGION, 
                                        levels = c(11, 12, 13, 21, 22, 23, 24, 30, 41, 42, 43, 51, 52, 53, 61, 62, 63, 64, 70), 
                                        labels = c("Galicia", "Principado de Asturias", "Cantabria", "País Vasco", 
                                                   "Comunidad Foral de Navarra", "La Rioja", "Aragón", "Comunidad de Madrid", 
                                                   "Castilla y León", "Castilla-La Mancha", "Extremadura", "Cataluña", 
                                                   "Comunidad Valenciana", "Illes Balears", "Andalucía", "Región de Murcia", 
                                                   "Ciudad Autónoma de Ceuta", "Ciudad Autónoma de Melilla", "Canarias"))



#Al disponer de muchos datos, el PANEL tiene dificultades para tratar datos_panel_filtrados en las tablas dinámicas, 
#reduzco el tamaño a los DATOS CON REGION

# Crear SUBCONJUNTOS de datos con nombres significativos con los que trabajar en el PANEL

#Para gráficos, por si acaso
datos_tabla_region_numericos<- datos_panel_filtrados %>% filter(!is.na(REGION))

#Para mostrar en tablas
datos_tabla_region_categoricos<- datos_tabla %>% filter(!is.na(REGION))

# Convertir a DataFrame si es necesario
datos_tabla_informe <- as.data.frame(datos_tabla_region_numericos)

write_csv(datos_tabla_informe, "datos_tabla_informe.csv")


#write_csv(datos_con_region, "datos_con_region.csv")
#write_csv(datos_sin_region, "datos_sin_region.csv")
#write_csv(datos_panel, "datos_panel.csv")
#write_csv(datos_panel_filtrados, "datos_panel_filtrados.csv")
#write_csv(datos_panel_Des, "datos_panel_Des.csv")
#write_csv(datosF_con_region, "datosF_con_region.csv")
#write_csv(datosF_sin_region, "datosF_sin_region.csv")
#write_csv(datos_tabla, "datos_tabla.csv")
#write_csv(datos_tabla_region, "datos_tabla_region.csv")
