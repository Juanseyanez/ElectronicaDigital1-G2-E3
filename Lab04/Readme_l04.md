# Lab 04: Contador de segundos, décimas y centésimas de segundos

Este proyecto implementó un cronómetro digital para mostrar el tiempo transcurrido en distintas escalas: segundos, décimas, centésimas y milésimas de segundo. El sistema utilizó un display de 7 segmentos con multiplexación, controlado por una FPGA Cyclone IV. Un reloj de 50 MHz fue usado como entrada, y se habilitaron modos de visualización seleccionables mediante interruptores. A continuación, se detallan los módulos del cronómetro, la estructura del sistema, y la lógica aplicada para controlar el display, además de las pruebas de simulación realizadas.

## Descripción General del Sistema

Para el funcionamiento del contador, fue establecido que el sistema recibiera como entradas un reloj de 50 MHz (`clk`), un reset (`rst`) y tres interruptores (`Modo1`, `Modo2`, `Modo3`) para seleccionar el modo de visualización. El tiempo se mostró en un display de 7 segmentos, controlado por los ánodos (`an`) y los segmentos (`seg`) que componían cada dígito. Posterior a eso, en el display de 4 dígitos se mostró el tiempo en distintos formatos según el modo seleccionado.

```verilog
```verilog
module counter(
    input clock,              // Reloj de 50 MHz
    input reset,              // Reset
    input Modo_A,          // Modo de tiempo 1
    input Modo_B,          // Modo de tiempo 2
    input Modo_C,          // Modo de tiempo 3
    output reg [6:0] segmentos,   // Segmentos del display
    output reg [3:0] an     // Ánodos del display
);
```

El contador dispuso de diferentes parámetros utilizados para manejar el modo de visualización y controlar tanto frecuencia del reloj como la multiplexación del display. Las constantes definen los valores de los contadores para diferentes frecuencias (1 Hz, 10 Hz, 100 Hz y 1 kHz), y un contador principal se utiliza para dividir la señal de reloj entrante.

```verilog
parameter f1s = 50000000;     // Contador para 1 Hz
parameter f01s = 5000000;   // Contador para 10 Hz
parameter f001s = 500000;     // Contador para 100 Hz
parameter f0001s = 50000;       // Contador para 1 kHz
localparam WIDTH = $clog2(f1s); // Ancho del contador basado en la mayor frecuencia
reg [WIDTH-1:0] contador_frec;          // Contador de frecuencia
reg [1:0] modo;                   // Registro para el modo seleccionado
reg clk_modo;                     // Señal de reloj modificada según el modo
reg [13:0] contador_seg;           // Contador para las unidades de tiempo
reg [1:0] digito_activo;           // Selector de dígito activo para la multiplexación
reg [15:0] mux_contador;           // Contador para generar el reloj de multiplexación
```

## Máquina de Estados y divisor de frecuencias

El sistema implementó una máquina de estados que permitió alternar entre los diferentes modos de visualización de tiempo. Dependiendo de la combinación de los interruptores (Modo_A, Modo_B, Modo_C), se asignaba un valor al registro modo. Este valor controlaba la frecuencia con la que el cronómetro realizaba el conteo y, en consecuencia, el formato del tiempo que se desplegaba en la pantalla.

Además, se utilizó un divisor de frecuencia para ajustar la señal de reloj de entrada y generar diferentes frecuencias según el modo de visualización seleccionado. Este divisor contaba los ciclos del reloj de 50 MHz y emitía un pulso en la señal clk_modo cuando se alcanzaba el valor correspondiente al modo activo. Dicho pulso se utilizó para incrementar el contador de tiempo (contador_seg), que llevaba la cuenta de las unidades de tiempo que se mostraron en el display.

```verilog
always @(posedge clk or posedge rst) begin
    if (rst) begin
        mode <= 2'b00;
    end else begin
        case ({switch3, switch2, switch1})
            3'b001: mode <= 2'b01; // Décimas de segundo
            3'b010: mode <= 2'b10; // Centésimas de segundo
            3'b100: mode <= 2'b11; // Milésimas de segundo
            default: mode <= 2'b00; // Segundos
        endcase
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        counter <= 'd0;
        clk_mode <= 0;
    end else begin
        case (mode)
            2'b00: begin // Segundos
                if (counter == cont_1s - 1) begin
                    counter <= 'd0;
                    clk_mode <= 1;
                end else begin
                    counter <= counter + 1;
                    clk_mode <= 0;
                end
            end
            2'b01: begin // Décimas de segundo
                if (counter == cont_100ms - 1) begin
                    counter <= 'd0;
                    clk_mode <= 1;
                end else begin
                    counter <= counter + 1;
                    clk_mode <= 0;
                end
            end
            2'b10: begin // Centésimas de segundo
                if (counter == cont_10ms - 1) begin
                    counter <= 'd0;
                    clk_mode <= 1;
                end else begin
                    counter <= counter + 1;
                    clk_mode <= 0;
                end
            end
            2'b11: begin // Milésimas de segundo
                if (counter == cont_1ms - 1) begin
                    counter <= 'd0;
                    clk_mode <= 1;
                end else begin
                    counter <= counter + 1;
                    clk_mode <= 0;
                end
            end
        endcase
    end
