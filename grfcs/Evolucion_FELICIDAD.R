if (!require("ggplot2")) install.packages("ggplot2", dependencies = TRUE)
if (!require("dplyr")) install.packages("dplyr", dependencies = TRUE)
if (!require("tidyr")) install.packages("tidyr", dependencies = TRUE)

library(dplyr)
library(tidyr)
library(ggplot2)

# Supongamos que tus datos están en un dataframe llamado `datos_panel_filtrados`
# y tienen las columnas `YEAR` (años del ESS) y `FELICIDAD` (niveles de felicidad).

# Transformamos los datos en el formato necesario
datos_aggregados <- datos_panel_filtrados %>%
  group_by(YEAR, FELICIDAD) %>%
  summarise(count = n()) %>%
  ungroup()

# Aseguramos que los niveles de felicidad están en el orden correcto y que están todos presentes
datos_aggregados <- datos_aggregados %>%
  mutate(FELICIDAD = factor(FELICIDAD, levels = c(0:10), 
                            labels = c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "Extremadamente feliz")))

# Convertimos a un formato ancho
datos_wide <- datos_aggregados %>%
  pivot_wider(names_from = FELICIDAD, values_from = count, values_fill = list(count = 0))

# Preparamos los datos para el gráfico de área apilada
datos_area <- datos_wide %>%
  pivot_longer(cols = -YEAR, names_to = "FELICIDAD", values_to = "count")

# Ordenamos los niveles de felicidad de manera que los niveles más bajos estén en la parte inferior del gráfico
datos_area <- datos_area %>%
  mutate(FELICIDAD = factor(FELICIDAD, levels = rev(levels(factor(datos_area$FELICIDAD)))))

# Graficamos el área apilada
ggplot(datos_area, aes(x = YEAR, y = count, fill = FELICIDAD)) +
  geom_area() +
  scale_fill_brewer(palette = "Spectral", direction = -1) +
  labs(title = "Evolución de la Felicidad en los años del ESS",
       x = "Año",
       y = "Frecuencia",
       fill = "Nivel de Felicidad") +
  theme_minimal()




### Evolución de la Salud

```{r}

if (!require("ggplot2")) install.packages("ggplot2", dependencies = TRUE)
if (!require("dplyr")) install.packages("dplyr", dependencies = TRUE)
if (!require("tidyr")) install.packages("tidyr", dependencies = TRUE)

library(dplyr)
library(tidyr)
library(ggplot2)



# Transformamos los datos en el formato necesario
datos_agggregados <- datos_panel_filtrados %>%
  group_by(YEAR, SALUD) %>%
  summarise(count = n()) %>%
  ungroup()

# Aseguramos que los niveles de felicidad están en el orden correcto y que están todos presentes
datos_agggregados <- datos_agggregados %>%
  mutate(FELICIDAD = factor(FELICIDAD, levels = c(1:5), 
                            labels = c("Muy buena", "Buena", "Normal", "Mala", "Muy mala")))

# Convertimos a un formato ancho
datos_wwide <- datos_agggregados %>%
  pivot_wider(names_from = SALUD, values_from = count, values_fill = list(count = 0))

# Preparamos los datos para el gráfico de área apilada
datos_aarea <- datos_wwide %>%
  pivot_longer(cols = -YEAR, names_to = "SALUD", values_to = "count")

# Ordenamos los niveles de felicidad de manera que los niveles más bajos estén en la parte inferior del gráfico
#datos_area <- datos_area %>%
#  mutate(SALUD = factor(SALUD, levels = rev(levels(factor(datos_area$SALUD)))))

# Graficamos el área apilada
ggplot(datos_aarea, aes(x = YEAR, y = count, fill = SALUD)) +
  geom_area() +
  #  scale_fill_brewer(palette = "Spectral", direction = -1) +
  scale_fill_brewer(palette = "Spectral") +
  labs(title = "Evolución de la salud en los años del ESS",
       x = "Año",
       y = "Frecuencia",
       fill = "Nivel de Salud") +
  theme_minimal()

```

