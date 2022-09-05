# INTRODUCCIÓN A R PARA CIENCIAS SOCIALES
# ESTACIÓN LASTARRIA - AGOSTO/SEPTIEMBRE 2022
# PROFESOR: FELIPE RUIZ

# ---- 1. PAQUETES A INSTALAR ----

install.packages("ggplot2")

# ---- 2. CARGAR DATOS Y PAQUETES ----

# CARGAR BASES DE DATOS Y PAQUETES

load("datos/4-medias_atmos.RData")#C  ARGAR BASE "MEDIAS_ATMOS" - INFORMACIÓN METEROLÓGICA
load("datos/4-mtcars.RData") #CARGAR BASE "MTCARS" INFORMACIÓN TÉCNICA DE AUTOS
load("datos/4-economics.RData") # CARGAR BASE "ECONOMICS" - DATOS DE EMPLEO EEUU
UDP <- readRDS("datos/4-UDP.rds")


# ---- 3. GRÁFICOS CON FUNCIONALIDADES BÁSICAS ----

#Veremos comandos para gráficos que vienen en el paquete básico de R
#Tensión entre visualización y análisis

#Histograma simple
hist(UDP$sexo)

#Convertir sexo a factor para gráfico
UDP$sexof<-factor(UDP$sexo, labels= c("hombre", "mujer"))

#Probar gráfico nuevamente (sólo sirve con vectores numeric)
hist(UDP$sexof)

#COMANDO PLOT (HISTOGRAMA Y GRÁFICOS DISPERSIÓN)

#Versión básica
plot(UDP$sexof)

#Podemos incluir algunos ajustes
plot(UDP$sexof, ylab = "frecuencia", 
     main = "Histograma", 
     sub = "Sexo (frecuencias simples)")

remove(UDP)

# ---- 4. USO DE GGPLOT PARA CREAR GRÁFICOS ----

library(ggplot2) #CARGAR PAQUETE DE GRÁFICOS

#HISTOGRAMA POR DEFECTO
  #Ver base medias
ggplot(medias, aes(x = cloudmid)) +
  geom_histogram()

# INCORPORAR DE A 1 EN GEOM
  # binwidth = 0.4 -> ancho de la barra
  # color="white" -> color de la separación de barras
  # fill=rgb(0.2,0.7,0.1,0.4) -> color de relleno. "rgb" es una especificación de los 4 colores básicos

#GRÁFICO DE BARRAS (cyl = cantidad de cilindros - am = tipo de transmisión)
  #Ver base mtcars

ggplot(mtcars, aes(x = cyl, fill = am)) #definición de los datos a graficar
# ¿Qué sucede?

ggplot(mtcars, aes(x = cyl, fill = am)) +
  geom_bar() #GRÁFICO DE BARRAS - ¿POR QUÉ NO GRAFICA EL TIPO DE TRANSMISIÓN? 
# TIPO DE VARIABLES (CONTINUAS)

ggplot(mtcars, aes(x = factor(cyl), fill = factor(am))) + #INDICAMOS VARIABLES COMO FACTOR
  geom_bar()

#GUARDAR ESPECIFICACIÓN DEL GRÁFICO COMO OBJETO
cilindros  <- ggplot(mtcars, aes(x = factor(cyl), fill = factor(am)))

cilindros + 
  geom_bar(position = "stack")  #POSICIÓN POR DEFECTO (DISTRIBUCIÓN DE Y EN 1 BARRA DE X)

cilindros + 
  geom_bar(position = "fill") #DISTRIBUCIÓN DE Y SEGÚN X EN PROPORCIONES

cilindros +
  geom_bar(position = "dodge") #DISTRIBUCIÓN DE FRECUENCIAS DE Y SEGÚN X EN DISTINTAS BARRAS

#CONFIGURACIÓN ESPECIAL DEL ÚLTIMO GRÁFICO UTILIZANDO CONFIGURACIÓN GEOMÉTRICA DE LOS EJES
# FUNCIÓN "SCALE": NO ES EL PARÁMETRO "AESTHETICS" - ES ESPECIFICACIÓN DE LA GEOMETRÍA

val = c("#E41A1C", "#377EB8")
lab = c("Manual", "Automática")


cilindros +                           # especificación de los datos en los ejes
  geom_bar(position = "dodge") +      # tipo de gráfico
  scale_x_discrete("Cilindros") +     # configuración eje X (etiqueta del eje)
  scale_y_continuous("Cantidad") +    # configuración eje y (etiqueta del eje)
  scale_fill_manual("Transmisión",    # configuración de eje "z" datos de "relleno (etiqueta)
                    values = val,         # color de los valores
                    labels = lab) +       # etiquetas
  labs(title = "Gráfico 1",               # Título y subtítulo
       subtitle = "Tipo de transmisión según tipo de cilindros (frecuencias)") 

#CREAR NUEVA CONFIGURACIÓN DE POSICIÓN -> BARRAS SUPERPUESTAS

pos <- position_dodge(width = 0.2)

#cilindros + 
geom_bar(position = pos, alpha = 0.6) # INSERTAR ESTA LÍNEA EN GRÁFICO ANTERIOR
  # BARRAS SUPERPUESTAS CON TRANSPARENCIA.

#DISPERSIÓN (wt = peso; mg = millas por galón; cyl = cantidad de cilindros)

ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(size = 4) +                            
  scale_x_continuous("Peso") +
  scale_y_continuous("Millas por galón")

#CONFIGURACIÓN GRÁFICO ANTERIOR
  #Cambiar tamaño puntos
  #agregar especificación de forma a geom_point 
      #(shape = 19 - 8 - 1)
      #(alpha =  0.4)

#GRÁFICO DE LÍNEA

#Ver base economics

ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line()

# ¿Cómo podemos graficar la tasa de desempleo?

#Cambiar "unemploy" por "unemploy/pop" -> proporción de población desempleada


                    # LIMPIAR ENTORNO DE TRABAJO #



