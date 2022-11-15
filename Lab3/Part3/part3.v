module part3(A, B, Function, ALUout);
	input [3 : 0] A;
	input [3 : 0] B;
	input [2:0] Function;
	output reg [7 : 0] ALUout;
	
	
	wire [4:0] adderResult;
	wire temp;
	assign temp = 1'b0;
	
	// Ripple carry adder
	RCA RCA1(A, B, 1'b0, adderResult[3:0], adderResult[4]);
	
	wire Asub = {1'b0, A};
	wire Bsub = {1'b0, B};

	always@(*) begin
		case (Function)
			3'b000 : ALUout = {{3'b0}, adderResult};
			3'b001 : ALUout = {{3'b0}, {Asub + Bsub}};
			3'b010 : ALUout = {{4{B[3]}}, B};
			3'b011 : ALUout = (A || B) ? 8'b00000001 : 8'b00000000;
			3'b100 : ALUout = (A == 4'b1111 && B == 4'b1111) ? 8'b00000001 : 8'b00000000;
			3'b101 : ALUout = {A, B};
			default: ALUout = 8'b00000000;
		endcase 
	end

endmodule 

module RCA(a, b, c_in, s, c_out);
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
	assign c_out = a & b | c_in & a | c_in & b;

endmodule 