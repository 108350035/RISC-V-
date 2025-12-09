clear; clc;

num_inst = 4096;
bin_inst = strings(num_inst,1);
asm_inst = strings(num_inst,1);

toBitsUnsigned = @(v,w) dec2bin(mod(v, 2^w), w);
toBitsSigned   = @(v,w) dec2bin(mod(v, 2^w), w);
randReg = @() randi([0 31],1);

R_opcode    = '0110011';
I_opcode    = '0010011';
LOAD_opcode = '0000011';
STORE_opcode= '0100011';
LUI_opcode  = '0110111';
AUIPC_opcode= '0010111';
JAL_opcode  = '1101111';
JALR_opcode = '1100111';
BR_opcode   = '1100011';

R_ops = { ...
    'ADD','0000000','000';
    'SUB','0100000','000';
    'SLL','0000000','001';
    'SLT','0000000','010';
    'SLTU','0000000','011';
    'XOR','0000000','100';
    'SRL','0000000','101';
    'SRA','0100000','101';
    'OR','0000000','110';
    'AND','0000000','111' };

I_ops = { ...
    'ADDI','000';
    'SLTI','010';
    'SLTIU','011';
    'XORI','100';
    'ORI','110';
    'ANDI','111';
    'SLLI','001';
    'SRLI','101';
    'SRAI','101' };

M_ops = {'MUL','MULH','MULHU','MULHSU','DIV','DIVU','REM','REMU'};
M_funct7 = repmat({'0000001'},1,8);
M_funct3 = {'000','001','010','011','100','101','110','111'};

S_ops = { 'SB','000'; 'SH','001'; 'SW','010' };
L_ops = { 'LB','000'; 'LH','001'; 'LW','010'; 'LBU','100'; 'LHU','101' };
B_ops = { 'BEQ','000'; 'BNE','001'; 'BLT','100'; 'BGE','101'; 'BLTU','110'; 'BGEU','111' };

p=1; % pointer

% 前256條SW指令，先將RAM的數據填滿，保證後續不會造成unknown
for n = 0:255
    rs1 = 0; rs2 = randReg();      % rs1固定0
    imm_raw = n;                   % offset 0~255
    imm12 = toBitsUnsigned(imm_raw,12);
    imm11_5 = imm12(1:7); imm4_0 = imm12(8:12);
    funct3 = '010';               
    inst = [imm11_5, toBitsUnsigned(rs2,5), toBitsUnsigned(rs1,5), funct3, imm4_0, STORE_opcode];
    bin_inst(p) = string(inst);
    asm_inst(p) = sprintf('SW x%d, %d(x%d)', rs2, imm_raw, rs1);
    p = p + 1;
end

%% 100 R-type
for n=1:100
    idx = randi(size(R_ops,1));
    opname = R_ops{idx,1}; funct7 = R_ops{idx,2}; funct3 = R_ops{idx,3};
    rd = randReg(); rs1 = randReg(); rs2 = randReg();
    inst = [funct7, toBitsUnsigned(rs2,5), toBitsUnsigned(rs1,5), funct3, toBitsUnsigned(rd,5), R_opcode];
    bin_inst(p)=string(inst);
    asm_inst(p)=sprintf('%s x%d, x%d, x%d',opname,rd,rs1,rs2);
    p=p+1;
end

% 100 I-type (no load)
for n=1:100
    idx = randi(size(I_ops,1));
    opname = I_ops{idx,1}; funct3 = I_ops{idx,2};
    rd = randReg(); rs1 = randReg();
    if any(strcmp(opname, {'SLLI','SRLI','SRAI'}))
        shamt = randi([0 31]);
        if strcmp(opname,'SRAI'), imm=['010000',toBitsUnsigned(shamt,5)];
        else imm=['000000',toBitsUnsigned(shamt,5)]; end
        inst=[imm,toBitsUnsigned(rs1,5),funct3,toBitsUnsigned(rd,5),I_opcode];
        asm_inst(p)=sprintf('%s x%d, x%d, %d',opname,rd,rs1,shamt);
    else
        imm_raw=randi([-2048,2047]);
        imm=toBitsSigned(imm_raw,12);
        inst=[imm,toBitsUnsigned(rs1,5),funct3,toBitsUnsigned(rd,5),I_opcode];
        asm_inst(p)=sprintf('%s x%d, x%d, %d',opname,rd,rs1,imm_raw);
    end
    bin_inst(p)=string(inst); p=p+1;
