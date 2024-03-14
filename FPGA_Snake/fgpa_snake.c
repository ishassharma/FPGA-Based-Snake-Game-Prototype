#include <stdbool.h>
#include <stdlib.h> // For rand()

#define BUTTON_ADR ((volatile long *)0xFF200050)

/*	References:
 * 	 DE1-SoC User Manual
 * 	 	http://www.ee.ic.ac.uk/pcheung/teaching/ee2_digital/de1-soc_user_manual.pdf
 * 	 Altera University Program
 * 	 	https://ftp.intel.com/Public/Pub/fpgaup/pub/Intel_Material/18.1/Computer_Systems/DE1-SoC/DE1-SoC_Computer_NiosII.pdf
 * 	 ADV7123 datasheet
 * 	 	https://www.analog.com/media/en/technical-documentation/data-sheets/adv7123.pdf
 *	 Univ. of Toronto VGA Example
 *	 	https://www-ug.eecg.utoronto.ca/desl/nios_devices_SoC/ARM/dev_vga.html
 */

/* 	0x0800_0000 is VGA base address. X cord is 9 bits 1-10
 *	and y cord is 8 bits 11-18. Color is a 16-bit RGB value */
void write_pixel(int x, int y, short color) {
  volatile short *vga_addr = (volatile short *)(0x08000000 + (y << 10) + (x << 1));
  *vga_addr = color;
}

/* Write a square of pixels of specified size */
void write_block(int x, int y, int size, short color) {
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      volatile short *vga_addr = (volatile short *)(0x08000000 + ((y + i) << 10) + ((x + j) << 1));
      *vga_addr = color;
    }
  }
}

/* Set screen to black */
void clear_screen() {
  int x, y;
  for (x = 0; x < 320; x++) {
    for (y = 0; y < 240; y++) {
      write_pixel(x, y, 0);
    }
  }
}

/* 0x09000_0000 is base character buffer address. X coord is
 * 7 bits 0-6. Y coord is 6 bits 7-13. Then use one byte character
 * ASCII code to print it
 */
void write_char(int x, int y, char c) {
  // VGA character buffer
  volatile char *character_buffer = (char *)(0x09000000 + (y << 7) + x);
  *character_buffer = c;
}

#define GRID_SIZE 20
#define BLOCK_SIZE 10
#define SPACING 1
#define SPACING_LEFT 50
#define SPACING_RIGHT 20

typedef struct {
    int x;
    int y;
} BodySegment;

int main() {
    clear_screen();

    char *hw = "Welcome to FPGA Snake!";
    int x_char = 17;
    while (*hw) {
        write_char(x_char, 2, *hw);
        x_char++;
        hw++;
    }

    int food_x = 15;
    int food_y = 10;
    int color;
    int player_x_direction = 1;
    int player_y_direction = 0;
    bool is_snake = false;
    bool is_food = false;
    bool new_segment_delay = false;

    BodySegment snake_body[32];
    int snake_length = 1;
    snake_body[0].x = 10;
    snake_body[0].y = 10;

    while (1) {

        is_snake = false;
        is_food = false;

        // Check if snake head reached food
        if (snake_body[0].x == food_x && snake_body[0].y == food_y) {
            is_food = true;
            // Re-spawn food at a random coordinate
            food_x = rand() % GRID_SIZE;
            food_y = rand() % GRID_SIZE;
            // Increase length
            if (snake_length < GRID_SIZE * GRID_SIZE) {
                // Shift existing segments
                for (int i = snake_length; i > 0; i--) {
                    snake_body[i] = snake_body[i - 1];
                }
                // Add new segment behind the head
                snake_body[0].x = snake_body[1].x;
                snake_body[0].y = snake_body[1].y;
                snake_length++;
                new_segment_delay = true;

            }
        }
        // Loop through playing field. Determine how to color each block
        for (int x = 0; x < GRID_SIZE; x++) {
            for (int y = 0; y < GRID_SIZE; y++) {
                is_snake = false;
                is_food = false;
                int i = x * (BLOCK_SIZE + SPACING);
                int j = y * (BLOCK_SIZE + SPACING);

                // Check if current block is part of snake
                for (int k = 0; k < snake_length; k++) {
                    if (x == snake_body[k].x && y == snake_body[k].y) {
                        is_snake = true;
                        break;
                    }
                }
                // Check if current block is food
                is_food = (x == food_x && y == food_y);

                if (is_snake)
                    color = 0x07e0; // Snake color - green
                else if (is_food)
                    color = 0xf800; // Food color - red
                else
                    color = 0x00F8; // Background block color - blue

                write_block(i + SPACING_LEFT, j + SPACING_RIGHT, BLOCK_SIZE, color);
            }
        }

        // Check if the player has left the grid
        if (snake_body[0].x < 0 || snake_body[0].x >= GRID_SIZE ||
            snake_body[0].y < 0 || snake_body[0].y >= GRID_SIZE) {
            // Reset game
            snake_body[0].x = 10;
            snake_body[0].y = 10;
            snake_length = 1;
        }

        // Update the rest of the snake's body
        if (new_segment_delay == false)
        {
        	for (int i = snake_length - 1; i > 0; i--) {
        	    // Reset game if head has collided with body
        		if (snake_body[i].x == snake_body[0].x && snake_body[i].y == snake_body[0].y)
        	    {
                    snake_body[0].x = 10;
                    snake_body[0].y = 10;
                    snake_length = 1;
                    break;
        	    }
        		// Otherwise move snake forward
        		snake_body[i].x = snake_body[i - 1].x;
        	    snake_body[i].y = snake_body[i - 1].y;
        	}
        }
        else
        {
        	new_segment_delay = false;
        }
        // Increment the snake's head
        snake_body[0].x = snake_body[0].x + player_x_direction;
        snake_body[0].y = snake_body[0].y + player_y_direction;

        // Delay to slow game down. Accept input while waiting
        for (int i = 0; i < 100000; i++) {
        	// Based on the player button press, change the direction of the snake (with no double backing allowed)
			if ((*BUTTON_ADR & 1) && player_x_direction == 0) {
			  player_x_direction = 1;
			  player_y_direction = 0;
			} else if ((*BUTTON_ADR & 2) && player_x_direction == 0) {
			  player_x_direction = -1;
			  player_y_direction = 0;
			} else if ((*BUTTON_ADR & 4) && player_y_direction == 0) {
			  player_x_direction = 0;
			  player_y_direction = +1;
			} else if ((*BUTTON_ADR & 8) && player_y_direction == 0) {
			  player_x_direction = 0;
			  player_y_direction = -1;
			}
        }
    }

    return 0;
}