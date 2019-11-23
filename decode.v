//Takes input from fetch and parses it and assigns appropriate register values

module decode(instruction, opcode, rs, rt, rd, immediate, shamt, funct);
input [31:0]instruction;
output reg[5:0]opcode;
output reg[4:0]rs;
output reg[4:0]rt;
output reg[4:0]rd;
output reg[31:0]immediate;
output reg [4:0]shamt;
output reg [5:0]funct;
// flags and temp variables
integer flagr=0;

initial begin
    rd = 5'b0;
    immediate = 31'b0;
    shamt = 5'b0;
    funct = 6'b0;
end


always @(instruction)
begin 
    opcode = instruction[31:26];
    if(opcode == 6'b000000)
    begin 
        flagr = 1;
        rs = instruction[25:21];
        rt = instruction[20:16];
        rd = instruction[15:11];
        shamt = instruction[10:6];
        funct = instruction[5:0];
    end
    else
    begin
        flagr = 0;
        rs = instruction[25:21];
        rt = instruction[20:16];
        immediate = immediate + instruction[15:0];  // can be error
    end
    $display("%b", instruction);
    $display("%b, %b, %b, %b, %b, %b, %b", opcode, rs, rt, rd, shamt, funct, immediate);
end
endmodule

module dc_tb;
    reg [31:0]instruction;
    wire [5:0]opcode;
    wire [4:0]rs;
    wire [4:0]rt;
    wire [4:0]rd;
    wire [31:0]immediate;
    wire [4:0]shamt;
    wire [5:0]funct;

    decode uut(instruction, opcode, rs, rt, rd, immediate, shamt, funct);
    initial begin
        instruction = 32'b10001110000100100000000000000000;
    end
endmodule