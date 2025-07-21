module Mux (
    input  logic [31:0] a, b,  // Entradas de 32 bits
    input  logic s,            // Seletor
    output logic [31:0] c      // Saída de 32 bits
);

    assign c = (~s) ? a : b;

endmodule