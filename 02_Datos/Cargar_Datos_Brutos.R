#---
#  title: "REPRODUCIBILIDAD de PROYECTOS DE CIENCIA DE DATOS reto 2"
#author: ROSALIA GIMENEZ MILLAN (21615274/25393948Q)
#output: html_notebook
#---
  

#CARGAMOS LA BASE DE DATOS CON UNA SELECCION AMPLIA DE DATOS QUE NOS PARECEN INTERESANTES
#En este script podríamos añadir en el futuro una conexión mediante API a ESS para mantener los datos actualizados con nuevas rondas

library(readr)
library(curl)

show_col_types = FALSE

datos_brutos <- read_csv("ESS1e06_7-ESS2e03_6-ESS3e03_7-ESS4e04_6-ESS5e03_5-ESS6e02_6-ESS7e02_3-ESS8e02_3-ESS9e03_2-ESS10SC-subset.csv")


