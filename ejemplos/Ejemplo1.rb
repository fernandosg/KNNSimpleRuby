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