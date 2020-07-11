# INTRODUCCIÓN A R PARA CIENCIAS SOCIALES
# ESTACIÓN LASTARRIA - JULIO 2020
# PROFESOR: FELIPE RUIZ


# Ver funcionalidad de comentarios e índices

#Sintaxis incluye ejercicios (respuestas al final)¨

install.packages(c("haven", "car", "tidyverse", "Publish", "summarytools", "openxlsx"))

#---- 1.IMPORTACIÓN DE BASES DE DATOS DESDE SPSS Y STATA ----

#A. Abrir encuesta UDP desde formato stata y spsss
#abrir archivo UDP_2015 (formato stata) - comando read.dta de paquete haven

# ---- EJERCICIO 1: resolver mensaje de error -----

UDP_stata <- read_dta("datos/UDP_2015.dta") #¿qué operación falta realizar?

#abrir archivo UDP_2015 (formato SPSS) - comando read_spss de paquete haven

UDP_spss <- read_spss("datos/UDP_2015.sav")

# --- 2. MANEJO (UN POCO MÁS SOFISTICADO) DE DATOS ----

library(dplyr) #Cargar paquete'dplyr'

#Características y estructura base de datos
class(UDP_spss)
dim(UDP_spss)
names(UDP_spss) #¿Por qué es útil? este tipo de información?

#Crear nueva base con sólo algunas variables de la base original: para no leer base entera.
      #Sexo_Entrevistado: sexo observado
      #P54: Edad
      #P72: Escala de ingresos
      #P64: autoposicionamiento en estratificación. 1 grupo más bajo, 10 grupo más alto
      #Región de residencia

#Comando select de dplyr permite seleccionar columnas según el nombre.
#Se indica la base de datos y luego cada variable a seleccionar.

UDP <- select(UDP_spss,Sexo_Entrevistado, P54, P72, P64, Región)

#Comando rename permite modificar nombres de columnas
# nombre nuevo = nombre antiguo

UDP <- rename(UDP, sexo=Sexo_Entrevistado, edad=P54, ingreso = P72, autoposicionamiento=P64,
              region=Región)

#Ver estructura de base de datos en entorno... ¿qué son los vectores 'atomic' o 'labelled'?

View(UDP)

# Remover objetos que no usaremos
remove(UDP_spss, UDP_stata)

# ---- 3. RECODIFICACIÓN DE VARIABLES ----

#A. RECODIFICAR VARIABLES EN UNA NUEVA, DENTRO DE LA MISMA BASE DE DATOS

#1.SEXO (si no funciona recodificación, reiniciar RStudio e invertir orden de carga de paquetes)

table(UDP$sexo) #1 = hombre, 2 = mujer
class(UDP$sexo)
UDP$sexo <- as.numeric(UDP$sexo) #convertir a vector numérico para poder transformar

UDP <- mutate(UDP, sexorec = recode(UDP$sexo, "1" = "hombre", "2" = "mujer"))
class(UDP$sexorec) #queda como objeto character
UDP$sexorec #visualizar datos concretos guardados
table(UDP$sexorec)

#2.EDAD 

#Recodificar en números asociados a rangos. 18-29; 30-49; 50-69; 70 o más.
summary(UDP$edad)
class(UDP$edad)
UDP$edad <- as.numeric(UDP$edad)

#Especificar paquete desde el cual queremos ejecutar la función 'recode' 
  #para poder recodificar según tramos
UDP <- mutate(UDP, edad_rango = car::recode(UDP$edad, "18:29 = 1;30:49 = 2;
                                            50:69 =3; else = 4"))
table(UDP$edad_rango)

#Convertir a factor para poner etiquetas
UDP$edad_rango <- factor(UDP$edad_rango, labels= c("18-29", "30-49", "50-69", "70+"))
table(UDP$edad_rango)

#3. INGRESO

#Reducimos tramos de ingresos (ver cuestionario) recodificando en una variable nueva

summary(UDP$ingreso) #ojo con los casos perdidos. Debermos considerarlos al recodificar

UDP <- mutate(UDP, ingreso_rango = car::recode(UDP$ingreso, "1:4 = 1; 5 = 2; 6 = 3;
                                               7:8 = 4; else = NA"))

UDP$ingreso_rango <- factor(UDP$ingreso_rango, labels = c("Menos 300.000", "Entre 300.000 y 500.000",
                                                          "Entre 500.000 y 1.000.000", "Más de 1.000.000"))

table(UDP$ingreso_rango)

# ---- EJERCICIO 2 ----
#Crear una variable "region2", en base a "region". Con las categorías RM y Resto de Chile.

UDP <- mutate(UDP, region2 = )

# ---- 4. ESTADÍSTICA UNIVARIADA ----
# No veremos todo, énfasis en lógica de uso de R.

table(UDP$sexorec) #Tabla frecuencias simple

prop.table(table(UDP$sexorec)) #cómo podemos abreviarlo?

t <- table(UDP$sexorec)
prop.table(t) #cómo podemos abreviarlo?

#Estadísticas descriptivas. Comando summary sobre variable individual o base completa
summary(UDP$autoposicionamiento)

summary(UDP) #¿Qué cuestiones se observan? (atípicos/perdidos)

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

UDP_RM_mujeres <- filter(UDP, ...)


# Forma básica para estimar intervalos de confianza
# Supone Muestreo Aleatorio Simple.
library(Publish)

ci.mean(UDP$edad) #Cálculo de media con intervalo de confianza

ci.mean(edad~sexorec, data=UDP) #Cáculo de media con I.C. para diferentes grupos (género)

ci.mean(edad~region, data=UDP) #Cáculo de media con I.C. para diferentes grupos (región)

# ---- 5. ESTADÍSTICA BIVARIADA ----

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

#edad_rango, ingreso_rango

chisq.test(table(UDP$edad_rango, UDP$ingreso_rango))

#CORRELACIÓN

cor.test(UDP$ingreso, UDP$edad, method = "pearson") #otros métodos (ver Help) 

# otras opciones, correlaciones tetracóricas y policóricas.
# https://personality-project.org/r/html/tetrachor.html 


# ---- 7. FLUJO DE TRABAJO CON MICROSOFT OFFICE ----

# Volver a láminas expositivas

library(summarytools) # Editar resultados
library(openxlsx) # Funciones para trabajar con libros excel (guardar, escribir, etc.)

# Tabla de frecuencias bivariada construida previamente
prop.table(table(UDP$edad_rango, UDP$sexorec),2) 

#Imprimir tabla de doble entrada
write.xlsx(prop.table(table(edad_rango, sexorec),2), "resultados/impresora.xlsx")

#Tabla de frecuencias simple (podríamos guardar resultados como objetos)
t1 <- table(UDP$region)
write.xlsx(t1, "resultados/impresora.xlsx")

# Tabla de contingencia con summarytools (incluye totales y nombres variable)
t2 <- ctable(UDP$sexorec, UDP$edad_rango,
              prop = "n")
write.xlsx(t2, "resultados/impresora.xlsx")

# Estadísticos descriptivos
write.xlsx(summary(UDP$edad), "resultados/impresora.xlsx")

# Configurar output
options(digits=10) #Cantidad de dígitos (para notación científica)
options(OutDec = ",") #Signo para decimales

#Volver a imprimir


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

UDP_RM_mujeres <- filter(UDP, region == 13 & sexo == 2)
