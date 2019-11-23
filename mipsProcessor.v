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
    wire memWrite,memRead; // control signals
    wire [7:0] memaddress;
    wire [5:0] regaddress;
    wire [31:0]curInstruction;
    wire [31:0]resvalue;
    fetch module1(pc,start,curInstruction,stage1,stage2,clock);
    memory module4(memWrite,memRead,memaddress,resvalue,resvalue,stage4,stage5,clock);
    writeBack module5(controlWriteBack,regaddress,resvalue,stage5,start1,clock);
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