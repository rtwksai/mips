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
                outvalue=Memory[memaddress];
            end
            // stage4 = 0;
            // stage5 = 1;
        end
    end
endmodule