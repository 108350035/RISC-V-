module PC(
input clk,rst_n,enable,
input j,branch,
input [31:0] target,
output reg [31:0] pc_out);

reg [31:0] pc_cal;
always@(*) 
begin 
    if(j | branch) begin
        pc_cal = target;
    end
    else pc_cal = pc_out + 4;
end

always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) pc_out<=0;
    else if(enable) pc_out<=pc_out;
    else pc_out<=pc_cal;
end


endmodule
