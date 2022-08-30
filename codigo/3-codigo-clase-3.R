# INTRODUCCIÓN A R PARA CIENCIAS SOCIALES
# ESTACIÓN LASTARRIA - AGOSTO/SEPTIEMBRE 2022
# PROFESOR: FELIPE RUIZ

#----------- 0. BIBLIOTECA, INSTALACIÓN/EJECUCIÓN DE PAQUETES --------

# Recordemos que son los paquetes. 
# Diferenciar entre instalar y cargar un paquete.

# Para instalar paquetes. Ojo que nombre debe ir entre comillas
install.packages("readxl") # Para leer archivos .xlsx

# Verificación visual en pestaña "packages".

# Para cargar paquete mediante código en nuestra sesión de trabajo (nombre no va entre comillas)
library(readxl)

# Una vez que el paquete está descargado sólo resta ejecutarlo (library). 
# No se precisa descargar e instalar (install.packages) cada vez

# Instalación masiva de paquetes (concatenar nombres)
install.packages(c("haven", "car", "tidyverse"))

#----------- 1. IMPORTACIÓN DE BASES DE DATOS - FORMATO PLANILLA ------------------

# Veremos cómo importar bases de datos desde 4 tipos de archivo: CSV, EXCEL, Stata, SPSS
# Qué son las extensiones de archivo?
# Emulación "free" de SPSS: https://www.gnu.org/software/pspp/

# Reiteraremos ejercicio clase 2

# ----- ABRIR ARCHIVO "paraguay" DESDE CSV
# NOTACIÓN EEUU: decimales como punto y no coma
paraguay_csv <- read.csv("datos/3-paraguay.csv")
View(paraguay_csv) # Visualizar base de datos
# ¿Qué sucedió con los datos?

# ¿Cómo indicar una lectura correcta de la base de datos?
#¿Qué pasa si usamos una función adecuada a notación latina?
#lee comas como decimales y punto y comas como separador de variables
paraguay_csv2 <- read.csv2("datos/3-paraguay.csv")
View(paraguay_csv2)

# ---- ABRIR ARCHIVO "paraguay" DESDE VERSIÓN MICROSOFT EXCEL .

library(readxl) # Ya lo ejecutamos!
paraguay_excel <- read_excel("datos/3-paraguay.xlsx")

# Visualizar primeros casos en consola
head(paraguay_excel) 
# ¿Cuál es el problema?

# Uso de argumentos en función read_excel
paraguay_excel <- read_excel("datos/3-paraguay.xlsx", sheet = 2) # posición de la hoja

paraguay_excel <- read_excel("datos/3-paraguay.xlsx", sheet = "respuestas") # nombre hoja

paraguay_excel <- read_excel("datos/3-paraguay.xlsx", sheet = "respuestas", skip = 1) #saltar fila de preguntas del cuestionario

# Es preciso indicar el nombre o posición de la hoja y desde qué fila leer datos. 
# Por defecto la función lee como nombre de variable la primera fila que lee.

# Limpiar entorno de trabajo
# Ver funcionalidad de comentarios e índices

# ---- 2. IMPORTACIÓN DE BASES DE DATOS DESDE SPSS Y STATA ----

# Abrir encuesta UDP desde formato stata y spsss

# ---- EJERCICIO 1: resolver mensaje de error -----
UDP_stata <- read_dta("datos/3-UDP_2015.dta") # ¿qué operacion falta realizar?

#abrir archivo UDP_2015 (formato SPSS) - comando read_spss de paquete haven
UDP_spss <- read_spss("datos/3-UDP_2015.sav")

# --- 3. MANEJO (UN POCO MÁS SOFISTICADO) DE DATOS ----
library(dplyr) #Cargar paquete'dplyr'

#Características y estructura base de datos
class(UDP_spss)
dim(UDP_spss)
names(UDP_spss) # ¿Por que es útil este tipo de información?

#Crear nueva base con sólo algunas variables de la base original: para no leer base entera.
      #Sexo_Entrevistado: sexo observado
      #P54: Edad
      #P72: Escala de ingresos
      #P64: autoposicionamiento en estratificación. 1 grupo más bajo, 10 grupo más alto
      #Región de residencia

#Comando select de dplyr permite seleccionar columnas según el nombre.
#Se indica la base de datos y luego cada variable a seleccionar.
#Conviene entre comillar nombre de columna ante caracteres especiales

UDP <- select(UDP_spss,Sexo_Entrevistado, P54, P72, P64, "Región")

#Comando rename permite modificar nombres de columnas
#Puede usarse igual que "select"
# nombre nuevo = nombre antiguo

UDP <- rename(UDP, sexo=Sexo_Entrevistado, edad=P54, ingreso = P72, autoposicionamiento=P64,
              region="Región")

#Ver estructura de base de datos en entorno... ¿qué son los vectores 'atomic' o 'labelled'?
View(UDP)

# Remover objetos que no usaremos
remove(UDP_spss, UDP_stata)

# ---- 4. RECODIFICACIÓN DE VARIABLES ----

# ---- A. RECODIFICAR VARIABLES EN UNA NUEVA, DENTRO DE LA MISMA BASE DE DATOS

## SEXO (si no funciona recodificación, reiniciar RStudio e invertir orden de carga de paquetes)

table(UDP$sexo) #1 = hombre, 2 = mujer
class(UDP$sexo)
UDP$sexo <- as.numeric(UDP$sexo) #convertir a vector numérico para poder transformar

UDP <- mutate(UDP, sexorec = recode(UDP$sexo, "1" = "hombre", "2" = "mujer"))
class(UDP$sexorec) #queda como objeto character
UDP$sexorec #visualizar datos concretos guardados
table(UDP$sexorec)

## EDAD 

