consolidar_csv<-function(CARPETA_INPUT){
  #CARPETA_INPUT: es el nombre de la ruta desde donde se sacaran los archivos a consolidar
  # ejemplos de input del parametro:
  #CARPETA_INPUT<-"BASES"
  #CARPETA_INPUT<-"BASES/carpeta"  
  
  #lectura de los documentos dentro de la ruta dada
  documento<-list.files(CARPETA_INPUT)
  
  #dataframe vacio a rellenar con los datos
  DATAFRAME<-data.frame()
  
  ###Lectura de bases de datos
  for(i in 1:length(documento)){
    
    NOMBRE_ARCHIVO<-paste(CARPETA_INPUT,"/",documento[i],sep="")
    my_data <- read.csv(NOMBRE_ARCHIVO)
    #ir rellenando los archivos  
    DATAFRAME<-rbind(DATAFRAME,my_data)
    rm(my_data)
  }
  
  return(DATAFRAME) #devuelve un dataframe 
}
