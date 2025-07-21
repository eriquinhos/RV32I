module DataMemory (
    input  logic        clk,
    input  logic        memRead,
    input  logic        memWrite,
    input  logic [31:0] address,
    input  logic [31:0] writeData,
    input  logic [31:0] input_port,        // Porta de entrada para I/O (switches, botões)
    output logic [31:0] output_port,       // Porta de saída para I/O (LEDs, display)
    output logic [31:0] readData   
);

    // Endereços mapeados de I/O (Memory-Mapped I/O)
    localparam IN_ADDR     = 32'hFFFF0000;    // Endereço para leitura de entrada
    localparam OUT_ADDR    = 32'hFFFF0004;    // Endereço para escrita de saída
    localparam STATUS_ADDR = 32'hFFFF0008;    // Endereço adicional para status (opcional)
    
    // Sinais para conexão com o IP core RAM
    logic [7:0]  ram_address;
    logic [31:0] ram_data_in;
    logic [31:0] ram_data_out;
    logic        ram_wren;
    
    // Decodificação de endereços
    logic is_io_address, is_ram_access;
    assign is_io_address = (address >= 32'hFFFF0000);  // Endereços I/O
    assign is_ram_access = !is_io_address;             // Endereços RAM
    
    // Preparação dos sinais para o IP core da RAM
    assign ram_address = address[9:2];  // Word-aligned address (bits [9:2] para 256 palavras)
    assign ram_data_in = writeData;
    assign ram_wren    = memWrite && is_ram_access;
    
    // Instanciação do IP core RAM gerado pelo Quartus
    Data_Memory ram_ip (
        .address(ram_address),
        .clock(clk),
        .data(ram_data_in),
        .wren(ram_wren),
        .q(ram_data_out)
    );
    
    // Registrador de saída MMIO - mantém valor escrito no endereço de saída
    always_ff @(posedge clk) begin
        if (memWrite && address == OUT_ADDR) begin
            output_port <= writeData;
        end
    end
    
    // Lógica de leitura com multiplexação entre RAM e I/O
    always_comb begin
        if (memRead) begin
            case (address)
                IN_ADDR:     readData = input_port;           // Lê entrada (switches/botões)
                STATUS_ADDR: readData = {31'b0, 1'b1};       // Status fictício (sempre pronto)
                default: begin
                    if (is_ram_access)
                        readData = ram_data_out;              // Lê da RAM
                    else
                        readData = 32'b0;                     // Endereços I/O não mapeados retornam 0
                end
            endcase
        end else begin
            readData = 32'b0;
        end
    end

endmodule
