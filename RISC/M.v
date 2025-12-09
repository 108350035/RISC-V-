`define MUL   3'b000
`define MULH   3'b001
`define MULHSU 3'b010
`define MULHU 3'b011
`define DIV   3'b100
`define DIVU  3'b101
`define REM   3'b110
`define REMU   3'b111
module M(
input clk,rst_n,en,
input  [2:0]  OPCODE,
input  [31:0]  ALU_A,
input  [31:0]  ALU_B,
output reg [31:0] ALU_C,
output div_0
);
reg OP_A;
reg [31:0] ALU_R;
wire [63:0] u_mul,s_mul;
wire [31:0] u_q,s_q,u_r,s_r;
wire s_div_0,u_div_0;
assign div_0 = s_div_0 | u_div_0;

DW02_mult_2_stage #(32,32) M0 (.A(ALU_A) ,.B(ALU_B) ,.TC(1'b1), .CLK(clk) ,.PRODUCT(s_mul));
DW02_mult_2_stage #(32,32) M1 (.A(ALU_A) ,.B(ALU_B) ,.TC(1'b0), .CLK(clk) ,.PRODUCT(u_mul));
DW_div_pipe #(32,32,1,1,2,0,1,0) D0 (.clk(clk) ,.rst_n(rst_n) ,.en(1'b1) ,.a(ALU_A) ,.b(ALU_B) ,.quotient(s_q) ,.remainder(s_r) ,.divide_by_0(s_div_0));
DW_div_pipe #(32,32,0,1,2,0,1,0) D1 (.clk(clk) ,.rst_n(rst_n) ,.en(1'b1) ,.a(ALU_A) ,.b(ALU_B) ,.quotient(u_q) ,.remainder(u_r) ,.divide_by_0(u_div_0));

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) OP_A<=0;
    else OP_A<=(en)?ALU_A[31]:OP_A;
end

always@(*)
begin
    case(OPCODE)
        `MUL:ALU_R = s_mul[31:0];
        `MULH:ALU_R = s_mul[63:32];
        `MULHSU:ALU_R = (OP_A)?~u_mul[63:32] + 1:u_mul[63:32];
        `MULHU:ALU_R = u_mul[63:32];
        `DIV:ALU_R = s_q;
        `DIVU:ALU_R = u_q;
        `REM:ALU_R = s_q;
        `REMU:ALU_R = u_r;
        default: ALU_R = `NONE;
    endcase
end

always@(*)
begin
    ALU_C=ALU_R;
end
endmodule

