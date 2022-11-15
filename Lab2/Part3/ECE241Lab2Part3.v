`timescale 1ns / 1ps
//`default_nettype none

// main module is used for fake fpga testing
module main	(
	input wire CLOCK_50,            //On Board 50 MHz
	input wire [9:0] SW,            // On board Switches
	input wire [3:0] KEY,           // On board push buttons
	output wire [6:0] HEX0,         // HEX displays
	output wire [6:0] HEX1,         
	output wire [6:0] HEX2,         
	output wire [6:0] HEX3,         
	output wire [6:0] HEX4,         
	output wire [6:0] HEX5,         
	output wire [9:0] LEDR,         // LEDs
	output wire [7:0] x,            // VGA pixel coordinates
	output wire [6:0] y,
	output wire [2:0] colour,       // VGA pixel colour (0-7)
	output wire plot,               // Pixel drawn when this is pulsed
	output wire vga_resetn          // VGA resets to black when this is pulsed (NOT CURRENTLY AVAILABLE)
);

	hex_decoder momentoftruth(SW[3:0], HEX0[6:0]);

endmodule 

module hex_decoder(input [3:0]c, output [6:0]display);

	assign display[0] = !((!c[0] | c[1] | c[2] | c[3]) & (c[0] | c[1] | !c[2] | c[3]) & (!c[0] | !c[1] | c[2] | !c[3]) & (!c[0] | c[1] | !c[2] | !c[3]));
	assign display[1] = !((!c[0] | c[1] | !c[2] | c[3]) & (c[0] | !c[1] | !c[2] | c[3]) & (!c[0] | !c[1] | c[2] | !c[3]) & (c[0] | c[1] | !c[2] | !c[3]) & (c[0] | !c[1] | !c[2] | !c[3]) & (!c[0] | !c[1] | !c[2] | !c[3]));
	assign display[2] = !((c[0] | !c[1] | c[2] | c[3]) & (c[0] | c[1] | !c[2] | !c[3]) & (c[0] | !c[1] | !c[2] | !c[3]) & (!c[0] | !c[1] | !c[2] | !c[3]));
	assign display[3] = !((!c[0] | c[1] | c[2] | c[3]) & (c[0] | c[1] | !c[2] | c[3]) & (!c[0] | !c[1] | !c[2] | c[3]) & (c[0] | !c[1] | c[2] | !c[3]) & (!c[0] | !c[1] | !c[2] | !c[3]));
	assign display[4] = !((!c[0] | c[1] | c[2] | c[3]) & (!c[0] | !c[1] | c[2] | c[3]) & (c[0] | c[1] | !c[2] | c[3]) & (!c[0] | c[1] | !c[2] | c[3]) & (!c[0] | !c[1] | !c[2] | c[3]) & (!c[0] | c[1] | c[2] | !c[3]));
	assign display[5] = !((!c[0] | c[1] | c[2] | c[3]) & (c[0] | !c[1] | c[2] | c[3]) & (!c[0] | !c[1] | c[2] | c[3]) & (!c[0] | !c[1] | !c[2] | c[3]) & (!c[0] | c[1] | !c[2] | !c[3]));
	assign display[6] = !((c[0] | c[1] | c[2] | c[3]) & (!c[0] | c[1] | c[2] | c[3]) & (!c[0] | !c[1] | !c[2] | c[3]) & (c[0] | c[1] | !c[2] | !c[3]));
	
endmodule 