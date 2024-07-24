# Cargar paquetes necesarios
if (!require("dplyr")) install.packages("dplyr", dependencies = TRUE)
if (!require("ggplot2")) install.packages("ggplot2", dependencies = TRUE)
if (!require("car")) install.packages("car", dependencies = TRUE)
if (!require("nnet")) install.packages("nnet", dependencies = TRUE)

library(dplyr)
library(ggplot2)
library(car)
library(nnet)

# Supongamos que tus datos están en un dataframe llamado `datos`
# Filtrar las columnas necesarias
datos_panel <- datos %>% select(year, gndr, ages, emplrel, happy, health, aesfdrk, region)

# Convertir las variables categóricas a factores
datos_panel <- datos_panel %>%
  mutate(
    emplrel = as.factor(emplrel),
    happy = as.numeric(happy),
    health = as.numeric(health),
    aesfdrk = as.factor(aesfdrk)
  )

# Resumir los datos
summary(datos_panel)

# Regresión lineal para happy
modelo_happy <- lm(happy ~ emplrel + gndr + ages + region, data = datos_panel)
summary(modelo_happy)

# Regresión lineal para health
modelo_health <- lm(health ~ emplrel + gndr + ages + region, data = datos_panel)
summary(modelo_health)

# Regresión logística multinomial para aesfdrk
modelo_aesfdrk <- multinom(aesfdrk ~ emplrel + gndr + ages + region, data = datos_panel)
summary(modelo_aesfdrk)