end

% 100 LUI
for n=1:100
    rd=randReg(); imm20=randi([0,2^20-1]);
    inst=[toBitsUnsigned(imm20,20),toBitsUnsigned(rd,5),LUI_opcode];
    bin_inst(p)=string(inst);
    asm_inst(p)=sprintf('LUI x%d,0x%05X',rd,imm20);
    p=p+1;
end

% 100 AUIPC
for n=1:100
    rd=randReg(); imm20=randi([0,2^20-1]);
    inst=[toBitsUnsigned(imm20,20),toBitsUnsigned(rd,5),AUIPC_opcode];
    bin_inst(p)=string(inst);
    asm_inst(p)=sprintf('AUIPC x%d,0x%05X',rd,imm20);
    p=p+1;
end

% RV32M 8*50
for m=1:8
    for n=1:50
        rd=randReg(); rs1=randReg(); rs2=randReg();
        inst=[M_funct7{m},toBitsUnsigned(rs2,5),toBitsUnsigned(rs1,5),M_funct3{m},toBitsUnsigned(rd,5),R_opcode];
        bin_inst(p)=string(inst);
        asm_inst(p)=sprintf('%s x%d, x%d, x%d',M_ops{m},rd,rs1,rs2);
        p=p+1;
    end
end

% 1000 STORE (random)
for n=1:1000
    rs1=randReg(); rs2=randReg();
    srow=randi(size(S_ops,1)); funct3=S_ops{srow,2};
    imm_word=mod(n-1,1024); imm_raw=imm_word*4;
    imm12=toBitsUnsigned(imm_raw,12);
    imm11_5=imm12(1:7); imm4_0=imm12(8:12);
    inst=[imm11_5,toBitsUnsigned(rs2,5),toBitsUnsigned(rs1,5),funct3,imm4_0,STORE_opcode];
    bin_inst(p)=string(inst);
    asm_inst(p)=sprintf('%s x%d, %d(x%d)',S_ops{srow,1},rs2,imm_raw,rs1);
    p=p+1;
end

% 100 LOAD
for n=1:100
    lidx=randi(size(L_ops,1)); opname=L_ops{lidx,1}; funct3=L_ops{lidx,2};
    rd=randReg(); rs1=randReg(); imm_raw=randi([-2048,2047]);
    imm=toBitsSigned(imm_raw,12);
    inst=[imm,toBitsUnsigned(rs1,5),funct3,toBitsUnsigned(rd,5),LOAD_opcode];
    bin_inst(p)=string(inst);
    asm_inst(p)=sprintf('%s x%d, %d(x%d)',opname,rd,imm_raw,rs1);
    p=p+1;
end

% 10 JAL (imm 0~5)
for n=1:10
    rd = randReg();
    imm_raw = randi([0 5]); 
    imm21 = toBitsSigned(imm_raw,21); 
    imm20=imm21(1); imm10_1=imm21(2:11); imm11=imm21(12); imm19_12=imm21(13:20);
    inst=[imm20,imm10_1,imm11,imm19_12,toBitsUnsigned(rd,5),JAL_opcode];
    bin_inst(p)=string(inst); 
    asm_inst(p)=sprintf('JAL x%d, %d', rd, imm_raw); 
    p=p+1;
end

% 10 JALR (imm 0~5)
for n=1:10
    rd = randReg(); rs1 = randReg();
    imm_raw = randi([0 5]); 
    imm = toBitsSigned(imm_raw,12);
    inst = [imm, toBitsUnsigned(rs1,5), '000', toBitsUnsigned(rd,5), JALR_opcode];
    bin_inst(p)=string(inst); 
    asm_inst(p)=sprintf('JALR x%d, %d(x%d)', rd, imm_raw, rs1); 
    p=p+1;
end

