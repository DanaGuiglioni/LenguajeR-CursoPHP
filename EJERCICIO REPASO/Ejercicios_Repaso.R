#ULTIMA CLASE - PRACTICA R

##VECTORES Y MATRICES

#Genero vector
set.seed(99)
v = sample(1:100, 12)
v

#Genero matriz
M = matrix(v, 3, byrow = TRUE)
M

#Ultima columna
M[,ncol(M)]

#Maximo elemento impar
max(M[M%%2 == 1])

#Promedio x fila
apply(M, 1, mean)

#Maximo entre sumatorias x columna
max(apply(M, 2, sum))

#Multiplico x 2 (menos segunda columna)
M[,-2] = M[,c(1, 3, 4)]*2
M

#Armo nuevo vector c/ primera y segunda fila
V2 = as.vector(M[1:2,])
V2 = c(M[1,], M[2,])
V2

#Elementos multiplos de 3
V2[V2%%3==0]

#Mayor numero par
max(V2[V2%%2 == 0])

#Reemplazo por 0 elementos no multiplos de 4
V2[V2%%4!=0] = 0
V2

#Contar multiplos de 2 y mayores que 40
sum(V2%%2 == 0 & V2>40) 

###DATA FRAMES###

#Ejecuto acciones
library(ggplot2)
data(msleep)
View(msleep)

suenio = subset(data.frame(msleep), select = c(name, vore, sleep_total, bodywt))
suenio = na.omit(suenio)
eliminadas = na.action(suenio)
suenio$vore = as.factor(suenio$vore)
dim(suenio)

#Ejecuto head
head(suenio)

#Subconjunto con carnivoros y sin columna vore
CARNIS = subset(suenio, vore=="carni", select = -vore)
CARNIS
head(CARNIS)

#Total carnivoros > 10kg y 5-10hs de sueño
sum(CARNIS$bodywt>10 & CARNIS$sleep_total<10 & CARNIS$sleep_total>5)

#Subconjunto > 100kg y -10hs de sueño
GRANDES = subset(suenio, suenio$bodywt>100 & suenio$sleep_total<10)
GRANDES

#Total carnivoros en GRANDES
sum(GRANDES$vore == "carni")

#Total por tipo de alimentacion en "suenio"
summary(suenio$vore)

#Nombre del animal que menos duerme en "suenio"
min(suenio$sleep_total)
subset(suenio, suenio$sleep_total == (min(suenio$sleep_total)), select = "name")

#Nombre y forma de alimentacion animal mas pesado en "GRANDES"
max(GRANDES$bodywt)
subset(GRANDES, GRANDES$bodywt == max(GRANDES$bodywt), select = c("name", "vore"))

#Promedio de peso s/tipo alimentacion
tapply(suenio$bodywt, suenio$vore, mean)

#Grafico de torta de de animales s/tipo de alimentacion
summary(suenio$vore)
pie(summary(suenio$vore), main = "Alimentación: proporciones")

#Subconjunto sin "African elephant" y "Asian elephant"
suenio2 = subset(suenio, suenio$name!="African elephant" & suenio$name!="Asian elephant")
suenio2
sum(suenio$name=="African elephant")
sum(suenio$name=="Asian elephant")

#Grafico de dispersion que relacione el peso y la cantidad de horas de sueño en "suenio2"
plot(suenio2$sleep_total, suenio2$bodywt, type = "p", main = "Peso vs Horas de sueño")

#Agregar lineas al grafico de dispersión
abline(h = mean(suenio2$bodywt), col = "red")
abline(v = mean(suenio2$sleep_total), col = "green")

#Grafico de cajas de cuantas hs duermen segun tipo de alimentacion
boxplot(suenio$sleep_total ~ suenio$vore, main = "¿Duermen segun lo que comen?")
# Los mas dormilones son los insectos
