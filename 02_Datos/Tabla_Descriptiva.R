
# CARGA PAQUETES PARA DEPURAR BBDD Y FUNCIONES AUXILIARES

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

# Si no está instalado el paquete hrbrthemes, se instala y carga; en caso contrario únicamente se carga...
if(!require(hrbrthemes)){install.packages('hrbrthemes')
  library(hrbrthemes)
}








