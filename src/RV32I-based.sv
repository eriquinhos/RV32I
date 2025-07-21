module Single_Cycle_Top(clk,rst);

    input clk,rst;

    wire [31:0] PC_Top,RD_Instr,RD1_Top,Imm_Ext_Top,ALUResult,ReadData,PCPlus4,RD2_Top,SrcB,Result;
    wire RegWrite,MemWrite,ALUSrc,ResultSrc;
    wire [1:0]ImmSrc;
    wire [2:0]ALUControl_Top;

    PC_Module PC(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_Next(PCPlus4)
    );

    PC_Adder PC_Adder(
                    .a(PC_Top),
                    .b(32'd4),
                    .c(PCPlus4)
    );
    
    Instruction_Memory Instruction_Memory (
    .address (PC_Top[11:2]),
    .clock   (clk),
    .q       (RD_Instr)
);

    Register_File Register_File (
    .address_a (rd_addr),   // endereço de escrita (rd)
    .address_b (rs2_addr),  // endereço de leitura 2 (rs2)
    .data_a    (wr_data),   // dado para escrita
    .data_b    (32'b0),     // não usado
    .wren_a    (reg_we),    // enable de escrita
    .wren_b    (1'b0),      // disable escrita em B
    .rden_a    (1'b1),      // leituras sempre ativadas
    .rden_b    (1'b1),
    .q_a       (rs1_data),  // saída de leitura 1 (rs1)
    .q_b       (rs2_data),  // saída de leitura 2 (rs2)
    .clock     (clk)
);


    Sign_Extend Sign_Extend(
                        .In(RD_Instr),
                        .ImmSrc(ImmSrc[0]),
                        .Imm_Ext(Imm_Ext_Top)
    );

    Mux Mux_Register_to_ALU(
                            .a(RD2_Top),
                            .b(Imm_Ext_Top),
                            .s(ALUSrc),
                            .c(SrcB)
    );

    ALU ALU(
            .A(RD1_Top),
            .B(SrcB),
            .Result(ALUResult),
            .ALUControl(ALUControl_Top),
            .OverFlow(),
            .Carry(),
            .Zero(),
            .Negative()
    );

    Control_Unit_Top Control_Unit_Top(
                            .Op(RD_Instr[6:0]),
                            .RegWrite(RegWrite),
                            .ImmSrc(ImmSrc),
                            .ALUSrc(ALUSrc),
                            .MemWrite(MemWrite),
                            .ResultSrc(ResultSrc),
                            .Branch(),
                            .funct3(RD_Instr[14:12]),
                            .funct7(RD_Instr[6:0]),
                            .ALUControl(ALUControl_Top)
    );
    DataMemory Data_Memory (
    .clk        (clk),
    .memRead    (MemRead),
    .memWrite   (MemWrite),
    .address    (ALUResult),
    .writeData  (RD2_Top),      // normalmente rs2_data ou RD2_Top
    .input_port (input_port),   // sinais de entrada física (botões, switches)
    .output_port(output_port),  // sinais de saída física (LEDs etc.)
    .readData   (ReadData)
);


    Mux Mux_DataMemory_to_Register(
                            .a(ALUResult),
                            .b(ReadData),
                            .s(ResultSrc),
                            .c(Result)
    );

endmodule