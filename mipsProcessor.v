`include "fetch.v"
`include "decode.v"
`include "alu.v"
`include "writeBack.v"
`include "memory.v"

module mipsProcessor(reset,clock,endl);
    parameter INSTRUCTION_COUNT = 12;
    reg [3:0]pc;
    integer count;
    input reset,clock;
    reg [2:0]stage; //stages of MIPS processor
    //intermediate signals -->
    wire [5:0] opcode,funct;
    wire [4:0] rs,rt,rd,shamt; 
    wire [31:0]immediate,readData1,readData2,aluOut,memOut;
    output reg endl;
    //<--
    wire regDest, branch, memRead, memToReg , memWrite, aluSrc, regWrite, zero, endProgram; // control signals
    wire [1:0]aluOP;
    // wire [7:0] memaddress;
    // wire [4:0] address1,address2;
    wire [31:0]curInstruction;
    // wire [31:0]resvalue;
    fetch fetchModule (pc,curInstruction,stage,clock);
    decode decodeModule(curInstruction,clock,opcode,rs,rt,rd,immediate,shamt,funct,regDest, branch, memRead, memToReg, aluOP, memWrite, aluSrc, regWrite, endProgram,readData1,readData2,stage);
    alu aluModule(readData1,readData2,funct,aluOP,immediate,aluSrc,zero,aluOut,stage,clock);
    memory memoryModule(memWrite,memRead,aluOut[7:0],readData2,memOut,stage,clock);
    writeBack writeBackModule(regWrite,memToReg,regDest,rt,rd,memOut,aluOut,stage,clock);
    initial begin
       pc = INSTRUCTION_COUNT-1;
       stage = 3'b100;
       count = 0;
    end
    always @ (negedge clock)
        begin
        endl = endProgram;
        if(endProgram != 1)
            begin
                count = count + 1;
                stage = (stage + 1)%5;
                if(stage == 0)
                    begin
                        if(branch == 1 && zero == 0)
                            begin
                                pc = pc-immediate+1;
                                pc = pc % INSTRUCTION_COUNT;
                                // pc = pc - 4;
                                // pc = pc%9;
                            end
                        else
                            pc = (pc + 1)%INSTRUCTION_COUNT;
                    end
            end
        end
endmodule

module mipsTb;
    reg clock;
    reg reset;
    wire endl;
    mipsProcessor mainModule(reset,clock,endl);
    initial begin
        clock = 0;
        reset = 0;
        $dumpfile("mips.vcd");
        $dumpvars(0,mipsTb);
    end
    always 
        begin
            #5 clock = ~clock;
            if(endl == 1)
                $finish;
        end
    always #100 reset = ~reset;
endmodule