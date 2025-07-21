module Main_Decoder (
    input  logic [6:0] Op,         // Código de operação (Op)
    output logic RegWrite,         // Habilitação para escrever no registrador
    output logic ALUSrc,           // Sinal para indicar se o segundo operando é imediato
    output logic MemWrite,         // Habilitação para escrever na memória
    output logic ResultSrc,        // Sinal para selecionar o resultado da memória ou ALU
    output logic Branch,           // Sinal de ramificação (branch)
    output logic [1:0] ImmSrc,     // Fonte do imediato
    output logic [1:0] ALUOp       // Operação para a ALU
);

    // Decodificação do sinal RegWrite (controle de escrita no registrador)
    assign RegWrite = (Op == 7'b0000011 | Op == 7'b0110011) ? 1'b1 : 1'b0;

    // Definição da origem do imediato
    assign ImmSrc = (Op == 7'b0100011) ? 2'b01 :    // Store (armazenamento na memória)
                    (Op == 7'b1100011) ? 2'b10 :    // Branch (ramificação)
                                          2'b00;     // Outras operações

    // Determinação se o segundo operando da ALU vem de imediato
    assign ALUSrc = (Op == 7'b0000011 | Op == 7'b0100011) ? 1'b1 : 1'b0;

    // Habilitação de escrita na memória (somente para operações de store)
    assign MemWrite = (Op == 7'b0100011) ? 1'b1 : 1'b0;

    // Definição da origem do resultado (memória ou ALU)
    assign ResultSrc = (Op == 7'b0000011) ? 1'b1 : 1'b0; 

    // Determinação do sinal de ramificação (branch)
    assign Branch = (Op == 7'b1100011) ? 1'b1 : 1'b0;

    // Definição da operação da ALU
    assign ALUOp = (Op == 7'b0110011) ? 2'b10 :  // R-type (ALU operando diretamente com os registradores)
                   (Op == 7'b1100011) ? 2'b01 :  // Branch
                                        2'b00;    // I-type ou outros tipos de instruções
endmodule
