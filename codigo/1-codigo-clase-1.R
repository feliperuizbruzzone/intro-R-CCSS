# INTRODUCCIÓN A R PARA CIENCIAS SOCIALES
# ESTACIÓN LASTARRIA - ABRIL 2021
# PROFESOR: FELIPE RUIZ

# ---- 0. CARGA DE PAQUETES Y DATOS A UTILIZAR ----

# ----  PROYECTO DEBE ESTAR ACTIVO EN SESIÓN RSTUDIO
    # ¿Cómo verificar?

# ---- PROBLEMAS CON CARACTERES ESPECIALES?
    # ¿Cómo solucionar?

# EJECUCIÓN DE COMANDOS:
  # Se ejecuta línea de comando donde está el cursor, o bien selección ad-hoc
  # Botón "run" en botonera del editor de sintaxis
  # Combinación de teclas: ctrl + enter

#Descargar paquete desde CRAN a disco duro
  # Verificar instalación visualmente en pestaña 'packages'
install.packages("readxl") 

#Cargar paquete en nuestra sesión de trabajo
  # Verificar carga a sesión de RStudio visualmente en pestaña 'packages'
library(readxl)

#Ejecutamos función para leer planilla y asignamos a nuevo objeto
  # Si proyecto está activo en directorio especificado, necesitamos una dirección 
  # relativa (al proyecto) y no absoluta (al computador personal) para cargar el archivo.
  # Usar proyectos facilita reproducibilidad

ANEJUD <- read_excel("datos/1-ANEJUD.xlsx")

# Visualizar como planilla
View(ANEJUD)

# ---- 1. ANÁLISIS ESTADÍSTICO SIMPLE ----

# Frecuencias afiliación
  # El signo peso indica que se trata de una columna dentro de una matriz

table(ANEJUD$afiliacion)

# Frecuencias conjuntas (%) afiliación/genero
  # 'table': frecuencias conjuntas
  # 'prop.table': cálculo proporciones a partir de frecuencias absolutas
                # número 2 indica proporciones columnas.
  # 'round': redondeo de cifras decimales

round(prop.table(table(ANEJUD$afiliacion, ANEJUD$genero),2)*100,2)

# Estadísticos resumen edad
summary(ANEJUD$edad)

# Gráfico (histograma simple) de variable edad
hist(ANEJUD$edad, xlab = "Edad", ylab = "Frecuencia", 
     main = "Histograma 1")
