module control_unit(
input [6:0] opcode,
input [2:0] funct3,
input [6:0] funct7,
output reg_write,
output SB_type,UJ_type,R_type,I_type,S_type,load_type,LUI,AUIPC,M_type,
output reg [1:0] size_reg,
output reg [2:0] imm_sel);

reg [1:0] imm_reg;
assign R_type = (opcode == 7'b0110011);
assign I_type = (opcode == 7'b0010011);
assign SB_type = (opcode == 7'b1100011);
assign UJ_type = (opcode == 7'b1101111 || opcode == 7'b1100111);
assign S_type = (opcode == 7'b0100011);
assign load_type = (opcode == 7'b0000011);
assign M_type = (funct7 == 7'b0000001);
assign LUI = (opcode == 7'b0110111);
assign AUIPC = (opcode == 7'b0010111);
assign reg_write = R_type | I_type | load_type | AUIPC | LUI | UJ_type;

always@(*)
begin
    case(funct3)
        3'b000,3'b100:size_reg = 2'd1;
        3'b001,3'b101:size_reg = 2'd2;
        3'b010:size_reg = 2'd3;
        default:size_reg = 2'd0;
    endcase
end

always@(*)
begin
    if(I_type | load_type) imm_sel = 3'd0;
    else if(SB_type) imm_sel = 3'd1;
    else if(S_type) imm_sel = 3'd4;
    else if(UJ_type) imm_sel = 3'd3;
    else imm_sel = 3'd2;
end

endmodule

