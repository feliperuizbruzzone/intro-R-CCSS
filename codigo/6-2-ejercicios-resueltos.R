# INTRODUCCIÓN A R PARA CIENCIAS SOCIALES
# ESTACIÓN LASTARRIA - ABRIL/MAYO 2021
# PROFESOR: FELIPE RUIZ
# EJERCICIOS RESUELTOS

# ---- 0. GESTIÓN DE PAQUETES Y DATOS ----
## Cargar paquetes necesarios para estadísticos y gráficos
install.packages(c("summarytools", "tidyverse"))
library(summarytools)
library(tidyverse)

## Cargar la base de datos desde formato CSV
esi19 <- read.csv2("datos/esi-2019-personas.csv")

# ---- 1. SELECCIÓN DE CASOS Y PREPARACIÓN VARIABLES ----

## Crear sub base con población ocupada
esi19_ocupados <-  filter(esi19, ocup_ref == 1)

## Configurar variable sexo como factor
esi19_ocupados$sexo <- factor(esi19_ocupados$sexo, labels = c("Hombre", "Mujer"))

# ---- 3. CÁLCULO DE RESULTADOS ----

## Cálculo frecuencias variable sexo
freq(esi19_ocupados$sexo)

## Cálculo estadísticos descriptivos variable ingreso
descr(esi19_ocupados$ing_t_p)

## Gráfico de barras, variable sexo
ggplot(esi19_ocupados, aes(x = sexo)) +
  geom_bar()