# Recodificar en números asociados a rangos. 18-29; 30-49; 50-69; 70 o más.
summary(UDP$edad)
class(UDP$edad)
UDP$edad <- as.numeric(UDP$edad)

#Especificar paquete desde el cual queremos ejecutar la función 'recode' 
  # para poder recodificar según tramos
UDP <- mutate(UDP, edad_rango = car::recode(UDP$edad, "18:29 = 1;30:49 = 2;
                                            50:69 =3; else = 4"))
table(UDP$edad_rango)

#Convertir a factor para poner etiquetas
UDP$edad_rango <- factor(UDP$edad_rango, labels= c("18-29", "30-49", "50-69", "70+"))
table(UDP$edad_rango)

## INGRESO

#Reducimos tramos de ingresos recodificando en una variable nueva

summary(UDP$ingreso) #ojo con los casos perdidos. Debermos considerarlos al recodificar

UDP <- mutate(UDP, ingreso_rango = car::recode(UDP$ingreso, "1:4 = 1; 5 = 2; 6 = 3;
                                               7:8 = 4; else = NA"))

UDP$ingreso_rango <- factor(UDP$ingreso_rango, labels = c("Menos 300.000", "Entre 300.000 y 500.000",
                                                          "Entre 500.000 y 1.000.000", "Más de 1.000.000"))

table(UDP$ingreso_rango)

# ---- EJERCICIO 2 ----
#Crear una variable "region2", en base a "region". Con las categorías RM y Resto de Chile.

UDP <- mutate(UDP, region2 = )

# ---- 5. ESTADÍSTICA UNIVARIADA ----
# No veremos todo lo posible, ni funciones especializadas, énfasis en lógica de uso de R.
# Sugerencia para más edición: explorar paquete "summarytools": https://cran.r-project.org/web/packages/summarytools/vignettes/introduction.html
# Veremos algunas cosas la siguiente clase

table(UDP$sexorec) #Tabla frecuencias simple

prop.table(table(UDP$sexorec)) #¿cómo podemos abreviarlo?

t <- table(UDP$sexorec)
prop.table(t) # Función sobre objeto que contiene datos

#Estadísticas descriptivas. Comando summary sobre variable individual o base completa
summary(UDP$autoposicionamiento)

summary(UDP)  # ¿Que cuestiones se observan? (atípicos/perdidos)

#Asignar casos perdidos. Se puede hacer dentro de una recodificación o con este comando
UDP$autoposicionamiento[UDP$autoposicionamiento==88]<- NA
UDP$autoposicionamiento[UDP$autoposicionamiento==99]<- NA

#Estadísticos descriptivos con casos perdidos codificados
summary(UDP$autoposicionamiento) #distingue los valores NA
mean(UDP$autoposicionamiento) #Hay que indicarle que ignore los valores lógicos NA
mean(UDP$autoposicionamiento, na.rm = T) #algunos comandos precisan indicar si hay o no NA'S
sd(UDP$autoposicionamiento, na.rm = T)

#Filtrar base de datos. Comando "filter" (dplyr)
#Lógica de crear un nuevo objeto, no "activar temporalmente" una función (como SPSS)

UDP_hombres <- filter(UDP, sexorec == "hombre")
UDP_RM <- filter(UDP, region == 13)

#---- EJERCICIO 3 -----
#Aplicar filtro para seleccionar sólo a mujeres de RM, usando variable "sexo"

UDP_RM_mujeres <- ...


# ---- 6. ESTADÍSTICA BIVARIADA ----

#Fijar objeto en sesión
attach(UDP)

# Tablas de doble entrada
table(edad_rango, sexorec)

prop.table(table(edad_rango, sexorec)) # Proporción en relación al n total
# Ojo que opera sobre tabla anterior

t_prop <- prop.table(table(edad_rango, sexorec)) #lo guardamos como un objeto

t_prop*100  #Expresamos en porcentaje

round(t_prop*100, digits=2) #Redondeamos decimales

prop.table(table(edad_rango, sexorec),1) #Proporción en relación a n filas

prop.table(table(edad_rango, sexorec),2) #Proporción en relación a n columnas

# Asociación entre variables (CHI-CUADRADO)

# edad_rango, ingreso_rango (cálculo sobre tabla doble entrada)
chisq.test(table(UDP$edad_rango, UDP$ingreso_rango))

#CORRELACIÓN
cor.test(UDP$ingreso, UDP$edad, method = "pearson") #otros métodos (ver Help) 

# otras opciones, correlaciones tetracóricas y policóricas.
# https://personality-project.org/r/html/tetrachor.html 

# ---- 7. GUARDAR BASE EDITADA EN FORMATO R ----
saveRDS(UDP, file = "datos/4-UDP.rds") # Formato específico de R

# ---- RESPUESTA EJERCICIOS ----

 # ----- RESPUESTA EJERCICIO 1 ----
library(haven)
#basta con cargar el paquete en la sesión de R.

# ---- RESPUESTA EJERCICIO 2 ----
#inspeccionar variable
table(UDP$region)
class(UDP$region)

#transformar a vector numérico
UDP$region <- as.numeric(UDP$region)

#recodificar en variable dicotómica (ausencia/presencia de una característica)
UDP <- mutate(UDP, region2 = car::recode(UDP$region, "13 = 1;else = 0"))

#Factorizar y etiquetar
UDP$region2 <- factor(UDP$region2, levels = c(0,1), 
                      labels = c("Resto de Chile", "RM"))
table(UDP$region2)

# ---- RESPUESTA EJERCICIO 3 ---- 

UDP_RM_mujeres <- filter(UDP, sexorec=="mujer", region==13)

UDP_RM_mujeres <- filter(UDP, region == 13 & sexo == 2)
