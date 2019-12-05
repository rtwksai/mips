# mips
Computer Architecture Project
Design a ​ non-pipelined​ MIPS processor which will take as input- the instruction codes for an N factorial program and produces the necessary output. In how many clock cycles does the output of the program appear?

### Implementation

We have created separate modules for fetch, decode, execute, memory and writeback operations.

- Instructions are given in the file _fact.dat_
- Dont forget to add `11111111111111111111111111111111` at the end of the set of instructions
- The value N for which the factorial must be found must be passed in it.
- Changes that you need to make once you gave a specified set of instructions:
    * Change the count of number of instructions in _fetch.v_ line 9 `reg [31:0]instruction[x-1:0];` where x is the number of instructions
    * Similarly change the instructions size in _mipsProcessor.v_ in following code lines `pc = pc % x;` in line 43 and `pc = (pc + 1)%x` in line 48
- Now run the following command `iverilog mipsProcessor.v` (You need to have iverilog and GTKWave installed)
- Then do an `./a.out`
- And find the response to your instruction set in either _registers.dat_ file or _mainMemory.dat_ file (Changes happening depends on the type of instruction you give)
- In our premade _fact.dat_ file our output is visible in _registers.dat_ file in line number 20.
- If you want to see the number of cycles the instruction took head over to GTKWave by running _gtkwave mips.vcd_ and click on `mipsTb -> mainModule`
- Drag and drop `clock` and `curInstruction[31:0]`. You will get an estimate of the number of cycles it is taking.

Thanks
- Kartik Sama
- Soham Joshi
- Sai Rithwik M