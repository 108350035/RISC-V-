module target_addr(
input [31:0] pc,imm,rs1_data,
input UJ_type,j,
output [31:0] target);

wire [31:0] pc_imm = pc + imm;
wire [31:0] rs1_imm = rs1_data + imm;
wire [31:0] rs1_imm2 = {rs1_imm[31:1],1'b0};

assign target = (UJ_type)?((j)?pc_imm:rs1_imm2):pc_imm;

endmodule
