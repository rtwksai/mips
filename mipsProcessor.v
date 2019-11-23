`include "fetch.v"
`include "alu.v"
`include "writeBack.v"
`include "memory.v"
module mipsProcessor();
    reg [3:0] pc;
    reg start,clock;
    wire stage1,stage2,stage3,stage4,stage5; //stages of MIPS processor
    wire memWrite,memRead; // control signals
    wire [7:0] memaddress;
    wire [5:0]address;
    wire [31:0]curInstruction;
    wire [31:0]resvalue;
    fetch module1(pc,start,curInstruction,stage1,stage2,clock);
    memory module4(memWrite,memRead,memaddress,resvalue,resvalue,stage4,stage5,clock);
    writeBack module5(controlWriteBack,address,resvalue,stage5,start1,clock);
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