module part3(ClockIn, Resetn, Start, Letter, DotDashOut);

	input ClockIn, Resetn, Start;
	input [2:0] Letter;
	output DotDashOut;
	
	wire dividedClock;
	wire [31:0] load; 
	
	reg [11:0] temp;
	wire [11:0] tempOut = temp;
	
	reg tempp;


	rateDivider divider(ClockIn, Resetn, 32'b111110100, load, dividedClock); //111110100
	
	assign DotDashOut = tempp;
	
	always @(posedge ClockIn) begin 
		if(Start == 1'b0 && Resetn == 1'b0) begin
			temp <= 0;
		end else if(Start == 1'b0 && Resetn == 1'b1 && dividedClock == 1'b1) begin
			if(temp != 12'b0) begin 
				temp[11] <= temp[0];
				temp[10] <= temp[11];
				temp[9] <= temp[10];
				temp[8] <= temp[9];
				temp[7] <= temp[8];
				temp[6] <= temp[7];
				temp[5] <= temp[6];
				temp[4] <= temp[5];
				temp[3] <= temp[4];
				temp[2] <= temp[3];
				temp[1] <= temp[2];
				temp[0] <= temp[1];
				tempp <= temp[0];
			end
		end else if (Start == 1'b1 && Resetn == 1'b1) begin
			case (Letter) 
				
				3'b000: temp = 12'b011101;			// A
				3'b001: temp = 12'b0101010111;	// B
				3'b010: temp = 12'b010111010111; // C
				3'b011: temp = 12'b01010111;		// D
				3'b100: temp = 12'b01;				// E
				3'b101: temp = 12'b0101110101;  	// F
				3'b110: temp = 12'b0101110111;	// G
				3'b111: temp = 12'b01010101;		// H
				
			endcase
		end
	
	end

endmodule 


module rateDivider(clock_in, reset_n, d, q, clock_out);

	input clock_in, reset_n;
	input [31:0] d;
	output reg [31:0] q;
	output clock_out;
	
	always @(posedge clock_in) begin
	
		if(reset_n == 1'b0) 
			q <= d / 2 - 1;
		else if(q == 32'b0) 
			q <= d / 2 - 1;
		else 
			q <= q - 1;
	end
	assign clock_out = (q == 32'b0) ? 1'b1 : 1'b0;
endmodule 