
module part1(Clock, Enable, Clear_b, CounterValue);
	
	input Clock, Enable, Clear_b;
	output [7:0] CounterValue;
	

Tflip tt(Enable, Clear_b, Clock, CounterValue[0]);
Tflip t2(Enable & CounterValue[0], Clear_b, Clock, CounterValue[1]);
Tflip t3(Enable & CounterValue[1] & CounterValue[0], Clear_b, Clock, CounterValue[2]);
Tflip t4(Enable & CounterValue[2] & CounterValue[1] & CounterValue[0], Clear_b, Clock, CounterValue[3]);
Tflip t5(Enable & CounterValue[3] & CounterValue[2] & CounterValue[1] & CounterValue[0], Clear_b, Clock, CounterValue[4]);
Tflip t6(Enable & CounterValue[4] & CounterValue[3] & CounterValue[2] & CounterValue[1] & CounterValue[0], Clear_b, Clock, CounterValue[5]);
Tflip t7(Enable & CounterValue[5] & CounterValue[4] & CounterValue[3] & CounterValue[2] & CounterValue[1] & CounterValue[0], Clear_b, Clock, CounterValue[6]);
Tflip t8(Enable & CounterValue[6] & CounterValue[5] & CounterValue[4] & CounterValue[3] & CounterValue[2] & CounterValue[1] & CounterValue[0], Clear_b, Clock, CounterValue[7]);

endmodule 

module Tflip(input T, reset_b, Clk, output reg Q);

	always @(posedge Clk) begin
	
		if(!reset_b)
			Q <= 1'b0;
		else 
			if(T == 1)
				Q <= !Q;
			else
				Q <= Q;
	
	end

endmodule 