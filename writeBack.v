module writeBack(controlWriteBack,address,value,stage5,stage1,clock);

    input controlWriteBack;
    input [5:0]address;
    input [31:0]value;
    input clock;
    output reg stage1,stage5;
    reg [31:0]registers[31:0];

    initial begin
        $readmemb("registers.dat",registers);
    end

    always@(posedge clock) begin
        if(stage5 == 1) begin
            registers[address]=value;
            $writememb("register.dat",registers);
            stage5 = 0;
            stage1 = 1;
        end
    end

endmodule