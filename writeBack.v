module writeBack(regWrite,regDest,address1,address2,value,stage,clock);

    input regWrite,regDest;
    input [5:0]address1,address2;
    input [2:0]stage;
    input [31:0]value;
    input clock;
    // output reg stage1,stage5;
    reg [31:0]registers[31:0];

    always@(posedge clock) begin
        if(stage == 4) begin
            $readmemb("registers.dat",registers);
            if(regDest == 0) begin
                registers[address1]=value;
                $writememb("register.dat",registers);
            end
            else if(regDest == 1) begin 
                registers[address2]=value;
                $writememb("register.dat",registers);
            end
        end
    end

endmodule