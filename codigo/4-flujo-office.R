# INTRODUCCIÓN A R PARA CIENCIAS SOCIALES
# ESTACIÓN LASTARRIA - DICIEMBRE 2021
# PROFESOR: FELIPE RUIZ

# ---- INSTALAR PAQUETES ----
install.packages("summarytools")

# ---- CARGAR BASE YA EDITADA ----
UDP <- readRDS("datos/4-UDP.rds")

# ---- FLUJO DE TRABAJO CON MICROSOFT OFFICE ----

library(summarytools) # Resultados con mayor formato

# Tabla de frecuencias univariada
freq(UDP$sexorec)

# Imprimir tabla de frecuencias univariada
write.csv2(freq(UDP$sexorec), "resultados/impresora.csv")

# Tabla de frecuencias bivariada
prop.table(table(UDP$edad_rango, UDP$sexorec),2) 

#Imprimir tabla de doble entrada
write.csv2(prop.table(table(UDP$edad_rango, UDP$sexorec),2), "resultados/impresora.csv")

# Estadísticos descriptivos univariados
summary(UDP$edad)

# Estadísticos descriptivos univariados con summarytools
descr(UDP$edad)

# ... mayor edición
descr(UDP$edad, stats = c("min","q1","med","mean","sd", "cv", "max"),
      transpose = T)

# Imprimir tabla de estadísticos descriptivos
write.csv2(descr(UDP$edad, stats = c("min","q1","med","mean","sd", "cv", "max"),
                 transpose = T), "resultados/impresora.csv")


