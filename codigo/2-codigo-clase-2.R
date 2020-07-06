# INTRODUCCIÓN A R PARA CIENCIAS SOCIALES
# ESTACIÓN LASTARRIA - JULIO 2020
# PROFESOR: FELIPE RUIZ

# ---- 1. FUNDAMENTOS MANEJO INFORMACIÓN EN R ----

# ---- CREACIÓN DE OBJETOS SIMPLES, MEDIANTE ASIGNACIÓN DIRECTA DE VALORES

# "Flecha" asigna valores a objeto, que se guarda en memoria temporal del programa
x <- 4

#Asignar varios valores a un objeto. Crear un vector mediante función concatenar "c".

# Pueden ser valores alfanuméricos (texto)
y <- c("Muy de acuerdo", "De acuerdo", "En desacuerdo")

z <- c(1,2,3,4,5)

# Ejecutando cada objeto, vemos su contenido en la consola de resultados
x
y
z

# Crearemos una "variable" como si fuera respuesta a pregunta: ¿cuál es su género?
genero <- c(1,2,2,2,1,2,1,99,99)

# Etiquetaremos sus valores creando una nueva variable configurada como "factor":
# Se indican códigos existentes (levels) y etiquetas (labels) o texto a asignar a cada código.
generof <- factor (genero, levels = c(1,2,99), labels = c("Hombre", "Mujer", NA))
table(generof) # Tabla arroja etiquetas de códigos.

# Podemos eliminar objetos específicos del entorno (memoria temporal del programa) con código
remove(x,y)

# Limpiar entorno de trabajo vía botones o sintaxis
remove(list = ls())

# Observar orden vía títulos.

# ---- 2. CREACIÓN MANUAL Y EXPLORACIÓN DE UNA BASE DE DATOS ----

# Por lo general bases de datos no se crean así: propósito pedagógico.
# Pasar de objetos, a vectores, a matrices de información.

#Supogamos un estudio de opinión sobre manifestaciones Octubre 2019.
#Crearemos una base de datos de nueve casos y tres variables
  #Género: 1 = Hombre/ 0 = Mujer. 
  #Ingreso: cantidades de pesos chilenos.
  #Acuerdo: escala de acuerdo con protestas durante O-19
    #Muy en desacuerdo = 1, En desacuerdo = 2, Ni de acuerdo ni en desacuerdo = 3, 
    # De acuerdo = 4, Muy de acuerdo = 5.

genero <- c(1,1,0,1,0,0,0,1,0)

ingreso <- c(100000,300000,500000,340000,300000,500000,650000,410000,750000)

acuerdo <- c(1,1,3,2,4,1,5,3,2)

#Ocupamos un nuevo comando para juntarlas en una matriz de datos (base de datos)
movilizacion <- data.frame(genero, ingreso, acuerdo) #resulta como objeto de "datos" en entorno

View(movilizacion) # Para visualizar base de datos
                   # O botón en objeto base de datos que se observa en entorno de trabajo

dim(movilizacion) # Nos dice las dimensiones de la base de datos

names(movilizacion) # Indica los nombres de las variables (columnas)

class(movilizacion) # Señala de qué tipo es el objeto

#Cálculo de estadísticos simples de variables específicas ("$ como indicador de posición)

#Tabla de frecuencias simple
table(movilizacion$genero)

#Media
mean(movilizacion$ingreso)

#---- EJERCICIO 1 (configuración de variables) ----

# 1. En base a los vectores simples recién creados (fuera de base de datos)
  # configurar acuerdo" como factor en nueva variable.
# 2. Crear nueva base de datos "movilizacion2" con tal variable + ingreso
# 3. Aplicar "table" para ver tabla de frecuencias de variable factorizada.
# 4. Visualizar base de datos creada "movilizacion2".


#---- EJERCICIO 2: cálculo de media y desviación estándar ----
# Calcular la mediana y desviación estándar de ingreso en base de datos 2
# Usen internet, busquen el comando

# ---- 3. ¿CÓMO Y QUÉ ARCHIVOS GUARDAR? ----

# Sintaxis, entorno global (sesión) y objetos (bases, resultados)

# 1. Sintaxis se guarda con botonera (formato .R) --> File --> Save as...
   # Cambios se guardan con botón "disquette" como en cualquier archivo.

# 2. Objetos (bases, resultados) se guardan con comandos (formato .rds).

saveRDS(movilizacion2, file = "datos/1-movilizacion.rds")
# ¿Donde se guardó tal archivo?

# Distinguir estos archivos del archivo del proyecto (.Rproj)

