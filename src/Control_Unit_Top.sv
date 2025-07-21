module Control_Unit_Top(
    input logic [6:0] Op, funct7,       // Entradas Op e funct7 de 7 bits
    input logic [2:0] funct3,            // Entrada funct3 de 3 bits
    output logic RegWrite,               // Saída RegWrite
    output logic ALUSrc,                 // Saída ALUSrc
    output logic MemWrite,               // Saída MemWrite
    output logic ResultSrc,              // Saída ResultSrc
    output logic Branch,                 // Saída Branch
    output logic [1:0] ImmSrc,           // Saída ImmSrc de 2 bits
    output logic [2:0] ALUControl        // Saída ALUControl de 3 bits
);

    logic [1:0] ALUOp;                  // Sinal intermediário ALUOp

    // Instancia o Main_Decoder
    Main_Decoder Main_Decoder_inst (
        .Op(Op),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .Branch(Branch),
        .ALUSrc(ALUSrc),
        .ALUOp(ALUOp)
    );

    // Instancia o ALU_Decoder
    ALU_Decoder ALU_Decoder_inst (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .op(Op),
        .ALUControl(ALUControl)
    );

endmodule
