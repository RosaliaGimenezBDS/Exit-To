#Creamos un subset de los datos con los que queremos/podemos trabajar dado el tiempo disponible

# Existen otras variables muy interesantes relacionadas con Educación y Empleo que por el momento no sabemos-podemos preprocesar. 
# Elegimos un subset de datos sencillo, ya planteado en el RETO 1, y si disponemos de más tiempo ampliaremos el alcance del proyecto


##Variables seleccionadas

##datos_panel <- subset(datos, select = c("gndr", "yrbrn", "agea","regiones", "edulvla", "emplrel","isco08", "happy","health", "aesfdrk"))
datos_panel <- subset(datos, select = c("essround","year","gndr", "ages", "emplrel", "happy","health", "aesfdrk", "region"))

#Eliminamos los datos faltantes
#datos_panel<- na.omit(datos_panel)

# Seleccionamos solo las columnas numéricas
datos_numericos <- datos_panel %>% select_if(is.numeric)

# Creamos la tabla descriptiva
datos_panel_Des <- describe(datos_numericos)

# Mostramos la tabla descriptiva
print(datos_panel_Des)
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
    RONDA_ESS = essround,
    GENERO = gndr,
    FELICIDAD = happy,
    SALUD = health,
    REGION= region,
    YEAR=year
  )

descr(datos_filtrados)

# Crear dos subconjuntos de datos
datosF_con_region <- datos_filtrados %>% filter(!is.na(REGION))
datosF_sin_region <- datos_filtrados %>% filter(is.na(REGION))
