`include "fetch.v"
`include "decode.v"
`include "alu.v"
`include "writeBack.v"
`include "memory.v"

module mipsProcessor(reset,clock);
    reg [3:0]pc;
    input reset,clock;
    reg [2:0]stage; //stages of MIPS processor
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
    fetch fetchModule(pc,curInstruction,stage,clock);
    decode decodeModule(curInstruction,clock,opcode,rs,rt,rd,immediate,shamt,funct,regDest, branch, memRead, memToReg, aluOP, memWrite, aluSrc, regWrite, endProgram,readData1,readData2,stage);
    alu aluModule(readData1,readData2,funct,aluOP,immediate,aluSrc,zero,aluOut,stage,clock);
    memory memoryModule(memWrite,memRead,memaddress,resvalue,resvalue,stage,clock);
    writeBack writeBackModule(regWrite,regDest,address1,address2,resvalue,stage,clock);
    initial begin
       pc = 4'b0000;
       stage = 3'b100;
    end
    always @ (negedge clock)
     stage = (stage + 1)%5;
endmodule

module mipsTb;
    reg clock;
    reg reset;
    mipsProcessor mainModule(reset,clock);
    initial begin
        clock = 0;
        reset = 0;
        $dumpfile("mips.vcd");
        $dumpvars(0,mipsTb);
    end
    always #5 clock = ~clock;
    always #100 reset = ~reset;
endmodule