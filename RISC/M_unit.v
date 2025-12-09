`define MUL   3'b000
`define MULH   3'b001
`define MULHSU 3'b010
`define MULHU 3'b011
`define DIV   3'b100
`define DIVU  3'b101
`define REM   3'b110
`define REMU   3'b111
module M_unit(
input [2:0] funct3,
output reg [2:0] M_OP);

always@(*)
begin
    case(funct3)
        3'd0:M_OP = `MUL;
        3'd1:M_OP = `MULH;
        3'd2:M_OP = `MULHSU;
        3'd3:M_OP = `MULHU;
        3'd4:M_OP = `DIV;
        3'd5:M_OP = `DIVU;
        3'd6:M_OP = `REM;
        3'd7:M_OP = `REMU;
    endcase
end
endmodule
        
        
