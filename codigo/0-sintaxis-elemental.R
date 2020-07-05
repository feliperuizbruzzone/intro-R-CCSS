# INTRODUCCIÓN A R PARA CIENCIAS SOCIALES
# ESTACIÓN LASTARRIA - JULIO 2020
# PROFESOR: FELIPE RUIZ

# Signo gato permite incorporar comentarios.
# Botón "run" o ctrl+enter ejecuta línea en donde esté el cursor

X <- 5 #asigación básica --> Aparece en entorno.
X # Muestra su contenido

X <- 1455 #Se puede sobreescribir.
X

Y <- "Hola" #Pueden ser letras
Y

#Vector = encadenamiento lineal de datos
# c = cFunción concatenar
sexo <- c(1,2,2,2,2,1,1,1,2,2,1)

# Tabla simple de frecuencias
table(sexo)

#Para ver qué tupo de vector es
class(sexo)

#En este caso encadenamos letras
GSE <- c("ABC1", "C2", "E", "E", "ABC1", "E", "D", "ABC1", "C2", "E", "E")

# Frecuencias
table(GSE)

# Tipo de vector
class(GSE)

# Creación manual de base de datos
datos <- data.frame(GSE, sexo)

# Visualizar base de datos
View(datos)
