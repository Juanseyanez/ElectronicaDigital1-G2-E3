module Sum(
    input a, b, // Entradas
    input cin,  // Carry in
    output S, // Suma
    output cout // Carry out
);

assign S = a ^ b ^ cin; //Se tienen 2 compuertas Xor entre las entradas a y b y entre el Carry in

assign cout = (a & b) | (b & cin) | (a & cin);

endmodule
