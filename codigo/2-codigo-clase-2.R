# INTRODUCCIÓN A R PARA CIENCIAS SOCIALES
# ESTACIÓN LASTARRIA - AGOSTO/SEPTIEMBRE 2022
# PROFESOR: FELIPE RUIZ

# ---- 1. FUNDAMENTOS MANEJO INFORMACIÓN EN R ----

# ---- CREACIÓN DE OBJETOS SIMPLES: DEL VECTOR A LA VARIABLE

# Crearemos una "variable" como si fuera respuesta a pregunta: ¿cuál es su género?
# 1 = hombre; 2 = mujer; 99 = no responde
sexo <- c(1,2,2,2,1,2,1,99,99)

# Tabla de frecuencias simple
table(sexo)

# Etiquetaremos sus valores creando una nueva variable configurada como "factor":
# Se indican códigos existentes (levels) y etiquetas (labels) o texto a asignar a cada código.
sexof <- factor (sexo, levels = c(1,2,99), labels = c("Hombre", "Mujer", NA))
table(sexof) # Tabla arroja etiquetas de códigos.

# Podemos eliminar objetos específicos del entorno (memoria temporal del programa) con código
remove(sexo)

# Limpiar entorno de trabajo vía botones o sintaxis
remove(list = ls())

# Observar orden vía títulos.

# ---- 2. CREACIÓN MANUAL Y EXPLORACIÓN DE UNA BASE DE DATOS ----

# Por lo general bases de datos no se crean así: propósito pedagógico.
# Pasar de objetos, a vectores, a matrices de información.

# Supongamos un estudio de opinión sobre proyecto jornada laboral 40 horas
# Crearemos una base de datos de 9 casos y 3 variables
  #Género: 1 = Hombre/ 0 = Mujer. 
  #Ingreso: cantidades de pesos chilenos.
  #Acuerdo: escala de acuerdo con proyecto jornada laboral 40 horas
    #Muy en desacuerdo = 1, En desacuerdo = 2, Ni de acuerdo ni en desacuerdo = 3, 
    # De acuerdo = 4, Muy de acuerdo = 5.

# ---- CREACIÓN MANUAL DE VARIABLES

genero <- c(1,1,0,1,0,0,0,1,0)

ingreso <- c(100000,300000,500000,340000,300000,500000,650000,410000,750000)

acuerdo <- c(1,1,3,2,4,1,5,3,2)

# ---- AGRUPAMIENTO DE VARIABLES (VECTORES) COMO BASE (MATRIZ) DE DATOS

# Ocupamos un nuevo comando para juntarlas en una matriz de datos (base de datos)
cuarenta <- data.frame(genero, ingreso, acuerdo) #resulta como objeto de "datos" en entorno

View(cuarenta) # Para visualizar base de datos
               # O botón en objeto base de datos que se observa en entorno de trabajo

dim(cuarenta) # Nos dice las dimensiones de la base de datos

names(cuarenta) # Indica los nombres de las variables (columnas)

class(cuarenta) # Señala de qué tipo es el objeto

# Cálculo de estadísticos simples de variables específicas ("$ como indicador de variable)

# Tabla de frecuencias simple variable "género"
table(cuarenta$genero)

# Cálculo Media de variable "ingreso"
mean(cuarenta$ingreso)

#---- EJERCICIO 1: cálculo de mediana y desviación estándar ----
# Calcular la mediana y desviación estándar de ingreso en base de datos
# Usen internet, busquen el comando

# ---- 3. ¿CÓMO Y QUÉ ARCHIVOS GUARDAR? ----

# Sintaxis, entorno global (sesión) y objetos (bases, resultados)

# A. Sintaxis se guarda con botonera (formato .R) --> File --> Save as...
   # Cambios se guardan con botón "disquette" como en cualquier archivo.

# B. Objetos (bases, resultados) se guardan con comandos (formato .rds).

saveRDS(cuarenta, file = "datos/2-cuarenta.rds")
# ¿Donde se guardó tal archivo?

# Distinguir estos archivos del archivo del archivo proyecto (.Rproj)

# Limpiar entorno para posteriores ejercicios
remove(list = ls())

#----------- 4. BIBLIOTECA, INSTALACIÓN/EJECUCIÓN DE PAQUETES --------

# Recordemos que son los paquetes. 
# Diferenciar entre instalar y cargar un paquete.

# Para instalar paquetes. Ojo que nombre debe ir entre comillas
install.packages("readxl") # Leer archivos .xlsx

# Verificación visual en pestaña "packages".

library(readxl) # Para ejecutar paquete en nuestra sesión de trabajo (nombre no va entre comillas)

# Una vez que el paquete está descargado sólo resta ejecutarlo (library). 
# No se precisa descargar e instalar (install.packages) nuevamente

#----------- 5. IMPORTACIÓN DE BASES DE DATOS ------------------

# Veremos cómo importar bases de datos desde 2 tipos de archivo: CSV, EXCEL
# Qué son las extensiones de archivo?

# Ver archivo paraguay.xlsx, para entender estructura del libro de datos.

# Configurar hoja correspondiente a base de datos de encuesta en archivo "paraguay" en Excel a archivo CSV 
    # Esto lo hacemos desde explorador de archivos en "guardar como"
# Observar estructura interna (abrir CSV con bloc de notas)
# Notación latinoamericana (, decimales - ; separador)
# Notación EEUU/EUROPA (. decimales - , separador)

# ----- 1. ABRIR ARCHIVO "paraguay" DESDE CSV
# NOTACIÓN EEUU: decimales como punto y no coma
paraguay_csv <- read.csv("datos/2-paraguay.csv")
View(paraguay_csv) # Visualizar base de datos
# ¿Qué sucedió con los datos?

#---- EJERCICIO 2: encontrar argumento para resolver el problema anterior ----

# ¿Cómo indicar una lectura correcta de la base de datos?

#¿Qué pasa si usamos una función adecuada a notación latina?
#lee comas como decimales y punto y comas como separador de variables
paraguay_csv2 <- read.csv2("datos/2-paraguay.csv")
View(paraguay_csv2)

# ---- 2. ABRIR ARCHIVO "paraguay" DESDE VERSIÓN MICROSOFT EXCEL .

library(readxl) # Ya lo ejecutamos!
paraguay_excel <- read_excel("datos/2-paraguay.xlsx")

# Visualizar primeros casos en consola
head(paraguay_excel) 

# ¿Cuál es el problema?

# Uso de argumentos en función read_excel

paraguay_excel <- read_excel("datos/2-paraguay.xlsx", sheet = 2) # posición de la hoja

paraguay_excel <- read_excel("datos/2-paraguay.xlsx", sheet = "respuestas") # nombre hoja

paraguay_excel <- read_excel("datos/2-paraguay.xlsx", sheet = "respuestas", skip = 1) #saltar fila de preguntas del cuestionario

# Es preciso indicar el nombre o posición de la hoja y desde qué fila leer datos. 
#Por defecto la función lee como nombre de variable la primera fila que lee.

# Limpiar entorno de trabajo

#-------------------- RESPUESTA EJERCICIOS ---------------------

# ---- RESPUESTA EJERCICIO 1
median(cuarenta$ingreso)
sd(cuarenta$ingreso)

# ---- RESPUESTA EJERCICIO 2
paraguay_csv <- read.csv("datos/2-paraguay.csv", sep = ";")
#se debe usar el argumento "sep" para indicar cuál signo denota separación de casos.
#en el caso propuesto, está tomando las comas existentes como separador de casos.
