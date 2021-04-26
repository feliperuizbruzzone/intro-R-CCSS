# INTRODUCCIÓN A R PARA CIENCIAS SOCIALES
# ESTACIÓN LASTARRIA - ABRIL 2021
# PROFESOR: FELIPE RUIZ

# ---- INSTALAR PAQUETES ----
install.packages(c("summarytools", "openxlsx"))

# ---- CARGAR BASE YA EDITADA ----
UDP <- readRDS("datos/4-UDP.rds")

# ---- FLUJO DE TRABAJO CON MICROSOFT OFFICE ----

# Volver a láminas expositivas

library(summarytools) # Editar resultados
library(openxlsx) # Funciones para trabajar con libros excel (guardar, escribir, etc.)

# Tabla de frecuencias bivariada
prop.table(table(UDP$edad_rango, UDP$sexorec),2) 

#Imprimir tabla de doble entrada
write.xlsx(prop.table(table(UDP$edad_rango, UDP$sexorec),2), "resultados/impresora.xlsx")

ctable(UDP$sexorec, UDP$edad_rango, prop = "c")

# Tabla de contingencia con summarytools (incluye totales y nombres variable)
tabla <- ctable(UDP$sexorec, UDP$edad_rango,
             prop = "n")

write.xlsx(tabla, "resultados/impresora.xlsx")

# Estadísticos descriptivos
write.xlsx(summary(UDP$edad), "resultados/impresora.xlsx")

