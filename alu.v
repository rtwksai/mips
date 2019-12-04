module alu(read_data1, read_data2, alu_funct, alu_op, sign_extend, ALU_Src, ZERO, result,stage,clock);

    // A is the ALU's first input
    // B is the ALU's second input


    input [31:0]read_data1;
    input [31:0]read_data2;
    input [5:0]alu_funct;
    input [1:0]alu_op;
    input [31:0]sign_extend;
    input [2:0] stage;
    input ALU_Src;
    input clock;
    // output reg stage3,stage4;
    
    reg [31:0]B;
    output reg ZERO;
    output reg [31:0]result;

    always@(posedge clock)
    begin
        if(stage == 2)
        begin
            if(ALU_Src == 1)
            begin
                B = sign_extend;
            end
            else if(ALU_Src == 0)
            begin
                B = read_data2;
            end

            //R-Type Instructions
            if(alu_op == 2'b00)
            begin
                //AND
                if(alu_funct == 6'b100100)
                begin
                    result = read_data1&B;
                end
                //OR
                else if(alu_funct == 6'b100101)
                begin
                    result = read_data1|B;
                end
                //ADD
                else if(alu_funct == 6'b100000)
                begin
                    result = read_data1+B;
                end
                //SUB
                else if(alu_funct == 6'b100010)
                begin
                    result = read_data1-B;
                end
                //MUL
                else if(alu_funct == 6'b011000)
                begin
                    result = read_data1*B;
                end
                //DIV
                else if(alu_funct == 6'b011010)
                begin
                    result = read_data1/B;
                end

            end
            //ADDI, LW, SW
            else if(alu_op == 2'b11)
            begin 
                result = read_data1+B;
            end
            //BEQ, BNE
            else if(alu_op == 2'b01)
            begin
                result = read_data1-B;
            end
            $display("the result is : %0b", result);
        end
    end    
endmodule

// Testbench for ALU

`timescale 10ns/1ps
module tb_ALU;

    reg [31:0]read_data1;
    reg [31:0]read_data2;
    reg [5:0]alu_funct;
    reg [1:0]alu_op;
    reg [2:0]stage;
    reg ALU_Src;
    reg [31:0]sign_extend;
    reg clock;
    wire ZERO;
    wire [31:0]result;

    alu uut(
        .read_data1(read_data1),
        .read_data2(read_data2),
        .alu_funct(alu_funct),
        .ZERO(ZERO),
        .result(result),
        .alu_op(alu_op),
        .sign_extend(sign_extend),
        .ALU_Src(ALU_Src),
        .stage(stage),
        .clock(clock)
    );

    initial 
    begin
    read_data1 = 30;
    read_data2 = 25;
    alu_funct = 6'b100000;
    alu_op = 2'b10;
    ALU_Src = 1;
    sign_extend = 64;
    // #5;
    // $display("The value of result is %0d", result);
    end
endmodule