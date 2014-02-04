KNNSimpleRuby
=============

Implementación de KNN con normalización unidad tipificada

Instalacion
------------
Una vez descargado el fichero KNNSimple-0.0.1.gem
1.-Dirigite a la ubicacion de la descarga
2.-Ejecutar gem install KNNSimple-0.0.1.gem

¿Como funciona?
--------------------
Para el correcto manejo, los valores a comparar y tener como base de comparacion, deben de estar dentro de una coleccion de tipo Hash.
Lo importante es que deben de tener la misma cantidad de valores (no de registros).
Dentro de cada coleccion de tipo Hash, los registros deben de estar almacenados en una coleccion de tipo Array.

Ejemplo de uso
-----------------
    require 'knn'
    datos=Array.new
    datos<<71500
    datos<<17300
    datos<<46327
    datos<<124743
    datos<<37111
    datos<<36566
    datos<<69813
    datos<<114846
    datos<<39706
    datos<<62292
    columnas=Hash.new
    calcular =Hash.new
    columnas['Edad']=[80,20,38,70,60,40,55,64,50,68]
    columnas['kilometraje']=datos
    calcular['Edad']=60
    calcular['kilometraje']=5000
    normalizar = KNNSimple.new(columnas,calcular)
    resultado=Hash.new
    resultado=normalizar.calcular_distancias_n(5)
    resultado.each do |nombre,valor|
      puts "Resultado: #{nombre} valor #{valor}"
    end
    
