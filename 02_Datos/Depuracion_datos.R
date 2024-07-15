#ANALIZAMOS TODOS LOS DATOS DESCARGADOS

library(dplyr)
library(readr)
library(ggplot2)

##VISUALIZAR LAS VARIABLES SELECCIONADAS

colnames(datos_brutos)

##AGRUPAR VARIABLES QUE EN DISTINTAS RONDAS HAN TENIDO NOMBRES DIFERENTES

# Fusionar las columnas age y agea en una nueva columna llamada ages
datos <- datos_brutos %>%
  mutate(ages = coalesce(age, agea))

# Eliminar las columnas originales
#datos <- datos %>%
 # select(-age, -agea)

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
print(head(datos))


# Crear dos subconjuntos de datos
datos_con_region <- datos %>% filter(!is.na(region))
datos_sin_region <- datos %>% filter(is.na(region))

# Listar las ediciones (essround) que tienen datos de regiones
ediciones_con_region <- datos_con_region %>%
  distinct(essround) %>%
  arrange(essround)

# Mostrar el listado de ediciones
print(ediciones_con_region)

# Guardar los subconjuntos en archivos CSV (opcional)
write_csv(datos_con_region, "datos_con_region.csv")
write_csv(datos_sin_region, "datos_sin_region.csv")

# Crear el gráfico de disponibilidad de datos por ESS round y edition
# Resumir la disponibilidad de datos por essround y edition
resumen_datos <- datos %>%
  group_by(essround, edition) %>%
  summarise(datos_disponibles = sum(!is.na(region), na.rm = TRUE), .groups = 'drop')

# Crear el gráfico
ggplot(resumen_datos, aes(x = edition, y = factor(essround), fill = datos_disponibles > 0)) +
  geom_tile(color = "white") +
  scale_fill_manual(values = c("TRUE" = "green", "FALSE" = "red"), labels = c("TRUE" = "Disponible", "FALSE" = "No disponible")) +
  labs(title = "Disponibilidad de Datos por ESS Round y Edition",
       x = "Edition",
       y = "ESS Round",
       fill = "Datos") +
  theme_minimal()


# Eliminar las columnas originales
datos <- datos %>%
  select(-regiones, -regioaes)

# Existen otras variables muy interesantes relacionadas con Educación y Empleo que por el momento no sabemos-podemos preprocesar. 
# Elegimos un subset de datos sencillo, ya planteado en el RETO 1, y si disponemos de más tiempo ampliaremos el alcance del proyecto

colnames(datos)

#REVISAMOS LAS CARACTERÍSTICAS DE LAS VARIABLES NUMERICAS

# Seleccionamos solo las columnas numéricas
datos_numericos <- datos %>% select_if(is.numeric)

# Creamos la tabla descriptiva
datos_panel_Des <- describe(datos_numericos)

# Mostramos la tabla descriptiva
print(datos_panel_Des)

#Creamos un subset de los datos con los que queremos/podemos trabajar dado el tiempo disponible

# Existen otras variables muy interesantes relacionadas con Educación y Empleo que por el momento no sabemos-podemos preprocesar. 
# Elegimos un subset de datos sencillo, ya planteado en el RETO 1, y si disponemos de más tiempo ampliaremos el alcance del proyecto


##Variables seleccionadas

##datos_panel <- subset(datos, select = c("gndr", "yrbrn", "agea","regiones", "edulvla", "emplrel","isco08", "happy","health", "aesfdrk"))
datos_panel <- subset(datos, select = c("essround","year","gndr", "ages", "emplrel", "happy","health", "aesfdrk", "region"))

#Por ahora no eliminamos los datos faltantes
#datos_panel<- na.omit(datos_panel)

# Seleccionamos solo las columnas numéricas
datos_numericos <- datos_panel %>% select_if(is.numeric)

# Creamos la tabla descriptiva
datos_panel_Des <- describe(datos_numericos)

# Mostramos la tabla descriptiva
print(datos_panel_Des)
