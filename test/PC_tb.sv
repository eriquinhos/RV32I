module PC_Module_tb;

    // Declaração dos sinais de entrada e saída
    logic clk;
    logic rst;
    logic [31:0] PC_Next;
    logic [31:0] PC;

    // Instanciando o módulo PC_Module
    PC_Module uut (
        .clk(clk),
        .rst(rst),
        .PC_Next(PC_Next),
        .PC(PC)
    );

    // Geração de clock
    always begin
        #5 clk = ~clk;  // Toggle do clock a cada 5 unidades de tempo
    end

    // Sequência de testes
    initial begin
        // Inicializa os sinais
        clk = 0;
        rst = 0;
        PC_Next = 32'hA5A5A5A5;  // Valor arbitrário para PC_Next

        // Teste 1: Reset do PC
        $display("Teste 1: Reset do PC");
        #10;  // Espera 10 unidades de tempo
        rst = 0; // Ativando reset
        #10;  // Espera 10 unidades de tempo
        $display("PC após reset: %h", PC); // Espera-se que o PC seja 0

        // Teste 2: Atualização do PC com PC_Next
        $display("Teste 2: Atualização do PC");
        rst = 1; // Desativa o reset
        #10;  // Espera 10 unidades de tempo
        PC_Next = 32'hDEADBEEF;  // Novo valor para PC_Next
        #10;  // Espera 10 unidades de tempo
        $display("PC após atualização: %h", PC); // Espera-se que o PC seja DEADBEEF

        // Teste 3: Novo valor para PC_Next
        $display("Teste 3: Novo valor para PC_Next");
        PC_Next = 32'h12345678;  // Novo valor para PC_Next
        #10;  // Espera 10 unidades de tempo
        $display("PC após atualização: %h", PC); // Espera-se que o PC seja 12345678

        // Teste 4: Reset novamente
        $display("Teste 4: Reset novamente");
        rst = 0; // Ativa o reset novamente
        #10;  // Espera 10 unidades de tempo
        $display("PC após reset: %h", PC); // Espera-se que o PC seja 0

        // Teste 5: Novo valor após reset
        $display("Teste 5: Novo valor após reset");
        rst = 1;  // Desativa o reset
        PC_Next = 32'h11111111;  // Novo valor para PC_Next
        #10;  // Espera 10 unidades de tempo
        $display("PC após atualização: %h", PC); // Espera-se que o PC seja 11111111

        // Finaliza a simulação
        $finish;
    end

endmodule
