module part2(ClockIn, Reset, Speed, CounterValue);

	input ClockIn, Reset;
	input [1:0] Speed;
	output [3:0] CounterValue;
	
	wire [31:0] load;
	wire dividedClock;
	
	RateDivider divider(ClockIn, Speed, Reset, 32'b111110100, load, dividedClock); //10111110101111000010000000 // 111110100
	
	DisplayCounter counter(dividedClock, 1'b1, CounterValue, Reset);
	
endmodule 


module RateDivider(clock_in, speed, reset_n, d, q, clock_out);

	input clock_in, reset_n;
	input [1:0] speed;
	input [31:0] d;
	output reg [31:0] q;
	output reg clock_out;
	
	always @(posedge clock_in) begin
		if(reset_n == 1'b1) begin
			if (speed == 2'b00) 
				q <= 0;
				clock_out = clock_in;
			if (speed == 2'b01) // 1 hz
				q <= d;
			else if (speed == 2'b10)// 0.5 hz
				q <= 2 * d;
			else if (speed == 2'b11)// 0.25 hz
				q <= 4 * d;
			
		end else begin
		
			if(speed == 2'b00 && q == 32'b0) begin // full speed
			
				clock_out = clock_in;
			
			end else begin
				if(q == 32'b0) begin   // counter reaches 0
					if (speed == 2'b01)		// 1 hz
						q <= d;
					else if (speed == 2'b10)// 0.5 hz
						q <= 2 * d;
					else if (speed == 2'b11)// 0.25 hz
						q <= 4 * d;
				end else 
					q <= q - 1;	
				
				clock_out = (q == 32'b0) ? 1'b1 : 1'b0;
			end
		end
	end
	
	always @(negedge clock_in) begin
	
		if(speed == 2'b00 && q == 32'b0)
			clock_out = clock_in;
	end

endmodule 

module DisplayCounter(clock, enable, value, clear); // DisplayCounter

	input clock, enable, clear;
	output reg [3:0] value;
	
	always @(posedge clock) begin
	
		if(clear == 1'b1)
			value <= 4'b0;
		else if(value == 4'b1111)
			value <= 4'b0;
		else if(enable)
			value <= value + 1;
			
	end
endmodule 