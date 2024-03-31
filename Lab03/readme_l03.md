# Lab 03: Implemetación de 7 segmentos

## Números en hexadecimal

Para la representaciṕon de los números en formato hexadecimal, mediante la fpga, se utilizó el siguiente código:

```
module BCDtoSSeg(
  input [3:0] BCD,
  output reg [0:6] SSeg,
  output [3:0] an
);

  always @(*) begin
    case (~BCD)
      // abcdefg
      4'b0000: SSeg = 7'b0000001; // "0"  
      4'b0001: SSeg = 7'b1001111; // "1" 
      4'b0010: SSeg = 7'b0010010; // "2" 
      4'b0011: SSeg = 7'b0000110; // "3" 
      4'b0100: SSeg = 7'b1001100; // "4" 
      4'b0101: SSeg = 7'b0100100; // "5" 
      4'b0110: SSeg = 7'b0100000; // "6" 
      4'b0111: SSeg = 7'b0001111; // "7" 
      4'b1000: SSeg = 7'b0000000; // "8"  
      4'b1001: SSeg = 7'b0000100; // "9" 
      4'hA: SSeg = 7'b0001000;    // "A"
      4'hB: SSeg = 7'b1100000;    // "B"
      4'hC: SSeg = 7'b0110001;    // "C"
      4'hD: SSeg = 7'b1000010;    // "D"
      4'hE: SSeg = 7'b0110000;    // "E"
      4'hF: SSeg = 7'b0111000;    // "F"
      default: SSeg = 7'b1111111; // Apagar todos los segmentos si no es un BCD válido
    endcase
  end
  assign an = 4'b1110;
endmodule

```
En el cual toma un número BCD de 4 bits como entrada (BCD) y genera las señales para mostrar este número en un display de siete segmentos. Además, también genera las señales de control para activar un display de ánodo común. Notese que ha sido necesario negar la salida para el correcto funcionamiento del mismo, ya que la lógica de la FPGA es negada. 

Por otro lado la disposición de pines se realizó de la siguiente manera:

(Pines)



## Números en decimal

Para visualizar los numeros decimales (solamente del 0 al 9) se limitó el código anterior, borrando todo lo que fuese despues del número 9 y  estableciendo que para cualquier valor de BCD invalido se apagaran todos los segmentos.

```
module BCDtoSSeg(
  input [3:0] BCD,
  output reg [0:6] SSeg,
  output [3:0] an
);

  always @(*) begin
    case (~BCD)
      // abcdefg
      4'b0000: SSeg = 7'b0000001; // "0"  
      4'b0001: SSeg = 7'b1001111; // "1" 
      4'b0010: SSeg = 7'b0010010; // "2" 
      4'b0011: SSeg = 7'b0000110; // "3" 
      4'b0100: SSeg = 7'b1001100; // "4" 
      4'b0101: SSeg = 7'b0100100; // "5" 
      4'b0110: SSeg = 7'b0100000; // "6" 
      4'b0111: SSeg = 7'b0001111; // "7" 
      4'b1000: SSeg = 7'b0000000; // "8"  
      4'b1001: SSeg = 7'b0000100; // "9" 
      4'hA: SSeg = 7'b0001000;    // "A"
      4'hB: SSeg = 7'b1100000;    // "B"
      4'hC: SSeg = 7'b0110001;    // "C"
      4'hD: SSeg = 7'b1000010;    // "D"
      4'hE: SSeg = 7'b0110000;    // "E"
      4'hF: SSeg = 7'b0111000;    // "F"
      default: SSeg = 7'b1111111; // Apagar todos los segmentos si no es un BCD válido
    endcase
  end
  assign an = 4'b1110;
endmodule
```
<video width="320" height="240" controls>
  <source src="images/vidDec.mp4" type="video/mp4">
  Tu navegador no soporta la etiqueta de video.
</video>


## Sumador de 3 bits


## Visualización del sumador de 3 bits


