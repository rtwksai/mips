module alu(A, B, alu_funct, alu_op, ZERO, result);
    
    input [31:0]A;
    input [31:0]B;
    input [5:0]alu_funct;
    input [1:0]alu_op;

    output reg ZERO;
    output reg [31:0]result;

    always@(*)
    begin
        if(alu_op == 2'b10 || alu_op == 2'b11)
        begin
            if(alu_funct == 6'b100100)
            begin
                result = A&B;
            end
            else if(alu_funct == 6'b100101)
            begin
                result = A|B;
            end
            else if(alu_funct == 6'b100000)
            begin
                result = A+B;
            end
            else if(alu_funct == 6'b100010)
            begin
                result = A-B;
            end
            else if(alu_funct == 6'b011000)
            begin
                result = A*B;
            end
        end
        else if(alu_op == 2'b00)
        begin 
            result = A+B;
        end
        else if(alu_op == 2'b01)
        begin
            result = A-B;
        end
        // $display("the result is : %0b", result);
    end    
endmodule

// Testbench for ALU

`timescale 10ns/1ps
module tb_ALU;

    reg [31:0]A;
    reg [31:0]B;
    reg [5:0]alu_funct;
    reg [1:0]alu_op;
    wire ZERO;
    wire [31:0]result;

    alu uut(
        .A(A),
        .B(B),
        .alu_funct(alu_funct),
        .ZERO(ZERO),
        .result(result),
        .alu_op(alu_op)
    );

    initial 
    begin
    A = 30;
    B = 25;
    alu_funct = 6'b100000;
    alu_op = 2'b10;
    end
endmodule