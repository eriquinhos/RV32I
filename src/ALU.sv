module ALU(
    input logic [31:0] A, B,
    input logic [2:0] ALUControl,
    output logic Carry, OverFlow, Zero, Negative,
    output logic [31:0] Result
);

    logic Cout;
    logic [31:0] Sum;

    // Somando A e B (caso ALUControl[0] seja 0, soma, caso contrário, subtração)
    assign {Cout, Sum} = (ALUControl[0] == 1'b0) ? A + B : (A + (~B + 1));

    // Atribuição para Result, dependendo do valor de ALUControl
    always_comb begin
        case(ALUControl)
            3'b000, 3'b001: Result = Sum;           // Soma ou subtração
            3'b010: Result = A & B;                 // AND
            3'b011: Result = A | B;                 // OR
            3'b101: Result = {31'b0, Sum[31]};      // Sinal de overflow (bit mais significativo)
            default: Result = 32'b0;                // Caso padrão (não utilizado)
        endcase
    end

    // Overflow logic
    assign OverFlow = ((Sum[31] ^ A[31]) & 
                    (~(ALUControl[0] ^ B[31] ^ A[31])) & 
                    (~ALUControl[1]));

    // Carry logic
    assign Carry = (~ALUControl[1]) & Cout;

    // Zero logic
    assign Zero = &(~Result);  // Zero é 1 se todos os bits de Result forem 0

    // Negative logic
    assign Negative = Result[31];  // O bit mais significativo indica negativo

endmodule
