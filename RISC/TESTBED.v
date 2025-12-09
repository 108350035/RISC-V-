`include "RISC_tb.v"
`include "test_rom.v"
`include "test_sram.v"
`ifdef RTL
`include "RISC.v"
`elsif GATE
`include "RISC_SYN.v"
`elsif POST
`include "CHIP.v"
`endif

module TESTBED();

wire clk,rst_n;
wire [31:0] inst,pc,data,addr;
wire [3:0] load_req,store_req;
wire [31:0] store_data,load_data;
`ifdef RTL
RISC U_RISC(
	.clk(clk),
    .rst_n(rst_n),
	.inst(inst),
	.store_data(store_data),
	.load_data(load_data),
	.pc(pc),
	.load_req(load_req),
	.store_req(store_req),
	.addr(addr)
);

`elsif GATE
RISC U_RISC(
	.clk(clk),
    .rst_n(rst_n),
	.inst(inst),
	.store_data(store_data),
	.load_data(load_data),
	.pc(pc),
	.load_req(load_req),
	.store_req(store_req),
	.addr(addr)
);
`elsif POST
CHIP U_CHIP(
	.clk(clk),
    .rst_n(rst_n),
	.inst(inst),
	.store_data(store_data),
	.load_data(load_data),
	.pc(pc),
	.load_req(load_req),
	.store_req(store_req),
	.addr(addr)
);
`endif

PATTERN U_PATTERN(
	.clk(clk),
    .rst_n(rst_n),
	.pc(pc)
	/*.inst(inst),
	.data(data),
	.load_req(load_req),
	.store_req(store_req),
	.addr(addr)*/
);

test_rom U0(.CLK(clk) ,.CEN(1'b0) ,.A(pc[13:2]) ,.Q(inst));
test_sram U1 (.QA(load_data) ,.CLKA(clk) ,.CENA((|store_req == 0) && (|load_req == 0)) ,.WENA(~store_req) ,.AA(addr[7:0]) ,.DA(store_data),
   .OENA(1'b0),
   .QB(),
   .CLKB(1'b0),
   .CENB(1'b1),
   .WENB(4'b0),
   .AB(8'b0),
   .DB(32'b0),
   .OENB(1'b0)
);



initial begin
	`ifdef RTL
		$fsdbDumpfile("RISC.fsdb");
		$fsdbDumpvars(0,"+mda");
		$fsdbDumpvars();
	`elsif GATE
		$sdf_annotate("RISC_SYN.sdf",U_RISC);
		$fsdbDumpfile("RISC_SYN.fsdb");
		$fsdbDumpvars();
	`elsif POST
		$sdf_annotate("CHIP.sdf",U_CHIP);
		$fsdbDumpfile("CHIP.fsdb");
		$fsdbDumpvars();

	`endif
end

endmodule
