module PC_Adder (
    input  logic [31:0] a, b,   // Entradas de 32 bits
    output logic [31:0] c       // Saída de 32 bits
);

    assign c = a + b;  // Soma das entradas a e b
endmodule
