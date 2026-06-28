module CHIP( 	
// input signals
    clk,
    rst_n,
    inst,
    load_data,
// output signals
    pc,
    store_req,
    load_req,
    addr,
    store_data
);

input clk,rst_n;
input [31:0] inst,load_data;
output [31:0] store_data;
output [31:0] pc,addr;
output [3:0] load_req,store_req;

wire   C_clk,C_rst_n;
wire  [31:0] C_inst,C_load_data,C_store_data,C_pc,C_addr;
wire  [3:0] C_load_req,C_store_req;

wire BUF_clk;
DCCKBD12BWP7T40P140 buf0(.I(C_clk),.Z(BUF_clk));

RISC U_RISC(
	.clk(BUF_clk),
    .rst_n(C_rst_n),
	.inst(C_inst),
	.store_data(C_store_data),
	.load_data(C_load_data),
	.pc(C_pc),
	.load_req(C_load_req),
	.store_req(C_store_req),
	.addr(C_addr)
);

// Input Pads
PDDW08SDGZ_H_G I_CLK(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(clk), .C(C_clk));
PDDW08SDGZ_H_G I_RESET(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(rst_n), .C(C_rst_n));
PDDW08DGZ_H_G I_INST0(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[0]), .C(C_inst[0]));
PDDW08DGZ_H_G I_INST1(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[1]), .C(C_inst[1]));
PDDW08DGZ_H_G I_INST2(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[2]), .C(C_inst[2]));
PDDW08DGZ_H_G I_INST3(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[3]), .C(C_inst[3]));
PDDW08DGZ_H_G I_INST4(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[4]), .C(C_inst[4]));
PDDW08DGZ_H_G I_INST5(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[5]), .C(C_inst[5]));
PDDW08DGZ_H_G I_INST6(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[6]), .C(C_inst[6]));
PDDW08DGZ_H_G I_INST7(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[7]), .C(C_inst[7]));
PDDW08DGZ_H_G I_INST8(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[8]), .C(C_inst[8]));
PDDW08DGZ_H_G I_INST9(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[9]), .C(C_inst[9]));
PDDW08DGZ_H_G I_INST10(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[10]), .C(C_inst[10]));
PDDW08DGZ_H_G I_INST11(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[11]), .C(C_inst[11]));
PDDW08DGZ_H_G I_INST12(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[12]), .C(C_inst[12]));
PDDW08DGZ_H_G I_INST13(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[13]), .C(C_inst[13]));
PDDW08DGZ_H_G I_INST14(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[14]), .C(C_inst[14]));
PDDW08DGZ_H_G I_INST15(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[15]), .C(C_inst[15]));
PDDW08DGZ_H_G I_INST16(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[16]), .C(C_inst[16]));
PDDW08DGZ_H_G I_INST17(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[17]), .C(C_inst[17]));
PDDW08DGZ_H_G I_INST18(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[18]), .C(C_inst[18]));
PDDW08DGZ_H_G I_INST19(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[19]), .C(C_inst[19]));
PDDW08DGZ_H_G I_INST20(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[20]), .C(C_inst[20]));
PDDW08DGZ_H_G I_INST21(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[21]), .C(C_inst[21]));
PDDW08DGZ_H_G I_INST22(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[22]), .C(C_inst[22]));
PDDW08DGZ_H_G I_INST23(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[23]), .C(C_inst[23]));
PDDW08DGZ_H_G I_INST24(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[24]), .C(C_inst[24]));
PDDW08DGZ_H_G I_INST25(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[25]), .C(C_inst[25]));
PDDW08DGZ_H_G I_INST26(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[26]), .C(C_inst[26]));
PDDW08DGZ_H_G I_INST27(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[27]), .C(C_inst[27]));
PDDW08DGZ_H_G I_INST28(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[28]), .C(C_inst[28]));
PDDW08DGZ_H_G I_INST29(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[29]), .C(C_inst[29]));
PDDW08DGZ_H_G I_INST30(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[30]), .C(C_inst[30]));
PDDW08DGZ_H_G I_INST31(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(inst[31]), .C(C_inst[31]));
PDDW08DGZ_H_G I_LODATA0(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[0]), .C(C_load_data[0]));
PDDW08DGZ_H_G I_LODATA1(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[1]), .C(C_load_data[1]));
PDDW08DGZ_H_G I_LODATA2(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[2]), .C(C_load_data[2]));
PDDW08DGZ_H_G I_LODATA3(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[3]), .C(C_load_data[3]));
PDDW08DGZ_H_G I_LODATA4(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[4]), .C(C_load_data[4]));
PDDW08DGZ_H_G I_LODATA5(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[5]), .C(C_load_data[5]));
PDDW08DGZ_H_G I_LODATA6(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[6]), .C(C_load_data[6]));
PDDW08DGZ_H_G I_LODATA7(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[7]), .C(C_load_data[7]));
PDDW08DGZ_H_G I_LODATA8(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[8]), .C(C_load_data[8]));
PDDW08DGZ_H_G I_LODATA9(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[9]), .C(C_load_data[9]));
PDDW08DGZ_H_G I_LODATA10(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[10]), .C(C_load_data[10]));
PDDW08DGZ_H_G I_LODATA11(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[11]), .C(C_load_data[11]));
PDDW08DGZ_H_G I_LODATA12(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[12]), .C(C_load_data[12]));
PDDW08DGZ_H_G I_LODATA13(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[13]), .C(C_load_data[13]));
PDDW08DGZ_H_G I_LODATA14(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[14]), .C(C_load_data[14]));
PDDW08DGZ_H_G I_LODATA15(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[15]), .C(C_load_data[15]));
PDDW08DGZ_H_G I_LODATA16(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[16]), .C(C_load_data[16]));
PDDW08DGZ_H_G I_LODATA17(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[17]), .C(C_load_data[17]));
PDDW08DGZ_H_G I_LODATA18(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[18]), .C(C_load_data[18]));
PDDW08DGZ_H_G I_LODATA19(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[19]), .C(C_load_data[19]));
PDDW08DGZ_H_G I_LODATA20(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[20]), .C(C_load_data[20]));
PDDW08DGZ_H_G I_LODATA21(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[21]), .C(C_load_data[21]));
PDDW08DGZ_H_G I_LODATA22(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[22]), .C(C_load_data[22]));
PDDW08DGZ_H_G I_LODATA23(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[23]), .C(C_load_data[23]));
PDDW08DGZ_H_G I_LODATA24(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[24]), .C(C_load_data[24]));
PDDW08DGZ_H_G I_LODATA25(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[25]), .C(C_load_data[25]));
PDDW08DGZ_H_G I_LODATA26(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[26]), .C(C_load_data[26]));
PDDW08DGZ_H_G I_LODATA27(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[27]), .C(C_load_data[27]));
PDDW08DGZ_H_G I_LODATA28(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[28]), .C(C_load_data[28]));
PDDW08DGZ_H_G I_LODATA29(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[29]), .C(C_load_data[29]));
PDDW08DGZ_H_G I_LODATA30(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[30]), .C(C_load_data[30]));
PDDW08DGZ_H_G I_LODATA31(.I(1'b0), .OEN(1'b1), .REN(1'b0), .PAD(load_data[31]), .C(C_load_data[31]));


// Output Pads
PDDW08DGZ_H_G O_PC0 (.I(C_pc[0]),  .OEN(1'b0), .REN(1'b0), .PAD(pc[0]),  .C());
PDDW08DGZ_H_G O_PC1 (.I(C_pc[1]),  .OEN(1'b0), .REN(1'b0), .PAD(pc[1]),  .C());
PDDW08DGZ_H_G O_PC2 (.I(C_pc[2]),  .OEN(1'b0), .REN(1'b0), .PAD(pc[2]),  .C());
PDDW08DGZ_H_G O_PC3 (.I(C_pc[3]),  .OEN(1'b0), .REN(1'b0), .PAD(pc[3]),  .C());
PDDW08DGZ_H_G O_PC4 (.I(C_pc[4]),  .OEN(1'b0), .REN(1'b0), .PAD(pc[4]),  .C());
PDDW08DGZ_H_G O_PC5 (.I(C_pc[5]),  .OEN(1'b0), .REN(1'b0), .PAD(pc[5]),  .C());
PDDW08DGZ_H_G O_PC6 (.I(C_pc[6]),  .OEN(1'b0), .REN(1'b0), .PAD(pc[6]),  .C());
PDDW08DGZ_H_G O_PC7 (.I(C_pc[7]),  .OEN(1'b0), .REN(1'b0), .PAD(pc[7]),  .C());
PDDW08DGZ_H_G O_PC8 (.I(C_pc[8]),  .OEN(1'b0), .REN(1'b0), .PAD(pc[8]),  .C());
PDDW08DGZ_H_G O_PC9 (.I(C_pc[9]),  .OEN(1'b0), .REN(1'b0), .PAD(pc[9]),  .C());
PDDW08DGZ_H_G O_PC10(.I(C_pc[10]), .OEN(1'b0), .REN(1'b0), .PAD(pc[10]), .C());
PDDW08DGZ_H_G O_PC11(.I(C_pc[11]), .OEN(1'b0), .REN(1'b0), .PAD(pc[11]), .C());
PDDW08DGZ_H_G O_PC12(.I(C_pc[12]), .OEN(1'b0), .REN(1'b0), .PAD(pc[12]), .C());
PDDW08DGZ_H_G O_PC13(.I(C_pc[13]), .OEN(1'b0), .REN(1'b0), .PAD(pc[13]), .C());
PDDW08DGZ_H_G O_PC14(.I(C_pc[14]), .OEN(1'b0), .REN(1'b0), .PAD(pc[14]), .C());
PDDW08DGZ_H_G O_PC15(.I(C_pc[15]), .OEN(1'b0), .REN(1'b0), .PAD(pc[15]), .C());
PDDW08DGZ_H_G O_PC16(.I(C_pc[16]), .OEN(1'b0), .REN(1'b0), .PAD(pc[16]), .C());
PDDW08DGZ_H_G O_PC17(.I(C_pc[17]), .OEN(1'b0), .REN(1'b0), .PAD(pc[17]), .C());
PDDW08DGZ_H_G O_PC18(.I(C_pc[18]), .OEN(1'b0), .REN(1'b0), .PAD(pc[18]), .C());
PDDW08DGZ_H_G O_PC19(.I(C_pc[19]), .OEN(1'b0), .REN(1'b0), .PAD(pc[19]), .C());
PDDW08DGZ_H_G O_PC20(.I(C_pc[20]), .OEN(1'b0), .REN(1'b0), .PAD(pc[20]), .C());
PDDW08DGZ_H_G O_PC21(.I(C_pc[21]), .OEN(1'b0), .REN(1'b0), .PAD(pc[21]), .C());
PDDW08DGZ_H_G O_PC22(.I(C_pc[22]), .OEN(1'b0), .REN(1'b0), .PAD(pc[22]), .C());
PDDW08DGZ_H_G O_PC23(.I(C_pc[23]), .OEN(1'b0), .REN(1'b0), .PAD(pc[23]), .C());
PDDW08DGZ_H_G O_PC24(.I(C_pc[24]), .OEN(1'b0), .REN(1'b0), .PAD(pc[24]), .C());
PDDW08DGZ_H_G O_PC25(.I(C_pc[25]), .OEN(1'b0), .REN(1'b0), .PAD(pc[25]), .C());
PDDW08DGZ_H_G O_PC26(.I(C_pc[26]), .OEN(1'b0), .REN(1'b0), .PAD(pc[26]), .C());
PDDW08DGZ_H_G O_PC27(.I(C_pc[27]), .OEN(1'b0), .REN(1'b0), .PAD(pc[27]), .C());
PDDW08DGZ_H_G O_PC28(.I(C_pc[28]), .OEN(1'b0), .REN(1'b0), .PAD(pc[28]), .C());
PDDW08DGZ_H_G O_PC29(.I(C_pc[29]), .OEN(1'b0), .REN(1'b0), .PAD(pc[29]), .C());
PDDW08DGZ_H_G O_PC30(.I(C_pc[30]), .OEN(1'b0), .REN(1'b0), .PAD(pc[30]), .C());
PDDW08DGZ_H_G O_PC31(.I(C_pc[31]), .OEN(1'b0), .REN(1'b0), .PAD(pc[31]), .C());
PDDW08DGZ_H_G O_ADDR0 (.I(C_addr[0]),  .OEN(1'b0), .REN(1'b0), .PAD(addr[0]),  .C());
PDDW08DGZ_H_G O_ADDR1 (.I(C_addr[1]),  .OEN(1'b0), .REN(1'b0), .PAD(addr[1]),  .C());
PDDW08DGZ_H_G O_ADDR2 (.I(C_addr[2]),  .OEN(1'b0), .REN(1'b0), .PAD(addr[2]),  .C());
PDDW08DGZ_H_G O_ADDR3 (.I(C_addr[3]),  .OEN(1'b0), .REN(1'b0), .PAD(addr[3]),  .C());
PDDW08DGZ_H_G O_ADDR4 (.I(C_addr[4]),  .OEN(1'b0), .REN(1'b0), .PAD(addr[4]),  .C());
PDDW08DGZ_H_G O_ADDR5 (.I(C_addr[5]),  .OEN(1'b0), .REN(1'b0), .PAD(addr[5]),  .C());
PDDW08DGZ_H_G O_ADDR6 (.I(C_addr[6]),  .OEN(1'b0), .REN(1'b0), .PAD(addr[6]),  .C());
PDDW08DGZ_H_G O_ADDR7 (.I(C_addr[7]),  .OEN(1'b0), .REN(1'b0), .PAD(addr[7]),  .C());
PDDW08DGZ_H_G O_ADDR8 (.I(C_addr[8]),  .OEN(1'b0), .REN(1'b0), .PAD(addr[8]),  .C());
PDDW08DGZ_H_G O_ADDR9 (.I(C_addr[9]),  .OEN(1'b0), .REN(1'b0), .PAD(addr[9]),  .C());
PDDW08DGZ_H_G O_ADDR10(.I(C_addr[10]), .OEN(1'b0), .REN(1'b0), .PAD(addr[10]), .C());
PDDW08DGZ_H_G O_ADDR11(.I(C_addr[11]), .OEN(1'b0), .REN(1'b0), .PAD(addr[11]), .C());
PDDW08DGZ_H_G O_ADDR12(.I(C_addr[12]), .OEN(1'b0), .REN(1'b0), .PAD(addr[12]), .C());
PDDW08DGZ_H_G O_ADDR13(.I(C_addr[13]), .OEN(1'b0), .REN(1'b0), .PAD(addr[13]), .C());
PDDW08DGZ_H_G O_ADDR14(.I(C_addr[14]), .OEN(1'b0), .REN(1'b0), .PAD(addr[14]), .C());
PDDW08DGZ_H_G O_ADDR15(.I(C_addr[15]), .OEN(1'b0), .REN(1'b0), .PAD(addr[15]), .C());
PDDW08DGZ_H_G O_ADDR16(.I(C_addr[16]), .OEN(1'b0), .REN(1'b0), .PAD(addr[16]), .C());
PDDW08DGZ_H_G O_ADDR17(.I(C_addr[17]), .OEN(1'b0), .REN(1'b0), .PAD(addr[17]), .C());
PDDW08DGZ_H_G O_ADDR18(.I(C_addr[18]), .OEN(1'b0), .REN(1'b0), .PAD(addr[18]), .C());
PDDW08DGZ_H_G O_ADDR19(.I(C_addr[19]), .OEN(1'b0), .REN(1'b0), .PAD(addr[19]), .C());
PDDW08DGZ_H_G O_ADDR20(.I(C_addr[20]), .OEN(1'b0), .REN(1'b0), .PAD(addr[20]), .C());
PDDW08DGZ_H_G O_ADDR21(.I(C_addr[21]), .OEN(1'b0), .REN(1'b0), .PAD(addr[21]), .C());
PDDW08DGZ_H_G O_ADDR22(.I(C_addr[22]), .OEN(1'b0), .REN(1'b0), .PAD(addr[22]), .C());
PDDW08DGZ_H_G O_ADDR23(.I(C_addr[23]), .OEN(1'b0), .REN(1'b0), .PAD(addr[23]), .C());
PDDW08DGZ_H_G O_ADDR24(.I(C_addr[24]), .OEN(1'b0), .REN(1'b0), .PAD(addr[24]), .C());
PDDW08DGZ_H_G O_ADDR25(.I(C_addr[25]), .OEN(1'b0), .REN(1'b0), .PAD(addr[25]), .C());
PDDW08DGZ_H_G O_ADDR26(.I(C_addr[26]), .OEN(1'b0), .REN(1'b0), .PAD(addr[26]), .C());
PDDW08DGZ_H_G O_ADDR27(.I(C_addr[27]), .OEN(1'b0), .REN(1'b0), .PAD(addr[27]), .C());
PDDW08DGZ_H_G O_ADDR28(.I(C_addr[28]), .OEN(1'b0), .REN(1'b0), .PAD(addr[28]), .C());
PDDW08DGZ_H_G O_ADDR29(.I(C_addr[29]), .OEN(1'b0), .REN(1'b0), .PAD(addr[29]), .C());
PDDW08DGZ_H_G O_ADDR30(.I(C_addr[30]), .OEN(1'b0), .REN(1'b0), .PAD(addr[30]), .C());
PDDW08DGZ_H_G O_ADDR31(.I(C_addr[31]), .OEN(1'b0), .REN(1'b0), .PAD(addr[31]), .C());
PDDW08DGZ_H_G O_STR_DATA0 (.I(C_store_data[0]),  .OEN(1'b0), .REN(1'b0), .PAD(store_data[0]),  .C());
PDDW08DGZ_H_G O_STR_DATA1 (.I(C_store_data[1]),  .OEN(1'b0), .REN(1'b0), .PAD(store_data[1]),  .C());
PDDW08DGZ_H_G O_STR_DATA2 (.I(C_store_data[2]),  .OEN(1'b0), .REN(1'b0), .PAD(store_data[2]),  .C());
PDDW08DGZ_H_G O_STR_DATA3 (.I(C_store_data[3]),  .OEN(1'b0), .REN(1'b0), .PAD(store_data[3]),  .C());
PDDW08DGZ_H_G O_STR_DATA4 (.I(C_store_data[4]),  .OEN(1'b0), .REN(1'b0), .PAD(store_data[4]),  .C());
PDDW08DGZ_H_G O_STR_DATA5 (.I(C_store_data[5]),  .OEN(1'b0), .REN(1'b0), .PAD(store_data[5]),  .C());
PDDW08DGZ_H_G O_STR_DATA6 (.I(C_store_data[6]),  .OEN(1'b0), .REN(1'b0), .PAD(store_data[6]),  .C());
PDDW08DGZ_H_G O_STR_DATA7 (.I(C_store_data[7]),  .OEN(1'b0), .REN(1'b0), .PAD(store_data[7]),  .C());
PDDW08DGZ_H_G O_STR_DATA8 (.I(C_store_data[8]),  .OEN(1'b0), .REN(1'b0), .PAD(store_data[8]),  .C());
PDDW08DGZ_H_G O_STR_DATA9 (.I(C_store_data[9]),  .OEN(1'b0), .REN(1'b0), .PAD(store_data[9]),  .C());
PDDW08DGZ_H_G O_STR_DATA10(.I(C_store_data[10]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[10]), .C());
PDDW08DGZ_H_G O_STR_DATA11(.I(C_store_data[11]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[11]), .C());
PDDW08DGZ_H_G O_STR_DATA12(.I(C_store_data[12]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[12]), .C());
PDDW08DGZ_H_G O_STR_DATA13(.I(C_store_data[13]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[13]), .C());
PDDW08DGZ_H_G O_STR_DATA14(.I(C_store_data[14]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[14]), .C());
PDDW08DGZ_H_G O_STR_DATA15(.I(C_store_data[15]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[15]), .C());
PDDW08DGZ_H_G O_STR_DATA16(.I(C_store_data[16]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[16]), .C());
PDDW08DGZ_H_G O_STR_DATA17(.I(C_store_data[17]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[17]), .C());
PDDW08DGZ_H_G O_STR_DATA18(.I(C_store_data[18]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[18]), .C());
PDDW08DGZ_H_G O_STR_DATA19(.I(C_store_data[19]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[19]), .C());
PDDW08DGZ_H_G O_STR_DATA20(.I(C_store_data[20]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[20]), .C());
PDDW08DGZ_H_G O_STR_DATA21(.I(C_store_data[21]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[21]), .C());
PDDW08DGZ_H_G O_STR_DATA22(.I(C_store_data[22]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[22]), .C());
PDDW08DGZ_H_G O_STR_DATA23(.I(C_store_data[23]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[23]), .C());
PDDW08DGZ_H_G O_STR_DATA24(.I(C_store_data[24]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[24]), .C());
PDDW08DGZ_H_G O_STR_DATA25(.I(C_store_data[25]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[25]), .C());
PDDW08DGZ_H_G O_STR_DATA26(.I(C_store_data[26]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[26]), .C());
PDDW08DGZ_H_G O_STR_DATA27(.I(C_store_data[27]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[27]), .C());
PDDW08DGZ_H_G O_STR_DATA28(.I(C_store_data[28]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[28]), .C());
PDDW08DGZ_H_G O_STR_DATA29(.I(C_store_data[29]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[29]), .C());
PDDW08DGZ_H_G O_STR_DATA30(.I(C_store_data[30]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[30]), .C());
PDDW08DGZ_H_G O_STR_DATA31(.I(C_store_data[31]), .OEN(1'b0), .REN(1'b0), .PAD(store_data[31]), .C());
PDDW08DGZ_H_G O_LOAD_REQQ (.I(C_load_req[0]),  .OEN(1'b0), .REN(1'b0), .PAD(load_req[0]),  .C());
PDDW08DGZ_H_G O_LOAD_REQ1 (.I(C_load_req[1]),  .OEN(1'b0), .REN(1'b0), .PAD(load_req[1]),  .C());
PDDW08DGZ_H_G O_LOAD_REQ2 (.I(C_load_req[2]),  .OEN(1'b0), .REN(1'b0), .PAD(load_req[2]),  .C());
PDDW08DGZ_H_G O_LOAD_REQ3 (.I(C_load_req[3]),  .OEN(1'b0), .REN(1'b0), .PAD(load_req[3]),  .C());
PDDW08DGZ_H_G O_STR_REQ0 (.I(C_store_req[0]),  .OEN(1'b0), .REN(1'b0), .PAD(store_req[0]),  .C());
PDDW08DGZ_H_G O_STR_REQ1 (.I(C_store_req[1]),  .OEN(1'b0), .REN(1'b0), .PAD(store_req[1]),  .C());
PDDW08DGZ_H_G O_STR_REQ2 (.I(C_store_req[2]),  .OEN(1'b0), .REN(1'b0), .PAD(store_req[2]),  .C());
PDDW08DGZ_H_G O_STR_REQ3 (.I(C_store_req[3]),  .OEN(1'b0), .REN(1'b0), .PAD(store_req[3]),  .C());

// IO power 
PVDD2DGZ_H_G VDDP0 (.VDDPST(VDDIO));
PVSS2DGZ_H_G GNDP0 (.VSSPST(VSSIO));
PVDD2DGZ_H_G VDDP1 (.VDDPST(VDDIO));
PVSS2DGZ_H_G GNDP1 (.VSSPST(VSSIO));
PVDD2DGZ_H_G VDDP2 (.VDDPST(VDDIO));
PVSS2DGZ_H_G GNDP2 (.VSSPST(VSSIO));
PVDD2DGZ_H_G VDDP3 (.VDDPST(VDDIO));
PVSS2DGZ_H_G GNDP3 (.VSSPST(VSSIO));


// Core power
PVDD1DGZ_H_G VDDC0 (.VDD(VDDC));
PVSS1DGZ_H_G GNDC0 (.VSS(VSSC));
PVDD1DGZ_H_G VDDC1 (.VDD(VDDC));
PVSS1DGZ_H_G GNDC1 (.VSS(VSSC));
PVDD1DGZ_H_G VDDC2 (.VDD(VDDC));
PVSS1DGZ_H_G GNDC2 (.VSS(VSSC));
PVDD1DGZ_H_G VDDC3 (.VDD(VDDC));
PVSS1DGZ_H_G GNDC3 (.VSS(VSSC));


endmodule
