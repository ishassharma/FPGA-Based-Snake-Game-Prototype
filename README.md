# FPGA-Based Snake Game Prototype
Built a prototype that implements the basic functionality of the Snake arcade game using the DE1-SoC FPGA and a VGA Monitor interface.

## Keywords for Technologies/hardware used:
Verilog/VHDL, Embedded C, VGA Monitor, SoC, Nios II, Sram, SDram, PLL, Qsys, ARM Prosessor, Libero, Quartus Prime

## Block Diagram
![image](https://github.com/ishassharma/FPGA-Based-Snake-Game-Prototype/assets/75325587/baa13cc1-c108-45a4-8f8c-68a6095f3887)

## Game Logic
The program operates in a while(1) loop. Snake body position tracked in an array. First checks for collision with food. Loops through the playing field, coloring blocks based on the block’s status (snake, food, background). Checks for head/body collision updates snake body. Runs on with a for loop delay to provide pacing and check for user input.

## Demo Video
