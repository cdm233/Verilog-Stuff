module part1(d,q,clk);

	input d, clk;
	output reg q;
	
	always@(*)
		if(clk == 1)
			q = d;

endmodule 


// parallel 3 bits shift register
//module part1(w, clk, q, d, reset, load); 
//
//	input w,clk, reset, load;
//	input [2:0] d;
//	output reg [2:0] q;
//	
//	always@(posedge clk)
//		begin
//			if(!reset)
//				q <= 0;
//			else if(load == 0)
//				q <= d;
//			else
//				begin
//					q[2] <= w;
//					q[1] <= q[2];
//					q[0] <= q[1];
//				end
//		end
//endmodule 