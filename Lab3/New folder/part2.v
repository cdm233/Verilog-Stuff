module part2(a, b, c_in, s, c_out);
	input [3:0] a;
	input [3:0] b;
	input c_in;
	output [3:0] s;
	output [3:0] c_out;


	FA adder1(a[0], b[0], c_in, s[0], c_out[0]);
	FA adder2(a[1], b[1], c_out[0], s[1], c_out[1]);
	FA adder3(a[2], b[2], c_out[1], s[2], c_out[2]);
	FA adder4(a[3], b[3], c_out[2], s[3], c_out[3]);

endmodule 

module FA(input a, b, c_in, output s, c_out);

	assign s = a ^ b ^ c_in;
	assign c_out = (a & b) | (c_in & a) | (c_in & b);

endmodule 