module ALU_tb;

    // Declaração dos sinais de entrada e saída
    logic [31:0] A, B;
    logic [2:0] ALUControl;
    logic Carry, OverFlow, Zero, Negative;
    logic [31:0] Result;

    // Instancia a ULA
    ALU uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Carry(Carry),
        .OverFlow(OverFlow),
        .Zero(Zero),
        .Negative(Negative),
        .Result(Result)
    );

    // Sequência de testes
    initial begin
        // Teste 1: Soma simples
        A = 32'h00000001;
        B = 32'h00000001;
        ALUControl = 3'b000; // Soma
        #10; // Delay de 10 unidades de tempo
        $display("Soma: A = %h, B = %h, Result = %h, Carry = %b, Zero = %b, Negative = %b, OverFlow = %b", 
                 A, B, Result, Carry, Zero, Negative, OverFlow);

        // Teste 2: Subtração simples (A - B)
        ALUControl = 3'b001; // Subtração
        #10;
        $display("Subtração: A = %h, B = %h, Result = %h, Carry = %b, Zero = %b, Negative = %b, OverFlow = %b", 
                 A, B, Result, Carry, Zero, Negative, OverFlow);

        // Teste 3: AND lógico
        ALUControl = 3'b010; // AND
        #10;
        $display("AND: A = %h, B = %h, Result = %h, Carry = %b, Zero = %b, Negative = %b, OverFlow = %b", 
                 A, B, Result, Carry, Zero, Negative, OverFlow);

        // Teste 4: OR lógico
        ALUControl = 3'b011; // OR
        #10;
        $display("OR: A = %h, B = %h, Result = %h, Carry = %b, Zero = %b, Negative = %b, OverFlow = %b", 
                 A, B, Result, Carry, Zero, Negative, OverFlow);

        // Teste 5: Sinal de overflow
        A = 32'h7FFFFFFF; // Valor máximo positivo
        B = 32'h00000001; // Adição que causa overflow
        ALUControl = 3'b000; // Soma
        #10;
        $display("Overflow: A = %h, B = %h, Result = %h, Carry = %b, Zero = %b, Negative = %b, OverFlow = %b", 
                 A, B, Result, Carry, Zero, Negative, OverFlow);

        // Teste 6: Resultado Zero
        A = 32'h00000000; 
        B = 32'h00000000;
        ALUControl = 3'b000; // Soma
        #10;
        $display("Zero: A = %h, B = %h, Result = %h, Carry = %b, Zero = %b, Negative = %b, OverFlow = %b", 
                 A, B, Result, Carry, Zero, Negative, OverFlow);

        // Teste 7: Número negativo
        A = 32'hFFFFFFFF; // -1 em complemento de 2
        B = 32'h00000001; // Soma com 1
        ALUControl = 3'b000; // Soma
        #10;
        $display("Negative: A = %h, B = %h, Result = %h, Carry = %b, Zero = %b, Negative = %b, OverFlow = %b", 
                 A, B, Result, Carry, Zero, Negative, OverFlow);

        // Teste 8: Testando o bit de Carry
        A = 32'hFFFFFFFF; // Valor que irá gerar Carry
        B = 32'h00000001;
        ALUControl = 3'b000; // Soma
        #10;
        $display("Carry: A = %h, B = %h, Result = %h, Carry = %b, Zero = %b, Negative = %b, OverFlow = %b", 
                 A, B, Result, Carry, Zero, Negative, OverFlow);
    end

endmodule
