`include "Sum.v"
`timescale 1ns/1ns
module Sum_tb(); //archivo para la simulacion

reg a_tb;
reg b_tb;
reg cin_tb;

wire S_tb;
wire cout_tb;

Sum uut(a_tb,b_tb,cin_tb,S_tb,cout_tb);  //Se instancia el documento LAB para ponerlo bajo prueba

initial begin
a_tb = 0;
b_tb = 0;
cin_tb = 0;
#1 //cantiadad de unidades de tiempo que quiero que las variables esten en 0
a_tb = 1;
b_tb = 0;
cin_tb = 1;
#1
a_tb = 1;
b_tb = 1;
cin_tb = 0;
end

initial begin: TEST_CASE
    $dumpfile("Sum_sim.vcd");
    $dumpvars(-1,uut);
    #5; $finish;
end

endmodule