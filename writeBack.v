module writeBack(regWrite,memToReg,regDest,address1,address2,value,aluOut,stage,clock);

    input memToReg,regDest,regWrite;
    input [4:0]address1,address2;
    input [2:0]stage;
    input [31:0]value,aluOut;
    input clock;
    // output reg stage1,stage5;
    reg [31:0]registers[31:0];
    initial begin
        $readmemb("registers.dat",registers);
    end
    always@(posedge clock) begin
        if(stage == 4) begin
            if(regWrite == 1) begin
                if(memToReg == 1 && regDest == 0) begin
                    registers[address1]=value;
                    $writememb("registers.dat",registers);
                end
                else if(memToReg == 0 && regDest == 0) begin 
                    registers[address1]=aluOut;
                    $writememb("registers.dat",registers);
                end
                else if(memToReg == 1 && regDest == 1) begin
                    registers[address2]=value;
                    $writememb("registers.dat",registers);
                end
                else if(memToReg == 0 && regDest == 1) begin
                    registers[address2]=aluOut;
                    $writememb("registers.dat",registers);
                end
            end
        end
    end

endmodule