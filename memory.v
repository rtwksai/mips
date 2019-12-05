module memory(memWrite,memRead,memaddress,invalue,outvalue,stage,clock);

    input memWrite,memRead,clock;
    input [7:0]memaddress;
    input [31:0]invalue;
    input [2:0]stage;
    output reg [31:0]outvalue;
    // output reg stage4,stage5;
    reg [31:0] Memory[127:0];

    initial begin
        $readmemb("mainMemory.dat",Memory);
    end

    always@(posedge clock)begin
        if(stage == 3) begin
            if(memWrite == 1) begin
                Memory[memaddress]=invalue;
            end
            else if(memRead == 1) begin
                // $display("%d %d",Memory[memaddress],memaddress);
                outvalue=Memory[memaddress];
            end
            // stage4 = 0;
            // stage5 = 1;
        end
    end
endmodule

module tb;
    reg memWrite,memRead,clock;
    reg [7:0]memaddress;
    reg [31:0]invalue;
    reg [2:0]stage;
    wire [31:0]outvalue;
    memory inst(memWrite,memRead,memaddress,invalue,outvalue,stage,clock);
    initial begin
        $dumpfile("check.vcd");
        $dumpvars(0,tb);
        memWrite = 0;
        memRead = 1;
        clock = 1;
        memaddress = 7'b0;
        invalue = 32'b0;
        stage = 3;
        #10;
    end
endmodule