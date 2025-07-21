module PC_Module (
    input logic clk,               // Clock de entrada
    input logic rst,               // Sinal de reset
    input logic [31:0] PC_Next,    // Próximo valor do PC
    output logic [31:0] PC         // Valor atual do PC
);

    // Bloco de processo sensível à borda de subida do clock (posedge clk)
    always_ff @(posedge clk) begin
        if (!rst)                   // Se o reset estiver ativo (reset = 0)
            PC <= 32'b0;            // Coloca o PC como 0
        else
            PC <= PC_Next;          // Caso contrário, atualiza o PC com o valor de PC_Next
    end

endmodule