rm(list=ls())
#-------------------------------------------------------------------------------------------------------------------
# Author: Ruperto Ortiz

# Description	:template de carga y cruce de datos						
# Notes			:  #-------------------------------------------------------------------------------------------------------------------
#carpeta con archivos
#setwd("C:\Users\usuario\Desktop\RANKING_BI")
#getwd()
# install.packages("readxl")
#   detach("package:readxl",unload=TRUE)
#lsf.str("package:readxl")
#?readxl::read_xls

##############################################################################################################
###                                                                                                         #
##    INSTALACION/CARGA DE PAQUETES     & FUNCIONES                                                               #
############################################################################################################
#paquetes
#library("openxlsx")
#readxl::read_xls()
#funciones
#source("FUNCIONES/instalacion_paquetes.R")
source("FUNCIONES/llamado_paquetes.R")
source("FUNCIONES/consolidar_xlsx.R")
#source("FUNCIONES/consolidar_csv.R")

##############################################################################################################
###                                                                                                         #
##    lectura de la informacion dentro de la ventana                                                             #
##                                                                                                          #
#############################################################################################################
CARPETA_INPUT<-"NIVEL/DIA"
NIVEL<-consolidar_xlsx(CARPETA_INPUT)

##############################################################################################################
###                                                                                                         #
##    Lectura de los archivos del ranking                                                              #
##                                                                                                          #
#############################################################################################################
CARPETA_INPUT<-"RANKING/DIA"
RANKING<-consolidar_xlsx(CARPETA_INPUT)

#GUARDA EL ARCHIVO CONSOLDADO DENTRO DE LA CARPETA
# CARPETA_OUTPUT<-"RANKING"
# NOMBRE_ARCHIVO<-"CONSOLIDADO_RANKING_VENTAS.xlsx"
# RUTA<-paste(CARPETA_OUTPUT,"/",NOMBRE_ARCHIVO,sep="")
# write.xlsx(RANKING,RUTA)

###---MODIFICACION A ALGUNO DE LOS VALORES DEL RANKING VENTAS
#names(RANKING)
names(RANKING)[1]<-"GERENCIA"
names(RANKING)[2]<-"SECTOR"
names(RANKING)[3]<-"COD_CN"
names(RANKING)[4]<-"NOMBRE_CN"
names(RANKING)[5]<-"PUNTOS"
names(RANKING)[6]<-"CICLO" #"CICLO_CAPTACION"
names(RANKING)[7]<-"CICLO_FACTURACION"
names(RANKING)[8]<-"CV"
names(RANKING)[9]<-"NOMBRE_CV"
names(RANKING)[10]<-"TIPO"
names(RANKING)[11]<-"FECHA_CAPTACION"
names(RANKING)[12]<-"CANTIDAD_ENVIADA"
names(RANKING)[13]<-"FACTURACION"
names(RANKING)[14]<-"PRECIO_LISTA"
names(RANKING)[15]<-"PRECIO_CN"


#submuestra de los datos del ranking
RANKING_V2<-RANKING %>% filter(TIPO=="Venta")
#cambio dentro de la variable del ciclo
RANKING_V2$CICLO<-paste("C",substr(gsub('/', '',RANKING_V2$CICLO),3,6),substr(gsub('/', '',RANKING_V2$CICLO),1,2),sep="")

#cruce de las bases de datos 
CONSOLIDADO<-merge(RANKING_V2,NIVEL,by=c("COD_CN","CICLO"),all.x = TRUE)
#se asume que si no existe PERFIL, entonces es bronce
CONSOLIDADO$PERFIL[is.na(CONSOLIDADO$PERFIL)]<-"Bronce"

#eliminar el resto de los dataframes que ya no se estan ocupando
rm(RANKING_V2,NIVEL,RANKING) #ELIMINACION DE LA BASE RECIEN LEIDA


##############################################################################################################
###                                                                                                         #
##    ESCRITURA DEL ARCHIVO FINAL                                                               #
##                                                                                                          #
#############################################################################################################
CARPETA_OUTPUT<-"CONSOLIDADO"
NOMBRE_ARCHIVO<-"CONSOLIDADO_CN_RANKING_VENTAS.xlsx"
RUTA<-paste(CARPETA_OUTPUT,"/",NOMBRE_ARCHIVO,sep="")
write.xlsx(CONSOLIDADO,RUTA)
