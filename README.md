# FPGA-Based Snake Game Prototype
Built a prototype that implements the basic functionality of the Snake arcade game using the DE1-SoC FPGA and a VGA Monitor interface.The player character can be controlled using the four pushbuttons on the DE1-SoC. Collecting food will cause the player character to grow in length. Colliding with the game zone boundaries or with the snake body will cause the player to lose and the game to be reset. The Nios II and VGA controller system was successfully implemented, although largely with Altera University Program IP due to difficulties the team could not overcome in time when attempting to design their own Qsys system. The game logic was successfully programmed in C on the Nios II soft processor via the Nios II Software Build Tools for Eclipse.

## Keywords for Technologies/hardware used:
Verilog/VHDL, Embedded C, VGA Monitor, SoC, Nios II, Sram, SDram, PLL, Qsys, ARM Prosessor, Libero, Quartus Prime

## Block Diagram
![image](https://github.com/ishassharma/FPGA-Based-Snake-Game-Prototype/assets/75325587/baa13cc1-c108-45a4-8f8c-68a6095f3887)

## Game Logic
The program operates in a while(1) loop. Snake body position tracked in an array. First checks for collision with food. Loops through the playing field, coloring blocks based on the block’s status (snake, food, background). Checks for head/body collision updates snake body. Runs on with a for loop delay to provide pacing and check for user input.

## Demo Video
https://drive.google.com/file/d/1i_MlsEu43FvYVYANoCkrWDieifXEpQuv/view?usp=sharing
