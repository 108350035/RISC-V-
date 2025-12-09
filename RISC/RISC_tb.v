`define CYCLE_TIME 40
`timescale 1ns/1ps

module PATTERN(
// output signals
    clk,
    rst_n,
    //inst,
// input signals
    pc
    //store_req,
    //load_req,
    //addr,
// inout signals
    //data
);

output reg clk, rst_n;
//output reg  [31:0] inst;
input [31:0] pc;
//input [3:0] store_req,load_req,addr;
//inout [31:0] data;

//assign data = (|load_req) ? data_send : 32'bz;
integer patcount;
//==============CLK==============
initial clk = 0;
always #(`CYCLE_TIME/2) clk=~clk;
//===============================

initial begin
    rst_n = 1'b1;
    force clk = 0;
    reset_task;
    for(patcount = 0;patcount < 4096;patcount = patcount + 1) begin
        @(negedge clk);
    end
    @(negedge clk);
    $finish;
end

task reset_task;
begin
    #10; rst_n = 1'b0;
    #10;if(pc != 'b0) begin
        $display ("------------------------------------------------------------------------------------------------------------------------");
		$display ("                          All output signals should be reset after the reset signal is asserted.                        ");
		$display ("------------------------------------------------------------------------------------------------------------------------");
    repeat(2) @(negedge clk);
    $finish;
    end
    #10; rst_n = 1'b1;
    #(3.0) release clk;
end
endtask

endmodule
