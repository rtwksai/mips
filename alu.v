module alu(A, read_data2, alu_funct, alu_op, sign_extend, ALU_Src, ZERO, result);

    // A is the ALU's first input
    // B is the ALU's second input


    input [31:0]A;
    input [31:0]read_data2;
    input [5:0]alu_funct;
    input [1:0]alu_op;
    input [31:0]sign_extend;
    input ALU_Src;
    
    reg [31:0]B;
    output reg ZERO;
    output reg [31:0]result;

    always@(*)
    begin
        if(ALU_Src == 1)
        begin
            B = sign_extend;
        end
        else if(ALU_Src == 0)
        begin
            B = read_data2;
        end

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

// `timescale 10ns/1ps
// module tb_ALU;

//     reg [31:0]A;
//     reg [31:0]read_data2;
//     reg [5:0]alu_funct;
//     reg [1:0]alu_op;
//     reg ALU_Src;
//     reg [31:0]sign_extend;
//     wire ZERO;
//     wire [31:0]result;

//     alu uut(
//         .A(A),
//         .read_data2(read_data2),
//         .alu_funct(alu_funct),
//         .ZERO(ZERO),
//         .result(result),
//         .alu_op(alu_op),
//         .sign_extend(sign_extend),
//         .ALU_Src(ALU_Src)
//     );

//     initial 
//     begin
//     A = 30;
//     read_data2 = 25;
//     alu_funct = 6'b100000;
//     alu_op = 2'b10;
//     ALU_Src = 1;
//     sign_extend = 64;
//     // #5;
//     // $display("The value of result is %0d", result);
//     end
// endmodule