Lab 02: Implemetación de sumador de 1 bit y de 4 bit en FPGA.
-

Este laboratorio inició con la construcción de un sumador de 4 bits, para el cual se instancia el sumador de 1 bit creado en el laboratorio 01, para de esta manera encadenarlos y lograr tener el sumador de 4 bits correctamente. Es por este motivo, que se prefirió ubicar el sumador de 1 bit en la misma carpeta en la cual se iba a crear e implementar el sumador de 4 bits, buscando facilitar la instanciación del primero.
(Imagen de Archivos)
Ya con esto, se procedió a crear el sumador de 4 bits utilizando VScode como herramienta para describir. Se inició llamando al sumador de 1 bit, para después establecer cuales iban a ser las respectivas entradas y salidas del sumador. Estableciendo a y b como entradas, las cuales van a ser entradas de 4 bits, S se establece como una salida de 4 bits y los Carry in y Carry out, se definen como una entrada y salida de 1 bit respectivamente. A parte de esto, se definen los Carry out intermedios (c1, c2, c3)y se procede a instanciar 4 veces el sumador de 1 bit. 
* Primero -> Establece el bit menos significativo de la suma
* Segundo -> Establece el segundo bit
* Tercero -> Tercer bit de la suma
* Cuarto -> Equivale al bit mas significativo de la suma
Es entonces en la cuarta instancia donde se ubica el Carry out.
(Imagen Sum4b)


