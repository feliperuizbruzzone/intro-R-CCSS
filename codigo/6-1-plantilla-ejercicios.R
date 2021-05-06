# INTRODUCCIÓN A R PARA CIENCIAS SOCIALES
# ESTACIÓN LASTARRIA - ABRIL/MAYO 2021
# PROFESOR: FELIPE RUIZ
# EJERCICIOS

# ---- 0. GESTIÓN DE PAQUETES Y DATOS ----
## Cargar paquetes necesarios para estadísticos y gráficos
install.packages(c())
library()
library()

## Cargar la base de datos desde formato CSV
esi19 <- read.csv2("")

# ---- 1. SELECCIÓN DE CASOS Y PREPARACIÓN VARIABLES ----

## Crear sub base con población ocupada
esi19_ocupados <-  filter()

## Configurar variable sexo como factor
esi19_ocupados$sexo <- factor()

# ---- 3. CÁLCULO DE RESULTADOS ----

## Cálculo frecuencias variable sexo
freq()

## Cálculo estadísticos descriptivos variable ingreso
descr()

## Gráfico de barras, variable sexo
ggplot(, aes(x = )) +
  geom_bar()