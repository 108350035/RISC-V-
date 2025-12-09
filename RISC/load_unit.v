module load_unit(
input load_type,
input [2:0] funct3,
input [1:0] size,
output [3:0] read);

reg [3:0] read_sel;

always@(*)
begin
    case(size)
	2'd3:read_sel = 4'b1111;
	2'd2:read_sel = 4'b0011;
	2'd1:read_sel = 4'b0001;
	default:read_sel = 0;
    endcase
end

assign read = (load_type)?read_sel:0;
endmodule
