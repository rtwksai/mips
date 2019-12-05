//Takes in a 4bit pc_input and returns a 32bit value at pc_input in memory
module fetch(pc_input, pc_output, stage, clock);

input [3:0]pc_input;
input [2:0]stage;
input clock;
output reg[31:0]pc_output;
// output reg stage2,stage1;
reg [31:0]instruction[10:0];

initial begin
    $readmemb("fact.dat", instruction);
end

always @(posedge clock)
begin
    if(stage == 0) begin
    pc_output = instruction[pc_input];
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
//         pc_input = 4'b0111; start = 1; stage5 = 0;
//     end
// endmodule