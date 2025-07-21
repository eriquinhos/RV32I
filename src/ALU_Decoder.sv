module ALU_Decoder (
    input  logic [1:0] ALUOp,         // Sinal de controle ALUOp (2 bits)
    input  logic [2:0] funct3,        // Funct3 da instrução (3 bits)
    input  logic [6:0] funct7,        // Funct7 da instrução (7 bits)
    input  logic [6:0] op,            // Op da instrução (7 bits)
    output logic [2:0] ALUControl     // Sinal de controle da ALU (3 bits)
);

    // Atribuição para o sinal de controle ALU (ALUControl)
    assign ALUControl = 
        (ALUOp == 2'b00) ? 3'b000 :          // Se ALUOp for 00, a operação será do tipo LUI (Load Upper Immediate) ou similar
        (ALUOp == 2'b01) ? 3'b001 :          // Se ALUOp for 01, a operação será do tipo BEQ (Branch Equal)
        // Verificação para a operação tipo SUB (subtração)
        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5], funct7[5]} == 2'b11)) ? 3'b001 : 
        // Verificação para a operação tipo ADD (adição)
        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5], funct7[5]} != 2'b11)) ? 3'b000 : 
        // Caso seja uma operação do tipo SLT (Set Less Than)
        ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 :                              
        // Caso seja uma operação do tipo OR
        ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 :                              
        // Caso seja uma operação do tipo AND
        ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 :                              
        3'b000;  // Valor padrão para ALUControl (caso não se enquadre nas condições acima)

endmodule
