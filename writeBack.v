module writeBack(regWrite,regDest,address1,address2,value,stage5,stage1,clock);

    input regWrite,regDest;
    input [5:0]address1,address2;
    input [31:0]value;
    input clock;
    output reg stage1,stage5;
    reg [31:0]registers[31:0];

    initial begin
        $readmemb("registers.dat",registers);
    end

    always@(posedge clock) begin
        if(stage5 == 1) begin
            if(regDest == 0) begin
                registers[address1]=value;
                $writememb("register.dat",registers);
            end
            else if(regDest == 1) begin 
                registers[address2]=value;
                $writememb("register.dat",registers);
            end
            stage5 = 0;
            stage1 = 1;
        end
    end

endmodule