module part3(Clock, Resetn, Go, Divisor, Dividend, Quotient, Remainder);

	parameter WIDTH = 4;
	input Clock, Resetn,Go;
	output reg [WIDTH-1:0] Quotient, Remainder;
   input [WIDTH-1:0] Divisor;
   input [WIDTH-1:0] Dividend;

	always @(posedge Clock) begin
	
		if(Resetn == 0) begin
			Quotient <= 0;
			Remainder <= 0;
			
		end else if(!Go) begin
			Quotient <= Dividend / Divisor;
			Remainder <= Dividend % Divisor;
		end
	
	end
endmodule 