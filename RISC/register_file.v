module register_file(
input [4:0] RS1_addr,RS2_addr,write_addr,
input clk,rst_n,w_en,
input [31:0] write_data,
output reg [31:0] RS1_data,RS2_data);


reg [31:0] regfile [31:0];
integer i;

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        for(i=0;i<32;i=i+1) begin
            regfile[i]<=0;
        end
    end
    else if(w_en) regfile[write_addr]<=(write_addr == 0)?0:write_data;
end

always@(*)
begin
    RS1_data=regfile[RS1_addr];
    RS2_data=regfile[RS2_addr];
end

endmodule



