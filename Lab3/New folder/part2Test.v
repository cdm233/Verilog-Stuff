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

//	part2 momentoftruth(SW[3:0], SW[7:4]， 1'b0, LEDR[3:0], LEDR[4]);
	wire [3:0] w4;
	wire w5;
//	part2 plz(SW[3:0], SW[7:4], 1'b0, LEDR[3:0], LEDR[4]);
	part2 plz(SW[3:0], SW[7:4], 1'b0, w4, w5);
	wire [3:0]w6;
	assign w6 = {{3{1'b0}}, w5};
	
	hex_decoder hex0(w4, HEX0[6:0]);
	hex_decoder hex1(w6, HEX1[6:0]);

endmodule 

module part2(a, b, c_in, s, c_out);
	input [3:0] a;
	input [3:0] b;
	input c_in;
	output [3:0] s;
	output c_out;
	
	wire w1, w2, w3;

	FA adder1(a[0], b[0], c_in, s[0], w1);
	FA adder2(a[1], b[1], w1, s[1], w2);
	FA adder3(a[2], b[2], w2, s[2], w3);
	FA adder4(a[3], b[3], w3, s[3], c_out);

endmodule 

module FA(input a, b, c_in, output s, c_out);

	assign s = a ^ b ^ c_in;
	assign c_out = (a & b) | (c_in & a) | (c_in & b);

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