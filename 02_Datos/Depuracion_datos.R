#ANALIZAMOS TODOS LOS DATOS DESCARGADOS

##VISUALIZAR LAS VARIABLES SELECCIONADAS

colnames(datos_brutos)

##AGRUPAR VARIABLES QUE EN DISTINTAS RONDAS HAN TENIDO NOMBRES DIFERENTES

# Fusionar las columnas age y agea en una nueva columna llamada ages
datos <- datos_brutos %>%
  mutate(ages = coalesce(age, agea))

# Eliminar las columnas originales
datos <- datos %>%
  select(-age, -agea)

# Fusionar las columnas regiones y regioaes en una nueva columna llamada region
datos <- datos %>%
  mutate(region = coalesce(regiones, regioaes))

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
datos_panel <- subset(datos, select = c("essround","gndr", "agea", "emplrel", "happy","health", "aesfdrk", "regiones"))

#Eliminamos los datos faltantes
datos_panel<- na.omit(datos_panel)

# Seleccionamos solo las columnas numéricas
datos_numericos <- datos_panel %>% select_if(is.numeric)

# Creamos la tabla descriptiva
datos_panel_Des <- describe(datos_numericos)

# Mostramos la tabla descriptiva
print(datos_panel_Des)
