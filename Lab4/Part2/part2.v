module part2(Clock, Reset_b, Data, Function, ALUout);
	input Clock, Reset_b;
	input [2:0] Function;
	input [3:0] Data;
	output reg [7:0]ALUout;
	
	wire [4:0] RCA_result;
	wire [3:0] Data_B;
	
	wire [3:0] Adder_S;
	wire Adder_C; 
	
	assign {Adder_C, Adder_S} = Data + Data_B;
	
	wire [7:0] tempQ;
	
	reg8_bits reg1(ALUout, Clock, tempQ, Reset_b);
	assign Data_B = tempQ[3:0];

	RCA ripple1(Data, Data_B, 1'b0, RCA_result[3:0], RCA_result[4]);
	
	always @(Clock)
	begin
		case(Function)
			3'b000: ALUout = {3'b0, RCA_result};
			3'b001: ALUout = {3'b0, {Adder_C, Adder_S}};
			3'b010: ALUout = {{4{Data_B[3]}}, Data_B};
			3'b011: ALUout = (Data || Data_B) ? 8'b1 : 8'b0;
			3'b100: ALUout = (Data == 8'b11111111 && Data_B == 8'b11111111) ? 8'b1 : 8'b0;
			3'b101: ALUout = Data_B << Data;
			3'b110: ALUout = Data * Data_B;
			3'b111: ALUout = tempQ;
			default:ALUout = 8'b0;
		endcase
	end
endmodule 


module reg8_bits(d, clk, q, reset);

	input [7:0]d;
	input clk, reset;
	output reg [7:0] q;
	
	always @(posedge clk)
		begin
			if(reset == 1'b0)
				q <= 0;
			else
				q <= d;
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
	assign c_out = (a & b) | (c_in & a) | (c_in & b);

endmodule 