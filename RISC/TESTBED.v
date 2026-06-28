`include "RISC_tb.v"
`include "ts1n28hpcpuhdhvtb256x32m4swbso_170a_ssg0p81v0c.v"
`include "ts3n28hpcpa4096x32m8mbs_130a_ssg0p81v0c.v"
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

TS3N28HPCPA4096X32M8MBS U0(.A(pc[13:2]) ,.AM(pc[13:2]) ,.CEB(1'b0) ,.BIST(1'b0) ,.CEBM(1'b1) ,.CLK(clk) ,.SLP(1'b0) ,.RTSEL(2'b1) ,.PTSEL(2'b1) ,.Q(inst) ,.TRB(2'b1));
TS1N28HPCPUHDHVTB256X32M4SWBSO U1 (.SLP(1'b0) ,.SD(1'b0) ,.CLK(~clk) ,.CEB((|store_req == 0) && (|load_req == 0)) ,.CEBM((|store_req == 0) && (|load_req == 0)) 
                    ,.WEB(~store_req) ,.WEBM(1'b1)
					,.Q(load_data) ,.A(addr[7:0]) ,.D(store_data) ,.RTSEL(2'b0) ,.WTSEL(2'b0) ,.BIST(1'b0)  ,.BWEB({{8{~store_req[3]}},{8{~store_req[2]}},
							{8{~store_req[1]}},{8{~store_req[0]}}}) ,.BWEBM('b0) ,.AM('b0) ,.DM('b0) );
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