% 10 BRANCH (imm 0~5)
for n=1:10
    bidx = randi(size(B_ops,1)); opname=B_ops{bidx,1}; funct3=B_ops{bidx,2};
    rs1 = randReg(); rs2 = randReg(); 
    imm_raw = randi([0 5]); 
    if mod(imm_raw,2) ~=0, imm_raw = imm_raw-1; end
    imm13 = toBitsSigned(imm_raw,13);
    inst = [imm13(1), imm13(2:7), toBitsUnsigned(rs2,5), toBitsUnsigned(rs1,5), funct3, imm13(8:11), imm13(12), BR_opcode];
    bin_inst(p)=string(inst); 
    asm_inst(p)=sprintf('%s x%d, x%d, %d', opname, rs1, rs2, imm_raw); 
    p=p+1;
end

% 1910 隨機 (不含 load)
remaining=num_inst-(p-1);
for n=1:remaining
    typ=randi([1 5]); % R/I/U/M/S
    switch typ
        case 1 % R-type
            idxr=randi(size(R_ops,1));
            opname=R_ops{idxr,1}; funct7=R_ops{idxr,2}; funct3=R_ops{idxr,3};
            rd=randReg(); rs1=randReg(); rs2=randReg();
            inst=[funct7,toBitsUnsigned(rs2,5),toBitsUnsigned(rs1,5),funct3,toBitsUnsigned(rd,5),R_opcode];
            asm_inst(p)=sprintf('%s x%d, x%d, x%d',opname,rd,rs1,rs2);
        case 2 % I-type
            idxi=randi(size(I_ops,1)); opname=I_ops{idxi,1}; funct3=I_ops{idxi,2};
            rd=randReg(); rs1=randReg();
            if any(strcmp(opname,{'SLLI','SRLI','SRAI'}))
                shamt=randi([0 31]); if strcmp(opname,'SRAI'), imm=['010000',toBitsUnsigned(shamt,5)];
                else imm=['000000',toBitsUnsigned(shamt,5)]; end
                inst=[imm,toBitsUnsigned(rs1,5),funct3,toBitsUnsigned(rd,5),I_opcode];
                asm_inst(p)=sprintf('%s x%d, x%d, %d',opname,rd,rs1,shamt);
            else
                imm_raw=randi([-2048,2047]); imm=toBitsSigned(imm_raw,12);
                inst=[imm,toBitsUnsigned(rs1,5),funct3,toBitsUnsigned(rd,5),I_opcode];
                asm_inst(p)=sprintf('%s x%d, x%d, %d',opname,rd,rs1,imm_raw);
            end
        case 3 % U-type
            uidx=randi(2); rd=randReg(); imm20=randi([0,2^20-1]);
            if uidx==1, inst=[toBitsUnsigned(imm20,20),toBitsUnsigned(rd,5),LUI_opcode]; asm_inst(p)=sprintf('LUI x%d,0x%05X',rd,imm20);
            else inst=[toBitsUnsigned(imm20,20),toBitsUnsigned(rd,5),AUIPC_opcode]; asm_inst(p)=sprintf('AUIPC x%d,0x%05X',rd,imm20); end
        case 4 % M-type
            m=randi(8); rd=randReg(); rs1=randReg(); rs2=randReg();
            inst=[M_funct7{m},toBitsUnsigned(rs2,5),toBitsUnsigned(rs1,5),M_funct3{m},toBitsUnsigned(rd,5),R_opcode];
            asm_inst(p)=sprintf('%s x%d, x%d, x%d',M_ops{m},rd,rs1,rs2);
        case 5 % S-type
            srow=randi(size(S_ops,1)); opname=S_ops{srow,1}; funct3=S_ops{srow,2};
            rs1=randReg(); rs2=randReg(); imm_raw=randi([-2048,2047]);
            imm12=toBitsSigned(imm_raw,12); imm11_5=imm12(1:7); imm4_0=imm12(8:12);
            inst=[imm11_5,toBitsUnsigned(rs2,5),toBitsUnsigned(rs1,5),funct3,imm4_0,STORE_opcode];
            asm_inst(p)=sprintf('%s x%d, %d(x%d)',opname,rs2,imm_raw,rs1);
    end
    bin_inst(p)=string(inst); p=p+1;
end

fid=fopen('inst_bin.txt','w');
for k=1:num_inst, fprintf(fid,'%s\n',bin_inst(k)); end
fclose(fid);

fid=fopen('inst_asm.txt','w');
for k=1:num_inst, fprintf(fid,'%s\n',asm_inst(k)); end
fclose(fid);
