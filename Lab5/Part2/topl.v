module main (
 input wire CLOCK_50,            //On Board 50 MHz
 input wire [9:0] SW,            // On board Switches
 input wire [3:0] KEY,           // On board push buttons
 output wire [6:0] HEX0,         // HEX displays
 output wire [6:0] HEX1,         
 output wire [6:0] HEX2,         
 output wire [6:0] HEX3,         
 output wire [6:0] HEX4,         
 output wire [6:0] HEX5,         
 output wire [9:0] LEDR         // LEDs
);    

 //Write code in here!
 part2 u1(CLOCK_50, SW[9], SW[1:0], LEDR[3:0]);
 
endmodule