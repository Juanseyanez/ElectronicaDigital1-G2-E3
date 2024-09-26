# Calculadora de 4 bits en FPGA

## Descripción general

Este proyecto consiste en la implementación de una calculadora de 4 bits en una FPGA Altera Cyclone IV. La calculadora puede realizar cuatro operaciones básicas: suma, resta, multiplicación y división. Utiliza un teclado para ingresar los operandos y seleccionar la operación, y una pantalla para mostrar el resultado.

### Operaciones soportadas:
- **Suma**: \( A + B \)
- **Resta**: \( A - B \)
- **Multiplicación**: \( A 	imes B \)
- **División**: \( A / B \) (con manejo de error para la división por 0)

Esta calculadora es adecuada para aplicaciones simples que requieren operaciones aritméticas básicas y tiene la capacidad de gestionar errores comunes, como la división entre cero.

## Estructura del proyecto

El diseño de la calculadora está compuesto por varios módulos en Verilog que se interconectan entre sí. El módulo principal de la calculadora se encarga de instanciar los módulos de cada operación y seleccionar cuál se debe ejecutar según la entrada del usuario.

### Diagrama de la máquina de estados

![Diagrama]()

Este diagrama ilustra el flujo del sistema, con estados bien definidos para cada operación aritmética (suma, resta, multiplicación y división), además de un manejo de errores que se activa durante una operación no válida, como una división entre cero. Las transiciones entre estados se basan en las entradas del usuario y las señales generadas por los cálculos.

### Módulos principales

#### 1. **Módulo `calculadora`**
Este es el módulo principal que instancia las operaciones y controla la lógica de selección de la operación con base en la entrada del usuario. 

```verilog
module calculadora(
    input [3:0] A, B,      // Entradas de 4 bits
    input [1:0] operacion, // Selector de operación
    output reg [7:0] resultado, // Salida de 8 bits
    output reg error // Indicador de error para división por 0
);
```

**Conexiones del módulo `calculadora`**:
- **Entradas**:
  - `A` y `B`: operandos de 4 bits.
  - `operacion`: un valor de 2 bits que selecciona la operación:
    - `00`: Suma
    - `01`: Resta
    - `10`: Multiplicación
    - `11`: División
- **Salidas**:
  - `resultado`: el resultado de la operación (hasta 8 bits).
  - `error`: indicador de error para manejar divisiones por 0.

Este módulo se encarga de recibir las señales de entrada y, dependiendo del selector de operación, ejecuta la lógica correspondiente para cada cálculo. En caso de una división por cero, el módulo establece la salida de error a 1.

#### 2. **Módulo `sumador_4bits`**
Este módulo realiza la suma de los operandos `A` y `B`.

```verilog
module sumador_4bits(
    input [3:0] A, B,
    output [3:0] S
);
```
- **Entrada**: operandos de 4 bits `A` y `B`.
- **Salida**: resultado de la suma `S` de 4 bits.

El sumador es un módulo sencillo que utiliza el operador de adición de Verilog para realizar la operación de suma.

#### 3. **Módulo `restador_4bits`**
Este módulo realiza la resta de los operandos `A` y `B`.

```verilog
module restador_4bits(
    input [3:0] A, B,
    output [3:0] R
);
```
- **Entrada**: operandos de 4 bits `A` y `B`.
- **Salida**: resultado de la resta `R` de 4 bits.

El restador sigue la misma lógica que el sumador, utilizando el operador de resta en Verilog.

#### 4. **Módulo `multiplicador_4bits`**
Este módulo realiza la multiplicación de los operandos `A` y `B`.

```verilog
module multiplicador_4bits(
    input [3:0] A, B,
    output [7:0] P
);
```
- **Entrada**: operandos de 4 bits `A` y `B`.
- **Salida**: resultado de la multiplicación `P` de 8 bits.

Dado que el producto de dos números de 4 bits puede tener hasta 8 bits, la salida `P` es de 8 bits.

#### 5. **Módulo `divisor_4bits`**
Este módulo realiza la división de los operandos `A` y `B`. También incluye la lógica para manejar el caso de división por 0.

```verilog
module divisor_4bits(
    input [3:0] A, B,
    output [3:0] Q,
    output reg error
);
```
- **Entrada**: operandos de 4 bits `A` y `B`.
- **Salida**: cociente `Q` de 4 bits.
- **Error**: indicador de error en caso de división por 0.

Este módulo verifica si el divisor `B` es cero. En caso afirmativo, activa la señal de error y establece el cociente a cero.

# Implementación de un Teclado Matricial en una FPGA

## Descripción del Teclado Matricial
Un teclado matricial es un conjunto de botones organizados en una cuadrícula de filas y columnas. En una FPGA, se puede escanear el teclado activando las filas secuencialmente y leyendo las columnas para detectar cuál tecla ha sido presionada.

### Conexión del Teclado Matricial
Un teclado matricial 4x4 tiene:
- **4 pines de fila** (F0-F3)
- **4 pines de columna** (C0-C3)

El objetivo es detectar cuál tecla ha sido presionada mediante la activación de las filas y la lectura de las columnas.

