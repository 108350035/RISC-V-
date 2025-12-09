`include "PC.v"
`include "ALU.v"
`include "ALU_unit.v"
`include "imm_generator.v"
`include "branch_unit.v"
`include "control_unit.v"
`include "load_unit.v"
`include "store_unit.v"
`include "target_addr.v"
`include "register_file.v"
`include "M.v"
`include "M_unit.v"
//synopsys translate_off
`include "/home/synopsys/syn/O-2018.06-SP1/dw/sim_ver/DW02_mult_2_stage.v"
`include "/home/synopsys/syn/O-2018.06-SP1/dw/sim_ver/DW_div_pipe.v"
`include "/home/synopsys/syn/O-2018.06-SP1/dw/sim_ver/DW_div.v"
//`include "/home/synopsys/syn/O-2018.06-SP1/dw/sim_ver/DW_div_function.inc"
//synopsys translate_on
module RISC(
input clk,rst_n,
input [31:0] inst,load_data,
output [31:0] store_data,
output [31:0] pc,addr,
output [3:0] load_req,store_req);

//   IF/ID
reg [31:0] pc_if,pc_4_if,inst_if;

//   ID/EX 
reg [2:0] funct3;
reg [4:0] RS1_id,RS2_id,RD_id;
reg funct7;
reg [1:0] mem_size_id;
reg [31:0] pc_id,pc_4_id,imm_id,DATA1_id,DATA2_id,regtoMem_data_id;
reg I_type_id,R_type_id,S_type_id,SB_type_id,load_type_id,M_type_id;
reg LUI_id,AUIPC_id,UJ_type_id,reg_write_id,j;

//   EXE/MEM reg
reg [4:0] RD_exe;
reg [1:0] mem_size_exe;
reg [31:0] ALU_R,DATA2_exe,pc_4_exe,regtoMem_data_exe,imm_exe,pc_exe,ALU_OP2_exe;
reg load_type_exe,S_type_exe,SB_type_exe,UJ_type_exe;
reg [2:0] funct3_exe;
reg LUI_exe,AUIPC_exe,reg_write_exe,M_type_exe,div_0_exe;

// MEM/WB reg
reg [31:0] write_data,imm_mem,ALU_K;
reg [31:0] ALU_OUT,pc_4_mem,load_data_reg,pc_mem;
reg [4:0] RD_mem;
reg load_type_mem,UJ_type_mem,AUIPC_mem,LUI_mem,reg_write_mem,M_type_mem;
wire [3:0] read,store;
assign store_data = (S_type_exe)?regtoMem_data_exe:0;
assign load_req = read;
assign store_req = store;


