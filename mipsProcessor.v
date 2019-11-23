`include "fetch.v"
`include "alu.v"
module mipsProcessor();
    reg [3:0] pc;
    reg start;
    wire stage1,stage2,stage3,stage4,stage5;
    wire [31:0]curInstruction;
    fetch module1(pc,start,curInstruction,stage1,stage2);
    initial begin
       pc = 4'b0000;
       start = 1; 
    end
    always@(stage1 or stage2 or stage3 or stage4 or stage5) begin
        #5;
        start = 0;
    end
endmodule