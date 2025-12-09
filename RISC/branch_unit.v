module branch_unit(
input [31:0] OP1,OP2,
input SB_type,UJ_type,
input [2:0] funct3,
output branch_op,j_op);

reg branch;
wire signed [31:0] S_RS1 = OP1;
wire signed [31:0] S_RS2 = OP2;

wire beq_op 	= (S_RS1 == S_RS2);
wire bne_op 	= (S_RS1 != S_RS2);
wire blt_op 	= (S_RS1 < S_RS2);
wire bltu_op	= (OP1 < OP2);
wire bge_op 	= (S_RS1 >= S_RS2);
wire bgeu_op	= (OP1 >= OP2);

assign branch_op = (SB_type)?branch:0;
assign j_op = UJ_type;
always@(*)
begin
    case(funct3)
        3'b0:branch = beq_op;
        3'b1:branch = bne_op;
        3'd2:branch = blt_op;
        3'd3:branch = bge_op;
        3'd4:branch = bltu_op;
        3'd5:branch = bgeu_op;
        default:branch = 0;
    endcase
end

endmodule


        
        