wire [31:0] target;
wire branch_taken,j_taken,flush,stall;
assign flush = (j_taken | branch_taken) || (pc == 32'd0);
assign stall = (load_type_exe) && ((RD_exe == RS1_id) || (RD_exe == RS2_id)) && (SB_type_id == 0);
PC U0(.clk(clk) ,.rst_n(rst_n) ,.j(j_taken) ,.branch(branch_taken) ,.enable(stall) ,.target(target) ,.pc_out(pc));

//   IF/ID
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        pc_if<=0;
        inst_if<=0;
        pc_4_if<=0;
    end
    else if(flush) begin
        pc_if<=0;
        inst_if<=0;
        pc_4_if<=0;
    end        
    else if(stall == 0) begin
        pc_if<=pc;
        inst_if<=inst;
        pc_4_if<=pc + 4;
    end
end

wire [31:0] OP1_data,OP2_data,imm;
wire [1:0] mem_size;
wire [2:0] sel;
wire I_type,R_type,S_type,SB_type,load_type,LUI,AUIPC,UJ_type,reg_write,M_type;
register_file U1(.clk(clk) ,.rst_n(rst_n) ,.RS1_addr(inst_if[19:15])
                ,.RS2_addr(inst_if[24:20]) ,.write_data(write_data) ,.w_en(reg_write_mem) ,.RS1_data(OP1_data)
                ,.RS2_data(OP2_data) ,.write_addr(RD_mem));

imm_generator U2(.inst(inst_if) ,.imm_sel(sel) ,.imm(imm));

control_unit U3(.opcode(inst_if[6:0]) ,.funct3(inst_if[14:12]) ,.funct7(inst_if[31:25])
                ,.S_type(S_type) ,.SB_type(SB_type) ,.load_type(load_type)
                ,.UJ_type(UJ_type) ,.R_type(R_type) ,.I_type(I_type) ,.LUI(LUI)
                ,.AUIPC(AUIPC) ,.reg_write(reg_write) ,.M_type(M_type)
                ,.size_reg(mem_size) ,.imm_sel(sel));


//   ID/EX 
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        mem_size_id<=0;
        I_type_id<=0;
        R_type_id<=0;
        S_type_id<=0;
        SB_type_id<=0;
        load_type_id<=0;
        LUI_id<=0;
        AUIPC_id<=0;
        UJ_type_id<=0;
        reg_write_id<=0;
        funct3<=0;
        j<=0;
        funct7<=0;
        pc_id<=0;
        pc_4_id<=0;
        imm_id<=0;
        DATA1_id<=0;
        DATA2_id<=0;
        RS1_id<=0;
        RS2_id<=0;
        RD_id<=0;
        R_type_id<=0;
        I_type_id<=0;
        regtoMem_data_id<=0;
        M_type_id<=0;
    end
    else if(flush) begin
        mem_size_id<=0;
        I_type_id<=0;
        R_type_id<=0;
        S_type_id<=0;
        SB_type_id<=0;
        load_type_id<=0;
        LUI_id<=0;
        AUIPC_id<=0;
        UJ_type_id<=0;
        reg_write_id<=0;
        funct3<=0;
        j<=0;
        funct7<=0;
        pc_id<=0;
        pc_4_id<=0;
        imm_id<=0;
        DATA1_id<=0;
        DATA2_id<=0;
        RS1_id<=0;
        RS2_id<=0;
        RD_id<=0;
        R_type_id<=0;
        I_type_id<=0;
        regtoMem_data_id<=0;
        M_type_id<=0;
    end
    else if(stall == 0) begin
        mem_size_id<=mem_size;
        I_type_id<=I_type;
        R_type_id<=R_type;
        S_type_id<=S_type;
        SB_type_id<=SB_type;
        load_type_id<=load_type;
        LUI_id<=LUI;
        AUIPC_id<=AUIPC;
        UJ_type_id<=UJ_type;
        reg_write_id<=reg_write;
        funct3<=inst_if[14:12];
        j<=inst_if[3];
        funct7<=inst_if[30];
        M_type_id<=M_type;
        pc_id<=pc_if;
        pc_4_id<=pc_4_if;
        imm_id<=imm;
        DATA1_id<=OP1_data;
        DATA2_id<=(I_type | LUI | AUIPC | S_type | load_type)?imm:OP2_data;
        regtoMem_data_id<=OP2_data;
        RS1_id<=inst_if[19:15];
        RS2_id<=inst_if[24:20];
        RD_id<=inst_if[11:7];
    end
end

wire [3:0] ALU_OP;
wire [2:0] M_OP;
wire [31:0] ALU_C,ALU_M;
reg [31:0] JALR_OP1,ALU_OP1,ALU_OP2;
reg [31:0] M_OP1,M_OP2;
wire div_0,en;
assign en = R_type_id & M_type_id;
ALU_unit U4(.funct3(funct3) ,.funct7(funct7) ,.R_type(R_type_id) ,.I_type(I_type_id) ,.ALU_OP(ALU_OP));
ALU U5(.OPCODE(ALU_OP) ,.ALU_A(ALU_OP1) ,.ALU_B(ALU_OP2) ,.ALU_C(ALU_C));
M_unit U00(.funct3(funct3) ,.M_OP(M_OP));
M U01 (.clk(clk) ,.rst_n(rst_n) ,.en(en) ,.OPCODE(M_OP) ,.ALU_A(M_OP1) ,.ALU_B(M_OP2) ,.ALU_C(ALU_M) ,.div_0(div_0));
branch_unit U6(.OP1(ALU_OP1) ,.OP2(ALU_OP2) ,.funct3(funct3) ,.SB_type(SB_type_id) ,.UJ_type(UJ_type_id) ,.branch_op(branch_taken) ,.j_op(j_taken));
target_addr U7(.UJ_type(UJ_type_id) ,.pc(pc_id) ,.imm(imm_id) ,.rs1_data(JALR_OP1) ,.j(j) ,.target(target));

always@(*)
begin
    if(reg_write_exe | reg_write_mem ) begin
        ALU_OP1 = (RS1_id == RD_exe)?ALU_R:((RS1_id == RD_mem)?((load_type_mem)?load_data_reg:ALU_OUT):DATA1_id);
        ALU_OP2 = (RS2_id == RD_exe)?ALU_R:((RS2_id == RD_mem)?((load_type_mem)?load_data_reg:ALU_OUT):DATA2_id);
    end
    else begin
        ALU_OP1 = DATA1_id;
        ALU_OP2 = DATA2_id;
    end
end

always@(*)
begin
    if(reg_write_exe | reg_write_mem ) JALR_OP1 = (RS1_id == RD_exe)?ALU_R:((RS1_id == RD_mem)?((load_type_mem)?load_data_reg:ALU_OUT):DATA1_id);
    else JALR_OP1 = DATA1_id;
end

always@(*)
begin
    if(div_0 == 1) begin
        M_OP1 = DATA1_id;
        M_OP2 = DATA2_id;
    end
    else if((reg_write_exe | reg_write_mem) ) begin
        M_OP1 = (RS1_id == RD_exe)?ALU_R:((RS1_id == RD_mem)?((load_type_mem)?load_data_reg:ALU_M):DATA1_id);
        M_OP2 = (RS2_id == RD_exe)?ALU_R:((RS2_id == RD_mem)?((load_type_mem)?load_data_reg:ALU_M):DATA2_id);
    end
    else begin
        M_OP1 = DATA1_id;
        M_OP2 = DATA2_id;
    end
end


//   EXE/MEM
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        div_0_exe<=0;
        ALU_R<=0;
        RD_exe<=0;
        DATA2_exe<=0;
        load_type_exe<=0;
        reg_write_exe<=0;
        S_type_exe<=0;
        SB_type_exe<=0;        
        pc_4_exe<=0;
        mem_size_exe<=0;
        funct3_exe<=0;
        UJ_type_exe<=0;
        imm_exe<=0;
        LUI_exe<=0;
        AUIPC_exe<=0;
        regtoMem_data_exe<=0;
        ALU_OP2_exe<=0;
        M_type_exe<=0;
        pc_exe<=0;
    end
    else begin
        div_0_exe<=div_0;
        ALU_R<=ALU_C;
        RD_exe<=RD_id;
        DATA2_exe<=DATA2_id;
        load_type_exe<=load_type_id;
        reg_write_exe<=reg_write_id;
        M_type_exe<=en;
        S_type_exe<=S_type_id;
        SB_type_exe<=SB_type_id;        
        pc_4_exe<=pc_4_id;
        mem_size_exe<=mem_size_id;
        funct3_exe<=funct3;   
        pc_exe<=pc_id;
        UJ_type_exe<=UJ_type_id;
        imm_exe<=imm_id;
        LUI_exe<=LUI_id;
        AUIPC_exe<=AUIPC_id;
        regtoMem_data_exe<=regtoMem_data_id;
        ALU_OP2_exe<=ALU_OP2; 
    end
end

assign addr = ALU_R;
load_unit U8 (.funct3(funct3_exe) ,.load_type(load_type_exe) ,.size(mem_size_exe) ,.read(read));
store_unit U9 (.funct3(funct3_exe) ,.S_type(S_type_exe) ,.size(mem_size_exe) ,.store(store));

//   MEM/WB 
always@(posedge clk,negedge rst_n)
begin
    if(!rst_n) begin
        ALU_OUT<=0;
        pc_4_mem<=0;
        reg_write_mem<=0;
        RD_mem<=0;
        load_type_mem<=0;
        load_data_reg<=0;
        UJ_type_mem<=0;
        LUI_mem<=0;
        imm_mem<=0;
        AUIPC_mem<=0;
        pc_mem<=0;
        ALU_K<=0;   
        M_type_mem<=0;
    end
    else begin
        load_data_reg<=(load_type_mem)?load_data:load_data_reg;
        ALU_OUT<=ALU_R;
        ALU_K<=(div_0)?0:ALU_M;        
        pc_4_mem<=pc_4_exe;
        pc_mem<=pc_exe;
        reg_write_mem<=(M_type_exe && div_0)?0:reg_write_exe;
        RD_mem<=RD_exe;
        load_type_mem<=load_type_exe;
        UJ_type_mem<=UJ_type_exe;
        imm_mem<=imm_exe;
        LUI_mem<=LUI_exe;
        AUIPC_mem<=AUIPC_exe;
        M_type_mem<=M_type_exe;
    end
end


always@(*)
begin
    if(load_type_mem) write_data = load_data;
    else if(UJ_type_mem) write_data = pc_4_mem;
    else if(LUI_mem) write_data = imm_mem;
    else if(AUIPC_mem) write_data = imm_mem + pc_mem;
    else write_data = (M_type_mem)?ALU_K:ALU_OUT;
end

endmodule
