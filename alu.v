module alu(A, B, alu_cs, ZERO, result);
    
    input [31:0]A;
    input [31:0]B;
    input [5:0]alu_cs;

    output reg ZERO;
    output reg [31:0]result;

    always@(A or B or alu_cs)
    begin
        if(alu_cs == 6'b100100)
        begin
            result = A&B;
        end
        else if(alu_cs == 6'b100101)
        begin
            result = A|B;
        end
        else if(alu_cs == 6'b100000)
        begin
            result = A+B;
        end
        else if(alu_cs == 6'b100010)
        begin
            result = A-B;
        end
        else if(alu_cs == 6'b011000)
        begin
            result = A*B;
        end
    end
endmodule

// Testbench for ALU

`timescale 10ns/1ps
module tb_ALU;

    reg [31:0]A;
    reg [31:0]B;
    reg [5:0]alu_cs;

    wire ZERO;
    wire [31:0]result;

    alu uut(
        .A(A),
        .B(B),
        .alu_cs(alu_cs),
        .ZERO(ZERO),
        .result(result)
    );

    initial 
    begin
    $dumpfile("alu_out.vcd");
    $dumpvars(0, tb_ALU);
    A = 30;
    B = 25;
    alu_cs = 6'b011000;
    end
    
    always@(result)
    begin
        $display("the result is : %0d", result);
    end
endmodule