# Limpiar entorno para posteriores ejercicios
remove(list = ls())

#----------- 4. BIBLIOTECA, INSTALACIÓN/EJECUCIÓN DE PAQUETES --------

# Recordemos que son los paquetes. 
# Diferenciar entre instalar y cargar un paquete.

# Para instalar paquetes. Ojo que nombre debe ir entre comillas

install.packages("readxl") # Leer archivos .xlsx
install.packages("haven") # Leer bases de datos desde stata y spss
install.packages("dplyr") # Herramientas para manejar bases de datos.
install.packages(c("readxl","haven","dplyr")) # Forma "abreviada" de instalar varios paquetes

# Verificación visual en pestaña "packages".

library(readxl) # Para ejecutar paquete en nuestra sesión de trabajo (nombre no va entre comillas)

# Una vez que el paquete está descargado sólo resta ejecutarlo (library). 
# No se precisa descargar e instalar (install.packages) nuevamente

#----------- 5. IMPORTACIÓN DE BASES DE DATOS ------------------

# Veremos cómo importar bases de datos desde 4 tipos de archivo: CSV, EXCEL, SPSS, STATA
# Qué son las extensiones de archivo?

# Ver archivo paraguay.xlsx, para entender estructura de libro de datos.

# Configurar hoja correspondiente a base de datos de encuesta en archivo "paraguay" en Excel a archivo CSV 
    # Esto lo hacemos desde explorador de archivos en "guardar como"
# Observar estructura interna (abrir CSV con bloc de notas)
# Notación latinoamericana (, decimales - ; separador)
# Notación EEUU/EUROPA (. decimales - , separador)

# ----- 1. ABRIR ARCHIVO "paraguay" DESDE CSV
# NOTACIÓN EEUU: decimales como punto y no coma
paraguay_csv <- read.csv("datos/paraguay.csv")
View(paraguay_csv) # Visualizar base de datos
# ¿Qué sucedió con los datos?

#---- EJERCICIO 3: encontrar argumento para resolver el problema anterior ----


#¿Qué pasa si usamos una función adecuada a notación latina?
#lee comas como decimales y punto y comas como separador de variables
paraguay_csv2 <- read.csv2("datos/paraguay.csv")
View(paraguay_csv2)

# ---- 2. ABRIR ARCHIVO "paraguay" DESDE VERSIÓN MICROSOFT EXCEL .

library(readxl)
paraguay_excel <- read_excel("datos/paraguay.xlsx") 

# Visualizar primeros casos en consola
head(paraguay_excel) 

# ¿Cuál es el problema?

# Uso de argumentos en función read_excel

paraguay_excel <- read_excel("datos/paraguay.xlsx", sheet = 2) # posición de la hoja

paraguay_excel <- read_excel("datos/paraguay.xlsx", sheet = "respuestas") # nombre hoja

paraguay_excel <- read_excel("datos/paraguay.xlsx", sheet = "respuestas", skip = 1) #saltar fila de preguntas del cuestionario

# Es preciso indicar el nombre o posición de la hoja y desde qué fila leer datos. 
#Por defecto la función lee como nombre de variable la primera fila que lee.

# Limpiar entorno de trabajo

# ---- 4. ABRIR ENCUESTA "UDP" DESDE FORMATO Stata y SPSS

# Abrir archivo UDP_2015 (formato stata) - comando read.dta de paquete haven

UDP_stata <- read_dta("datos/UDP_2015.dta") #¿qué operación falta realizar?

#  Abrir archivo UDP_2015 (formato SPSS) - comando read_spss de paquete haven
UDP_spss <- read_spss("datos/UDP_2015.sav")

#-------------------- RESPUESTA EJERCICIOS ---------------------

# ---- RESPUESTA EJERCICIO 1
table(acuerdo)

acuerdo_f <- factor(acuerdo, levels = c(1,2,3,4,5), labels = c("Muy en desacuerdo", "En desacuerdo",
                                                               "Ni de acuerdo ni en desacuerdo",
                                                               "De acuerdo", "Muy de acuerdo"))

movilizacion2 <- data.frame(acuerdo_f, ingreso)

table(movilizacion2$acuerdo_f)

View(movilizacion2)

# ---- RESPUESTA EJERCICIO 2
median(movilizacion2$ingreso)
sd(movilizacion2$ingreso)

# ---- RESPUESTA EJERCICIO 3
paraguay_csv <- read.csv("paraguay.csv", sep = ";")
#se debe usar el argumento "sep" para indicar cuál signo denota separación de casos.
#en el caso propuesto, está tomando las comas existentes como separador de casos.
