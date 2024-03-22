*Creación y desarrollo del proyecto en Quartus*
-
### 1. Compuertas lógicas

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

TABLA DE VERDAD AND

![imagen](https://github.com/Juanseyanez/ElectronicaDigital1-G2-E3/assets/150001189/7fb79d37-37dc-43f7-9887-bf98367563b2)

COMPUERTA OR
![imagen](https://github.com/Juanseyanez/ElectronicaDigital1-G2-E3/assets/150001189/a9a1183d-e47d-4e12-bdcf-fb9a8bb9369d)

TABLA DE VERDAD OR

![imagen](https://github.com/Juanseyanez/ElectronicaDigital1-G2-E3/assets/150001189/da9fdb6c-8980-44ec-a95b-aae573077b2c)

COMPUERTA XOR
TABLA DE VERDAD XOR
![imagen](https://github.com/Juanseyanez/ElectronicaDigital1-G2-E3/assets/150001189/646083b4-994d-4852-9581-3d924a10bb33)


![Figura 4](imagenes/figura4.png)

### 2. Sumador de un bit.

De manera similar que con las compuertas, se define el proyecto para el desarrollo del sumador, allí se redacta la entidad del sumador tomando como entradas A, B y el acarreo de entrada Ci de un bit. Asimismo, como salidas, la salida general y el acarreo de salida.
![Figura 8](imagenes/figura8.png)
Para esta configuración del sumador se describe el archivo testbench de la siguiente forma.
![Figura 9](imagenes/figura9.png)
Con estos archivos se crea un proyecto en el simulador *Questa* 
![Figura 10](imagenes/figura10.png)
Añandiendolos de la forma
![Figura 11](imagenes/figura11.png)
Y se usan los comandos:
* ```vsim testbench``` para invocar el simulador con el banco de pruebas
* ```add wave *``` para importar las señales de entrada definidas
* ```run 90ns``` para correr la simulación el tiempo suficiente para comprobar la tabla de verdad esperada
![Figura 12](imagenes/figura12.png)
