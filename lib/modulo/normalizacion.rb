module Normalizacion  
  def Normalizacion.todos(datos,desviacion_estandar,media)
    datos_normalizados=Array.new
    datos.each do |valor|
      resultado=((valor-media)/desviacion_estandar)              
      datos_normalizados<<resultado            
    end
    return datos_normalizados
  end

  def Normalizacion.numero(valor,media,desviacion_estandar)
    normalizado=((valor-media)/desviacion_estandar).round(2)
    return normalizado
  end
end