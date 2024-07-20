<div align="center">
  <h1 style="font-size: 4em;">Exit-To</h1>
</div>

# Ejercicio de Reproducibilidad de un proyecto de Ciencia de Datos

## INTRODUCCION

Recordamos el modelo propuesto por Wickham y Grolemund (2017):


![Modelo de Ciencia de datos de Wickham y Grolemund (2017)](imgs/Model_DS_project.png)



En este proyecto presentamos un panel con información sobre la relación entre el bienestar subjetivo de las personas y otras variables como son el género, el tipo de relación laboral y el territorio, en España.
Disponemos de datos de 10 rondas descargados del ESS Survey (https://www.europeansocialsurvey.org/data/) sobre indicadores sociodemográficos solo para España.

## OBJETIVOS
### Objetivo del Proyecto
El objetivo de este proyecto de ciencia de datos es analizar y visualizar la relación entre el bienestar subjetivo, medido a través de las variables felicidad, salud y seguridad, y las variables sociodemográficas rel_laboral, género y territorio. Utilizando datos de la Encuesta Social Europea (ESS), se busca identificar patrones y tendencias que puedan ofrecer una comprensión más profunda de cómo estos factores influyen en la percepción del bienestar de los individuos.

#### Objetivos específicos
##### Analizar el Bienestar Subjetivo:

Felicidad: Evaluar cómo la percepción de felicidad varía entre diferentes grupos demográficos y laborales.
Salud: Examinar la relación entre la autoevaluación de la salud y las variables sociodemográficas.
Seguridad: Investigar la percepción de seguridad y su variación según género, territorio y situación laboral.
Variables Sociodemográficas:

Relación Laboral (rel_laboral): Analizar cómo la situación laboral (empleado, autónomo, negocio familiar) se relaciona con las percepciones de felicidad, salud y seguridad.
Género: Estudiar las diferencias de bienestar subjetivo entre hombres y mujeres.
Territorio: Explorar cómo las diferencias geográficas (regiones en España) influyen en las percepciones de bienestar.

##### Identificación de Patrones y Tendencias:

Usar técnicas de análisis de datos y visualización para identificar y comunicar patrones significativos.
Proporcionar una base de datos clara y visualizaciones que permitan a los estudiantes y orientadores vocacionales comprender las interrelaciones entre estas variables.


## CARGA, DEPURACION Y FILTRADO INICIAL DE LOS DATOS

Existen tres ficheros R independientes que se ejecutan con la función source() desde el fichero Panel.rmd

### 1.Cargar_Datos_Brutos


Aunque nos habíamos planteado carga los datos desde la __ESS__, utilizando el usuario de la autora. Descartamos esta opción y se carga el fichero descargado previamente "ESS1e06_7-ESS2e03_6-ESS3e03_7-ESS4e04_6-ESS5e03_5-ESS6e02_6-ESS7e02_3-ESS8e02_3-ESS9e03_2-ESS10SC-subset.csv""
Hemos realizado una carga previa de los datos desde ESS con la url: 

Los datos se encuentran en el fichero:  

ESS1e06_7-ESS2e03_6-ESS3e03_7-ESS4e04_6-ESS5e03_5-ESS6e02_6-ESS7e02_3-ESS8e02_3-ESS9e03_2-ESS10SC-subset.csv

Y por facilidad creamos una copia para trabajar con ella llamada Datos_brutos.csv

Observo que R crea un fichero sin nombre con la extensión RData. Busco para qué sirve:

RData es un formato de archivo utilizado en el lenguaje de programación R para almacenar objetos R, como data frames, listas, matrices, vectores y más. Los archivos RData son útiles por varias razones:

1. **Almacenamiento Persistente**: Permiten guardar el estado actual del entorno de trabajo de R, incluyendo todas las variables y objetos, para que se puedan cargar y reutilizar en futuras sesiones sin tener que volver a crear o recalcular los objetos desde cero.

2. **Eficiencia de Espacio y Tiempo**: Los archivos RData pueden ser comprimidos, lo que reduce el espacio de almacenamiento necesario. Además, cargar un archivo RData es generalmente más rápido que volver a ejecutar el código para generar los objetos almacenados.

3. **Facilidad de Compartir y Reutilizar**: Facilitan compartir datos y resultados entre diferentes proyectos o colaboradores. Cualquier persona con el archivo RData puede cargarlo en su propio entorno R y acceder a los objetos contenidos en él.

Para mejorar la eficiencia al cargar datos brutos, por si ya están cargados, cargar un archivo RData en un proyecto de R, si podemos aplicar la mejora se utiliza una combinación de control de flujo con condiciones. 


1. **Verificación si los datos ya están cargados**:
2. **Cargar los datos de acuerdo a las condiciones**:


Con esta estructura, tu código podrá cargar datos de manera eficiente, asegurándose de no recargar datos si ya están disponibles en el entorno o en un archivo RData previamente guardado.
Aunque en este fichero solamente ejecutamos la carga de los datos, lo mantenemos de manera independiente por su posible evolución futura


#### 2.Depuracion_datos


Dado que disponemos de un gran volumen de datos, procedemos a eliminar todas las filas con missing values que no podemos completar.

También generaremos un set de datos filtrados con el que generar gráficos más claros para su visualización.

Revisión de las distribuciones de los datos y la existencia de outliers:

VARIABLES DIRECTAS

![VARIABLES DIRECTAS](imgs/vARIABLES_DIRECTAS.png)

En la tabla descriptiva observamos algunos outliers en determinadas variables como 
    • agea,  valores superiores a 100. 
    • aesfdrk, gndr, happy y health, valores fuera de la escala que representan que la persona encuestada no ha querido utilizar ninguno de los valores de la escala. No eliminamos pero si filtraremos para crear los análisis y gráficos correspondientes .
Revisamos los datos para crear un subset de datos filtrados.
Filtramos y renombramos las variables para una mejor legibilidad.

Agrupamos las columnas age y agea
Agrupamos regiones y regioaes
Añadimos una columna año en función del año de la ronda ESS, nos parece una variable de más fácil manejo para el usuario
Observamos que algunas rondas no disponen de datos sobre la region y generamos dos subconjuntos de datos, con o sin información sobre la región por si posteriormente es de utilidad.
Generamos un subset de datos llamado __datos_panel__ con las variables que utilizaremos en el panel interactivo y proseguimos con la limpieza de datos.


#### 3.Desc_Datos_Filtrados

Eliminamos los outliers para obtener datos descriptivos significativos que faciliten la visualización en el panel
FELICIDAD <= 10
RELACION LABORAL <= 3
EDAD <= 70
GENERO != 9
SEGURIDAD <=4
SALUD <= 5



DATOS FILTRADOS

![DATOS FILTRADOS](imgs/DATOS_FILTRADOS.png)








### Referencias

#### Paquetes de R utilizados

#### Referencias bibliográficas


Contenidos para este ddocumento:

1. Definición del Problema

Definir claramente el problema que se desea resolver.
Establecer los objetivos y metas del proyecto.

2. Recolección de Datos

Recopilar datos relevantes de diversas fuentes.
Asegurar que los datos sean de buena calidad y relevantes para el problema.

3. Limpieza de Datos

Eliminar duplicados, manejar valores faltantes y corregir errores.
Estandarizar y normalizar los datos si es necesario.

4. Análisis Exploratorio de Datos (EDA)

Realizar investigaciones iniciales en los datos para descubrir patrones, detectar anomalías y verificar suposiciones.
Utilizar visualizaciones y métodos estadísticos para comprender mejor los datos.

5. Ingeniería de Características

Crear nuevas características o modificar las existentes para mejorar el rendimiento de los modelos de aprendizaje automático.
Seleccionar las características más importantes para el modelo.

6. Selección del Modelo

Elegir algoritmos de aprendizaje automático apropiados según el tipo de problema y las características de los datos.
Comparar diferentes modelos para encontrar el mejor.

7. Entrenamiento del Modelo

Entrenar el(los) modelo(s) seleccionado(s) con los datos de entrenamiento.
Afinar los parámetros del modelo para optimizar el rendimiento.

8. Evaluación del Modelo

Evaluar el rendimiento del modelo utilizando métricas adecuadas.
Validar el modelo usando validación cruzada o un conjunto de validación separado.

9. Despliegue del Modelo

Desplegar el modelo en un entorno de producción.
Asegurar que el modelo se integre sin problemas con los sistemas existentes.

10. Monitoreo y Mantenimiento del Modelo

Monitorear continuamente el rendimiento del modelo en producción.
Actualizar el modelo según sea necesario para adaptarse a nuevos datos o condiciones cambiantes.

11. Reportes y Comunicación

Documentar todo el proceso, desde la definición del problema hasta el despliegue del modelo.
Comunicar los hallazgos y resultados a las partes interesadas de manera clara y efectiva.

12. Ciclo de Retroalimentación

Recoger retroalimentación de usuarios y partes interesadas.
Iterar en el modelo y el flujo de trabajo basado en esta retroalimentación para mejorar el rendimiento y la usabilidad.
