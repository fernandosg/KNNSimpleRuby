$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib/modulo/'))
require 'normalizacion'
class KNNSimple
  def initialize(lista_datos,valores)
    @coleccion_valores=lista_datos
    @valores=valores
    @columnas = []    
    @ordenados=[]
    @distancias_filas = []    
    @coleccion_varianza = Hash.new
    @coleccion_media = Hash.new
    @coleccion_normalizados = Hash.new
    @coleccion_distancias = Hash.new
    @coleccion_desviacion = Hash.new    
    @cercanos=Hash.new
    if lista_datos.is_a? Hash and valores.is_a? Hash and lista_datos.size == valores.size and (lista_datos.keys - valores.keys).empty?
      lista_datos.each do |llave,valor|
        @columnas<<llave      
      end
      inicio
    else
      raise ArgumentError.new("Ambas colecciones deben de ser del tipo Hash y contener las mismas llaves")
    end
  end

  def inicio
    @coleccion_valores.each do |llave,valor|
      @coleccion_media[llave]=media(valor,llave)
      @coleccion_desviacion[llave]=desviacion(valor,@coleccion_media[llave])
      @coleccion_varianza[llave]=@coleccion_desviacion[llave]**2      
      @coleccion_normalizados[llave]=Normalizacion.todos(valor,@coleccion_desviacion[llave],@coleccion_media[llave])
    end    
  end

  def media(datos,llave)
    total=0
    datos.each do |valor|
      total=total+valor      
    end
    return total/datos.length
  end

  def desviacion(datos,media)
    total=0
    datos.each do |valor|      
      total+=((valor-media)**2)
    end
    desviacion=Math.sqrt(total/(datos.length-1))
    return desviacion
  end

  def varianza(datos,media)
    total=0
    datos.each do |valor|      
      total+=((valor-media)**2)
    end
    return total/datos.length-1
  end
  
  def calcular_distancias_n(vecinos)      
    @coleccion_normalizados[@columnas[0]].length.times do |i|      
      fila_normalizada=Array.new
      @coleccion_normalizados.each do |llave,valor|        
        fila_normalizada<<@coleccion_normalizados[llave][i]
      end           
      sumatoria=0
      posicion=0
      fila_normalizada.each do |valor|
        sumatoria+=((valor-Normalizacion.numero(@valores[@columnas[posicion]],@coleccion_media[@columnas[posicion]],@coleccion_desviacion[@columnas[posicion]]))**2)    
        posicion+=1    
      end
      @distancias_filas<<Math.sqrt(sumatoria)
    end     
    ordenados=@distancias_filas.sort{ |x,y| x <=> y }       
    @columnas.each_with_index do |valor,index|
      datos_cercanos=[]
      vecinos.times do |i|
        datos_cercanos<<@coleccion_valores[valor][buscar_posicion(@distancias_filas,ordenados[i])]   
        @cercanos[valor]=datos_cercanos
      end
    end
    return @cercanos
  end

  def buscar_posicion(ordenados,valor)    
    return ordenados.index(valor)
  end
end