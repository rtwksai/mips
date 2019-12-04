`include "fetch.v"
`include "decode.v"
`include "alu.v"
`include "writeBack.v"
`include "memory.v"
module setSignals(start,stage1,stage2,stage3,stage4,stage5);
    input start;
    output reg stage1,stage2,stage3,stage4,stage5,endProgram;
    always@(posedge start) begin
        if(start == 1) begin
            stage1 = 0;
            stage2 = 0;
            stage3 = 0;
            stage4 = 0;
            stage5 = 0;
        end
    end

endmodule
module mipsProcessor();
    wire [3:0] pc;
    wire start,clock;
    wire stage1,stage2,stage3,stage4,stage5; //stages of MIPS processor
    //intermediate signals -->
    wire [5:0] opcode,funct;
    wire [4:0] rs,rt,rd,shamt; 
    wire [31:0]immediate,readData1,readData2,aluOut;
    //<--
    wire regDest, branch, memRead, memToReg , memWrite, aluSrc, regWrite, zero, endProgram; // control signals
    wire [1:0]aluOP;
    wire [7:0] memaddress;
    wire [5:0] address1,address2;
    wire [31:0]curInstruction;
    wire [31:0]resvalue;
    
    setSignals initialModule(start,stage1,start2,start3,start4,start5);
    fetch fetchModule(pc,start,curInstruction,stage1,stage2,clock);
    decode decodeModule(curInstruction,clock,opcode,rs,rt,rd,immediate,shamt,funct,regDest, branch, memRead, memToReg, aluOP, memWrite, aluSrc, regWrite, endProgram,readData1,readData2,stage2,stage3);
    alu aluModule(readData1,readData2,funct,aluOP,immediate,aluSrc,zero,aluOut,stage3,stage4,clock);
    memory memoryModule(memWrite,memRead,memaddress,resvalue,resvalue,stage4,stage5,clock);
    writeBack writeBackModule(regWrite,regDest,address1,address2,resvalue,stage5,stage1,clock);
endmodule


module tb_MIPS_PROCESSOR();


mipsProcessor uut();

initial 
begin
    $dumpfile("mips.vcd");
    $dumpvars(0,mipsProcessor);
    pc = 4'b0000;
    #10;
    start = 1;
    clock = 0; 
end
always
begin
    start = 0;
    #5;
    clock = ~clock;
end
    
endmodule