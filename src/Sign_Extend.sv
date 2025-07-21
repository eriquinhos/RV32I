module Sign_Extend (
    input  logic [31:0] In,      // Entrada de 32 bits
    input  logic ImmSrc,          // Seleção do tipo de imediato
    output logic [31:0] Imm_Ext   // Resultado da extensão do imediato
);

    assign Imm_Ext = (ImmSrc == 1'b1) ? 
                    {{20{In[31]}}, In[31:25], In[11:7]} :
                    {{20{In[31]}}, In[31:20]};
endmodule