### Proceso de Escaneo
1. Activar secuencialmente las filas, una a la vez.
2. Leer las columnas para detectar cuál tecla fue presionada. Si se detecta un valor bajo (0) en alguna columna, significa que la tecla en la intersección de esa fila y columna fue presionada.
3. Una vez detectada la fila y la columna, se puede identificar la tecla presionada mediante una tabla de asignación.

### Escaneo del Teclado Matricial

```verilog
module teclado_matricial(
    input clk,            // Reloj de la FPGA
    input [3:0] columnas, // Entradas de las columnas del teclado
    output reg [3:0] filas,  // Salidas para las filas del teclado
    output reg [3:0] tecla   // Valor de la tecla presionada
);
    reg [1:0] estado;  // Estado para seleccionar la fila activa

    always @(posedge clk) begin
        estado <= estado + 1;
        case (estado)
            2'b00: filas = 4'b0111; // Activar la primera fila
            2'b01: filas = 4'b1011; // Activar la segunda fila
            2'b10: filas = 4'b1101; // Activar la tercera fila
            2'b11: filas = 4'b1110; // Activar la cuarta fila
        endcase
    end

    always @(posedge clk) begin
        case (estado)
            2'b00: if (columnas != 4'b1111) tecla <= {2'b00, columnas}; // Fila 1
            2'b01: if (columnas != 4'b1111) tecla <= {2'b01, columnas}; // Fila 2
            2'b10: if (columnas != 4'b1111) tecla <= {2'b10, columnas}; // Fila 3
            2'b11: if (columnas != 4'b1111) tecla <= {2'b11, columnas}; // Fila 4
        endcase
    end
endmodule
```
Cada ciclo de reloj activa una fila y lee las columnas. Si se detecta una columna baja (0), se identifica la tecla presionada combinando la fila activa y la columna.
El valor de la tecla presionada es almacenado en el registro tecla.
### Selección de Operaciones mediante el Teclado Matricial
En este caso, el teclado matricial no solo se usa para ingresar números, sino también para seleccionar las operaciones que la calculadora realizará, como la suma, resta, multiplicación y división.

### Asignación de Teclas para Operaciones
Se puede asignar una tecla específica para cada operación. Por ejemplo:


Tecla 1: Suma


Tecla 2: Resta


Tecla 3: Multiplicación


Tecla 4: División


En este caso, cuando se presiona una de estas teclas, se activa el módulo correspondiente para realizar la operación.

```verilog
module calculadora_con_teclado(
    input clk,             // Reloj de la FPGA
    input [3:0] columnas,  // Entradas de las columnas del teclado
    output reg [3:0] filas, // Salidas para las filas del teclado
    output reg [1:0] operacion // Tipo de operación seleccionada
);
    reg [1:0] estado;      // Estado para controlar la fila activa
    reg [3:0] tecla;       // Tecla presionada

    always @(posedge clk) begin
        estado <= estado + 1;
        case (estado)
            2'b00: filas = 4'b0111; // Activar primera fila
            2'b01: filas = 4'b1011; // Activar segunda fila
            2'b10: filas = 4'b1101; // Activar tercera fila
            2'b11: filas = 4'b1110; // Activar cuarta fila
        endcase
    end

    always @(posedge clk) begin
        case (estado)
            2'b00: if (columnas != 4'b1111) tecla <= {2'b00, columnas}; // Tecla en fila 1
            2'b01: if (columnas != 4'b1111) tecla <= {2'b01, columnas}; // Tecla en fila 2
            2'b10: if (columnas != 4'b1111) tecla <= {2'b10, columnas}; // Tecla en fila 3
            2'b11: if (columnas != 4'b1111) tecla <= {2'b11, columnas}; // Tecla en fila 4
        endcase
    end

    // Decodificación de operaciones a partir de la tecla presionada
    always @(posedge clk) begin
        case (tecla)
            4'b0001: operacion <= 2'b00; // Suma
            4'b0010: operacion <= 2'b01; // Resta
            4'b0011: operacion <= 2'b10; // Multiplicación
            4'b0100: operacion <= 2'b11; // División
            default: operacion <= 2'b00; // Valor por defecto: suma
        endcase
    end
endmodule
```
Escaneo del teclado: Se sigue el mismo proceso de escaneo de filas y columnas para detectar cuál tecla ha sido presionada.


Decodificación de la operación: Dependiendo de la tecla presionada, se selecciona una operación (suma, resta, multiplicación o división). La operación seleccionada se almacena en el registro operacion, que se utilizará para activar el módulo correspondiente en la calculadora.


### Flujo de la calculadora

1. **Entrada de datos**: El usuario ingresa dos operandos de 4 bits a través de un teclado conectado a la FPGA.
2. **Selección de operación**: El usuario selecciona la operación aritmética que desea realizar.
3. **Cálculo**: La calculadora ejecuta la operación correspondiente y muestra el resultado en la pantalla. Si hay un error (división por 0), se activa la señal de error y el resultado será 0.
4. **Salida**: El resultado se muestra en una pantalla conectada a la FPGA.