### Evolución de la Seguridad

```{r}


if (!require("ggplot2")) install.packages("ggplot2", dependencies = TRUE)
if (!require("dplyr")) install.packages("dplyr", dependencies = TRUE)
if (!require("tidyr")) install.packages("tidyr", dependencies = TRUE)

library(dplyr)
library(tidyr)
library(ggplot2)



# Transformamos los datos en el formato necesario
datoss_aggregados <- datos_panel_filtrados %>%
  group_by(YEAR, SEGURIDAD) %>%
  summarise(count = n()) %>%
  ungroup()

# Aseguramos que los niveles de felicidad están en el orden correcto y que están todos presentes
datoss_aggregados <- datoss_aggregados %>%
  mutate(SEGURIDAD = factor(SEGURIDAD, levels = c(1:4), 
                            labels = c("Muy seguro", "Seguro", "Inseguro", "Muy Inseguro")))

# Convertimos a un formato ancho
datoss_wide <- datoss_aggregados %>%
  pivot_wider(names_from = SEGURIDAD, values_from = count, values_fill = list(count = 0))

# Preparamos los datos para el gráfico de área apilada
datoss_area <- datoss_wide %>%
  pivot_longer(cols = -YEAR, names_to = "SEGURIDAD", values_to = "count")

# Ordenamos los niveles de felicidad de manera que los niveles más bajos estén en la parte inferior del gráfico
#datos_area <- datos_area %>%
#  mutate(SALUD = factor(SALUD, levels = rev(levels(factor(datos_area$SALUD)))))

# Graficamos el área apilada
ggplot(datoss_area, aes(x = YEAR, y = count, fill = SEGURIDAD)) +
  geom_area() +
  #  scale_fill_brewer(palette = "Spectral", direction = -1) +
  scale_fill_brewer(palette = "Spectral") +
  labs(title = "Evolución de la salud en los años del ESS",
       x = "Año",
       y = "Frecuencia",
       fill = "Nivel de Seguridad") +
  theme_minimal()

```



##HISTOGRAMA DE LA FELICIDAD

```{r}

#install.packages("ggplot2")

# Crear etiquetas para los valores de la variable 'FELICIDAD'
categorias_FELICIDAD <- c("Extremadamente infeliz", "1", "2", "3", "4", "5", "6", "7", "8", "9", "Extremadamente feliz")

# Calcular las frecuencias absolutas
frecuencias_absolutas <- table(datos_panel_filtrados$FELICIDAD)

# Calcular las frecuencias relativas
frecuencias_relativas <- prop.table(frecuencias_absolutas)

# Crear una tabla de frecuencias
tabla_frecuencias <- data.frame(
  Valor = names(frecuencias_absolutas),
  Categoria = categorias_FELICIDAD[as.numeric(names(frecuencias_absolutas)) + 1],
  Frecuencia_Absoluta = as.vector(frecuencias_absolutas),
  Frecuencia_Relativa = round(as.vector(frecuencias_relativas), 2)
)

# Ordenar la tabla por el valor original de 'FELICIDAD'
tabla_frecuencias <- tabla_frecuencias %>%
  arrange(as.numeric(Valor))

# Imprimir la tabla de frecuencias ordenada
#print(tabla_frecuencias)

# Crear el histograma con ggplot2
ggplot(datos_panel_filtrados, aes(x = factor(FELICIDAD, levels = 0:10))) +
  geom_histogram(stat = "count", aes(fill = as.numeric(FELICIDAD)), color = "black", binwidth = 1) +
  scale_fill_gradient(low = "blue", high = "red", name = "Felicidad") +
  labs(title = "Distribución de la Felicidad", x = "Nivel de Felicidad", y = "Frecuencia") +
  # theme_minimal() +
  scale_x_discrete(labels = categorias_FELICIDAD[1:11])  # Solo las categorías del 0 al 10


```



