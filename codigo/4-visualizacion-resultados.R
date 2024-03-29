# INTRODUCCI�N A R PARA CIENCIAS SOCIALES
# ESTACI�N LASTARRIA - AGOSTO/SEPTIEMBRE 2022
# PROFESOR: FELIPE RUIZ

# ---- 1. PAQUETES A INSTALAR ----

install.packages("ggplot2")

# ---- 2. CARGAR DATOS Y PAQUETES ----

# CARGAR BASES DE DATOS Y PAQUETES

load("datos/4-medias_atmos.RData")#C  ARGAR BASE "MEDIAS_ATMOS" - INFORMACI�N METEROL�GICA
load("datos/4-mtcars.RData") #CARGAR BASE "MTCARS" INFORMACI�N T�CNICA DE AUTOS
load("datos/4-economics.RData") # CARGAR BASE "ECONOMICS" - DATOS DE EMPLEO EEUU
UDP <- readRDS("datos/4-UDP.rds")


# ---- 3. GR�FICOS CON FUNCIONALIDADES B�SICAS ----

#Veremos comandos para gr�ficos que vienen en el paquete b�sico de R
#Tensi�n entre visualizaci�n y an�lisis

#Histograma simple
hist(UDP$sexo)

#Convertir sexo a factor para gr�fico
UDP$sexof<-factor(UDP$sexo, labels= c("hombre", "mujer"))

#Probar gr�fico nuevamente (s�lo sirve con vectores numeric)
hist(UDP$sexof)

#COMANDO PLOT (HISTOGRAMA Y GR�FICOS DISPERSI�N)

#Versi�n b�sica
plot(UDP$sexof)

#Podemos incluir algunos ajustes
plot(UDP$sexof, ylab = "frecuencia", 
     main = "Histograma", 
     sub = "Sexo (frecuencias simples)")

remove(UDP)

# ---- 4. USO DE GGPLOT PARA CREAR GR�FICOS ----

library(ggplot2) #CARGAR PAQUETE DE GR�FICOS

#HISTOGRAMA POR DEFECTO
  #Ver base medias
ggplot(medias, aes(x = cloudmid)) +
  geom_histogram()

# INCORPORAR DE A 1 EN GEOM
  # binwidth = 0.4 -> ancho de la barra
  # color="white" -> color de la separaci�n de barras
  # fill=rgb(0.2,0.7,0.1,0.4) -> color de relleno. "rgb" es una especificaci�n de los 4 colores b�sicos

#GR�FICO DE BARRAS (cyl = cantidad de cilindros - am = tipo de transmisi�n)
  #Ver base mtcars

ggplot(mtcars, aes(x = cyl, fill = am)) #definici�n de los datos a graficar
# �Qu� sucede?

ggplot(mtcars, aes(x = cyl, fill = am)) +
  geom_bar() #GR�FICO DE BARRAS - �POR QU� NO GRAFICA EL TIPO DE TRANSMISI�N? 
# TIPO DE VARIABLES (CONTINUAS)

ggplot(mtcars, aes(x = factor(cyl), fill = factor(am))) + #INDICAMOS VARIABLES COMO FACTOR
  geom_bar()

#GUARDAR ESPECIFICACI�N DEL GR�FICO COMO OBJETO
cilindros  <- ggplot(mtcars, aes(x = factor(cyl), fill = factor(am)))

cilindros + 
  geom_bar(position = "stack")  #POSICI�N POR DEFECTO (DISTRIBUCI�N DE Y EN 1 BARRA DE X)

cilindros + 
  geom_bar(position = "fill") #DISTRIBUCI�N DE Y SEG�N X EN PROPORCIONES

cilindros +
  geom_bar(position = "dodge") #DISTRIBUCI�N DE FRECUENCIAS DE Y SEG�N X EN DISTINTAS BARRAS

#CONFIGURACI�N ESPECIAL DEL �LTIMO GR�FICO UTILIZANDO CONFIGURACI�N GEOM�TRICA DE LOS EJES
# FUNCI�N "SCALE": NO ES EL PAR�METRO "AESTHETICS" - ES ESPECIFICACI�N DE LA GEOMETR�A

val = c("#E41A1C", "#377EB8")
lab = c("Manual", "Autom�tica")


cilindros +                           # especificaci�n de los datos en los ejes
  geom_bar(position = "dodge") +      # tipo de gr�fico
  scale_x_discrete("Cilindros") +     # configuraci�n eje X (etiqueta del eje)
  scale_y_continuous("Cantidad") +    # configuraci�n eje y (etiqueta del eje)
  scale_fill_manual("Transmisi�n",    # configuraci�n de eje "z" datos de "relleno (etiqueta)
                    values = val,         # color de los valores
                    labels = lab) +       # etiquetas
  labs(title = "Gr�fico 1",               # T�tulo y subt�tulo
       subtitle = "Tipo de transmisi�n seg�n tipo de cilindros (frecuencias)") 

#CREAR NUEVA CONFIGURACI�N DE POSICI�N -> BARRAS SUPERPUESTAS

pos <- position_dodge(width = 0.2)

#cilindros + 
geom_bar(position = pos, alpha = 0.6) # INSERTAR ESTA L�NEA EN GR�FICO ANTERIOR
  # BARRAS SUPERPUESTAS CON TRANSPARENCIA.

#DISPERSI�N (wt = peso; mg = millas por gal�n; cyl = cantidad de cilindros)

ggplot(mtcars, aes(x = wt, y = mpg, color = cyl)) +
  geom_point(size = 4) +                            
  scale_x_continuous("Peso") +
  scale_y_continuous("Millas por gal�n")

#CONFIGURACI�N GR�FICO ANTERIOR
  #Cambiar tama�o puntos
  #agregar especificaci�n de forma a geom_point 
      #(shape = 19 - 8 - 1)
      #(alpha =  0.4)

#GR�FICO DE L�NEA

#Ver base economics

ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line()

# �C�mo podemos graficar la tasa de desempleo?

#Cambiar "unemploy" por "unemploy/pop" -> proporci�n de poblaci�n desempleada


                    # LIMPIAR ENTORNO DE TRABAJO #



