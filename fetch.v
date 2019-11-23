//Takes in a 4bit pc_input and returns a 32bit value at pc_input in memory
module fetch(pc_input, start, pc_output, stage1, stage2, clock);

input [3:0]pc_input;
input start,clock;
output reg[31:0]pc_output;
output reg stage2,stage1;
reg [31:0]instruction[8:0];

initial begin
    $readmemb("fact.dat", instruction);
end

always @(posedge clock)
begin
    if(start == 1 || stage1 == 1) begin
    pc_output = instruction[pc_input];
    stage1 = 0;
    stage2 = 1;
    end
    //$display("Memory [%0d] = %b", pc_input, pc_output);
end
endmodule

// module fetch_tb;
//     reg [3:0]pc_input;
//     reg start;
//     reg stage5;
//     wire [31:0]pc_output;
//     wire stage1;

//     fetch uut(pc_input, start, stage5, pc_output, stage1);
//     initial begin
//         pc_input = 0001; start = 1; stage5 = 0;
//     end
// endmodule