end
```

## Implementación en el 7 Segmentos
Para controlar los cuatro dígitos del display utilizando un solo conjunto de señales de segmentos (segmentos), se implementó un proceso de multiplexación. La multiplexación permitió activar un dígito a la vez, cambiando entre los dígitos de manera rápida para que todos parecieran encendidos al mismo tiempo.

Se generó una señal de multiplexación a aproximadamente 3 kHz mediante un contador (mux_contador). Luego, en cada ciclo del reloj de multiplexación (clk_mux), el sistema seleccionó uno de los cuatro dígitos activando el ánodo correspondiente (an). El valor de cada dígito se obtuvo dividiendo el contador de tiempo (contador_seg) en unidades, decenas, centenas y millares.

```verilog
reg [15:0] mux_contador; // Contador para generar clk_mux
wire clk_mux;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        mux_contador <= 16'd0;
    end else if (mux_contador == 16'd16666) begin  // 50 MHz / 16,667 ≈ 3 kHz
        mux_contador <= 16'd0;
    end else begin
        mux_contador <= mux_contador + 1;
    end
end

assign clk_mux = (mux_contador == 16'd16666); // Genera un pulso de 3 kHz

always @(posedge clk_mux or posedge reset) begin
    if (reset) begin
        digito_activo <= 2'd0;
    end else begin
        digito_activo <= digito_activo + 1;
    end
end

// Segmentación del valor del contador en 4 dígitos
wire [3:0] dig1, dig2, dig3, dig4;
assign dig1 = contador_seg % 10;
assign dig2 = (contador_seg / 10) % 10;
assign dig3 = (contador_seg / 100) % 10;
assign dig4 = (contador_seg / 1000) % 10;

reg [3:0] digito_actual; // Dato del dígito actual

always @(*) begin
    case (digito_activo)
        2'd0: digito_actual = dig1;  // Unidades
        2'd1: digito_actual = dig2;  // Decenas
        2'd2: digito_actual = dig3;  // Centenas
        2'd3: digito_actual = dig4;  // Unidades de millar
        default: digito_actual = 4'd0;
    endcase
end

// Lógica para manejar los ánodos y segmentos
always @(*) begin
    an = 4'b1111;  // Desactivar todos los ánodos por defecto
    case (digito_activo)
        2'd0: an = 4'b1110; // Activar dígito 0
        2'd1: an = 4'b1101; // Activar dígito 1
        2'd2: an = 4'b1011; // Activar dígito 2
        2'd3: an = 4'b0111; // Activar dígito 3
    endcase

    case (digito_actual)
        4'd0: segmentos = 7'b1000000; // 0
        4'd1: segmentos = 7'b1111001; // 1
        4'd2: segmentos = 7'b0100100; // 2
        4'd3: segmentos = 7'b0110000; // 3
        4'd4: segmentos = 7'b0011001; // 4
        4'd5: segmentos = 7'b0010010; // 5
        4'd6: segmentos = 7'b0000010; // 6
        4'd7: segmentos = 7'b1111000; // 7
        4'd8: segmentos = 7'b0000000; // 8
        4'd9: segmentos = 7'b0010000; // 9
        default: segmentos = 7'b1111111; // Apagar segmentos por defecto
    endcase
end
```


Previo a la implementación del código en la FPGA, fue necesario realizar las respectivas simulaciones, las mismas fueron visualizadas utilizando GTKwave.

### Simulación a 1Hz:
Esta simulación muestra el comportamiento del contador en el modo de **segundos**. El reloj (`clk`) funciona a 50 MHz, y el sistema divide esta señal para contar en segundos completos. Las señales `C[3:0]` y `D[3:0]` representan las unidades y decenas de los segundos en un display de 7 segmentos. La señal `U[3:0]` permanece indefinida en este modo. A medida que el tiempo avanza, se observa cómo `C[3:0]` y `D[3:0]` incrementan su valor, representando el tiempo transcurrido en segundos.

![Simulacion 1](images/Simulación1Hz.png)


### Simulación a 100Hz:
En esta simulación, el contador se encuentra en el modo de **centésimas de segundo**. Las señales `C[3:0]` y `D[3:0]` están cambiando más rápidamente en comparación con el modo de segundos, lo que refleja un conteo de centésimas. La frecuencia del reloj ha sido dividida adecuadamente para que el sistema realice el conteo a 100 Hz, permitiendo que las centésimas de segundo se muestren en el display.

![Simulacion 100](images/Simulación100Hz.png)



### Simulación a 1kHz):
La tercera simulación representa el modo de **milésimas de segundo**. En esta simulación de más larga duración, las señales `C[3:0]` y `D[3:0]` muestran el conteo rápido en milésimas de segundo, lo que implica una división del reloj a 1 kHz. El reloj y las señales avanzan rápidamente debido a la alta frecuencia de conteo, y el sistema está preparado para mostrar milésimas de segundo en el display multiplexado.

![Simulacion 1k](images/Simulación1kHz.png)

## Conclusión
El contador digital logró visualizar el tiempo en diferentes formatos, controlado mediante una máquina de estados y un divisor de frecuencia. Los resultados obtenidos cumplieron con las expectativas establecidas para este proyecto. Las pruebas de simulación verificaron la correcta operación de la máquina de estados y la precisión del conteo de tiempo.

## Vídeo de la implementación del contador en la FPGA






