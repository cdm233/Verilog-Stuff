module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);

	input clock, reset, ParallelLoadn, RotateRight, ASRight;
	input [7:0] Data_IN;
	output reg [7:0] Q;
	
	always @(posedge clock) begin
	
		if(reset)
			Q <= 0;
		else if(!ParallelLoadn)
			Q <= Data_IN;
		else if(ParallelLoadn && RotateRight && !ASRight) begin
			Q[0] <= Q[1];
			Q[1] <= Q[2];
			Q[2] <= Q[3];
			Q[3] <= Q[4];
			Q[4] <= Q[5];
			Q[5] <= Q[6];
			Q[6] <= Q[7];
			Q[7] <= Q[0];
		end else if(ParallelLoadn && RotateRight && ASRight) begin
			Q[0] <= Q[1];
			Q[1] <= Q[2];
			Q[2] <= Q[3];
			Q[3] <= Q[4];
			Q[4] <= Q[5];
			Q[5] <= Q[6];
			Q[6] <= Q[7];
		end else if(ParallelLoadn && !RotateRight) begin
			Q[1] <= Q[0];
			Q[2] <= Q[1];
			Q[3] <= Q[2];
			Q[4] <= Q[3];
			Q[5] <= Q[4];
			Q[6] <= Q[5];
			Q[7] <= Q[6];
			Q[0] <= Q[7];
		end	
	end	
endmodule 