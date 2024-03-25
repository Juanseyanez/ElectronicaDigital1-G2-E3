`include "Sum.v"
module Sum4b(
    input [3:0] a, b, // Entradas de 4 bits
    input cin,  // Carry in
    output [3:0] S, // Suma de 4 bits
    output cout // Carry out
);

wire c1, c2, c3; // Carry outs intermedios

Sum Sum1(.a(a[0]), .b(b[0]), .cin(cin), .S(S[0]), .cout(c1)); // Instancia del sumador de 1 bit para el bit menos significativo
Sum Sum2(.a(a[1]), .b(b[1]), .cin(c1), .S(S[1]), .cout(c2)); // Instancia del sumador de 1 bit para el segundo bit
Sum Sum3(.a(a[2]), .b(b[2]), .cin(c2), .S(S[2]), .cout(c3)); // Instancia del sumador de 1 bit para el tercer bit
Sum Sum4(.a(a[3]), .b(b[3]), .cin(c3), .S(S[3]), .cout(cout)); // Instancia del sumador de 1 bit para el bit más significativo

endmodule