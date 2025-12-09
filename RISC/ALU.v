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
module ALU (
      input  [ 3:0]  OPCODE,
      input  [31:0]  ALU_A,
      input  [31:0]  ALU_B,
      output reg signed [31:0] ALU_C
);
wire signed [31:0] ALU_A_signed = ALU_A;
wire signed [31:0] ALU_B_signed = ALU_B;
wire [4:0] shamt = ALU_B[4:0];
reg signed [31:0] ALU_R;

always@(*)
begin
    case(OPCODE)
        `ADD:ALU_R = ALU_A_signed + ALU_B_signed;
        `SUB:ALU_R = ALU_A_signed - ALU_B_signed;
        `AND:ALU_R = ALU_A & ALU_B;
        `OR:ALU_R = ALU_A | ALU_B;
        `XOR:ALU_R = ALU_A ^ ALU_B;
        `SLL:ALU_R = ALU_A << shamt;
        `SRL:ALU_R = ALU_A >> shamt;
        `SRA:ALU_R = ALU_A >>> shamt;   
        `SLT:  ALU_R = (ALU_A_signed < ALU_B_signed) ? 32'd1 : 32'd0;
        `SLTU: ALU_R = (ALU_A < ALU_B) ? 32'd1 : 32'd0;
        default: ALU_R = `NONE;
    endcase
end

always@(*)
begin
    ALU_C=ALU_R;
end
endmodule

