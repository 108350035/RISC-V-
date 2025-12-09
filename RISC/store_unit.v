module store_unit(
input [2:0] funct3,
input S_type,
input [1:0] size,
output [3:0] store);

reg [3:0] store_sel;

always@(*)
begin
    case(size)
	2'd3:store_sel = 4'b1111;
	2'd2:store_sel = 4'b0011;
	2'd1:store_sel = 4'b0001;
	default:store_sel = 0;
    endcase
end

assign store = (S_type)?store_sel:0;

endmodule
