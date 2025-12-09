`define NONE  4'b0000
`define ADD   4'b0001
`define SUB   4'b0010
`define AND   4'b0011
`define OR    4'b0100
`define XOR   4'b0101
`define SLL   4'b0110
`define SRA   4'b0111
`define SRL   4'b1000
`define SLT   4'b1001
`define SLTU  4'b1010
module ALU_unit(
input [2:0] funct3,
input funct7,R_type,I_type,
output [3:0] ALU_OP);

reg [3:0] R_ALU,I_ALU;

always@(*)
begin
    case(funct3)
        4'b000:R_ALU = (funct7)?`SUB:`ADD;
        4'b001:R_ALU = (funct7)?`NONE:`SLL;
        4'b010:R_ALU = (funct7)?`NONE:`SLT;
        4'b011:R_ALU = (funct7)?`NONE:`SLTU;
        4'b100:R_ALU = (funct7)?`NONE:`XOR;
        4'b101:R_ALU = (funct7)?`SRA:`SRL;
        4'b110:R_ALU = (funct7)?`NONE:`OR;
        4'b111:R_ALU = (funct7)?`NONE:`AND;
    endcase
end

always@(*)
begin
    case(funct3)
        3'b000:I_ALU = `ADD;
        3'b001:I_ALU = `SLL;
        3'b010:I_ALU = `SLT;
        3'b011:I_ALU = `SLTU;
        3'b100:I_ALU = `XOR;
        3'b101:I_ALU = (funct7)?`SRA:`SRL;
        3'b110:I_ALU = `OR;
        3'b111:I_ALU = `AND;
    endcase
end

assign ALU_OP = (R_type)?R_ALU:((I_type)?I_ALU:`ADD);

endmodule
