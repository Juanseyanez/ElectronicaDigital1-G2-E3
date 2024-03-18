*Cración y desarrollo del proyecto en Quartus*
-

En principio, se debe correr el entorno de desarrollo dec Quartus y seleccionar la opción *New Project Wizard*, desde la cual se deben seguir lo pasos de creación del proeyecto. Se recomienda destinar una carpeta específica para el proyecto, por ahora no adicionar archivos al proyecto y como se trata de una simulación cualquier FPGA debería funcionar.
![Figura 1](imagenes/figura1.png)
Para la configuración con Questa, se selcciona de esta forma
![Figura 2](imagenes/figura2.png)
Una vez creado el proyecto se agrega un nuevo archivo de tipo VHDL, en el cual se redacta el código para describir las compuertas deseados.
En primer lugar se usa la libreria del IEEE para *Standard Logic* como
  
    ```Library IEEE;```
    ```use ieee.std_logic_1164.all;```
Posteriormente se definen los pines de entrada y salida en ```Entity``` dandoles tipo *std_logic*. Después se define la arquitectura como el flujo de datos para estos pines, con cada salida como la operación de las entradas
![Figura 3](imagenes/figura3.png)
Asegurandose de no tener errores en código se procede a hacer la compilación y visualizar la forma en qué compilo una vez sea exitosa.
*COMPUERTAS A SIMULAR: Not , and , or*

COMPUERTA NOT
![imagen](https://github.com/Juanseyanez/ElectronicaDigital1-G2-E3/assets/150001189/9af03a8d-529b-42c3-8296-d5c6bde38ee9)
COMPUERTA AND

![imagen](https://github.com/Juanseyanez/ElectronicaDigital1-G2-E3/assets/150001189/817b261b-6fb9-434f-8073-ba444ce19592)
tABLA DE VERDAD AND
![imagen](https://github.com/Juanseyanez/ElectronicaDigital1-G2-E3/assets/150001189/6ce10dad-d74e-4374-bf47-8af74e3dfded)



![Figura 4](imagenes/figura4.png)
