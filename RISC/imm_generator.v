module imm_generator(
input [31:0] inst,
input [2:0] imm_sel,
output reg [31:0] imm);

wire [31:0] ext0 = {{20{inst[31]}},inst[31:20]}; //I
wire [31:0] ext1 = {{20{inst[31]}},inst[7],inst[30:25],inst[11:8],1'b0}; //SB
wire [31:0] ext2 = {inst[31:12],12'h000}; //LUI AUIPC
wire [31:0] ext3 = {{12{inst[31]}},inst[19:12],inst[20],inst[30:21],1'b0}; //UJ
wire [31:0] ext4 = {{20{inst[31]}},inst[31:25],inst[11:7]}; //S

always@(*)
begin
    case(imm_sel)
        3'd0:imm = ext0;
        3'd2:imm = ext2;
        3'd3:imm = ext3;
        3'd4:imm = ext4;
        default:imm = ext1; 
    endcase
end

endmodule
