`include "fetch.v"
`include "alu.v"
`include "writeBack.v"
`include "memory.v"
module setSignals(start,stage1,stage2,stage3,stage4,stage5);
    input start;
    output reg stage1,stage2,stage3,stage3,stage4,stage5,endProgram;
    always(@start) begin
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
    reg [3:0] pc;
    reg start,clock;
    wire stage1,stage2,stage3,stage4,stage5; //stages of MIPS processor
    wire [5:0]opcode,[4:0]rs,[4:0]rt,[4:0]rd,[31:0]immediate,[4:0]shamt,[5:0]funct,[31:0]readData1,[31:0]readData2; //intermediate signals
    wire regDest, branch, memRead, memToReg, [1:0]aluOP, memWrite, aluSrc, regWrite,, zero, endProgram; // control signals
    wire [7:0] memaddress;
    wire [5:0] regaddress;
    wire [31:0]curInstruction;
    wire [31:0]resvalue;
    fetch fetchModule(pc,start,curInstruction,stage1,stage2,clock);
    decode decodeModule(curInstruction,clock,opcode,rs,rt,rd,immediate,shamt,funct,regDest, branch, memRead, memToReg, aluOP, memWrite, aluSrc, regWrite, endProgram);
    alu aluModule(readData1,readData2,funct,aluOP,)
    memory memoryModule(memWrite,memRead,memaddress,resvalue,resvalue,stage4,stage5,clock);
    writeBack writeBackModule(controlWriteBack,regaddress,resvalue,stage5,start1,clock);
    initial begin
       pc = 4'b0000;
       start = 1;
       clock = 0; 
    end
    always@(clock) begin
        start = 0;
        #5;
        clock = ~clock;
    end
endmodule