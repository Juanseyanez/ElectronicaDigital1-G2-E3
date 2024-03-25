`include "Sum4b.v"
`timescale 1ps / 1ps

module Sum4b_tb;

// Parámetros
parameter WIDTH = 4;

// Definición de señales
reg [WIDTH-1:0] a_tb, b_tb;
reg cin_tb;

wire [WIDTH-1:0] S_tb;
wire cout_tb;

// Instanciación del sumador de 4 bits
Sum4b uut(a_tb,b_tb,cin_tb,S_tb,cout_tb
);

// Estímulos
initial begin
a_tb = 1011;
b_tb = 1111;
cin_tb = 0;
#1 //cantiadad de unidades de tiempo que quiero que las variables esten en 0
a_tb = 1101;
b_tb = 0;
cin_tb = 0;
#1
a_tb = 1100;
b_tb = 1000;
cin_tb = 0;
end

initial begin: TEST_CASE
    $dumpfile("Sum4b_sim.vcd");
    $dumpvars(-1,uut);
    #5; $finish;
end

endmodule