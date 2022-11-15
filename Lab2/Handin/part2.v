// 7404 hex inverter
module v7404 (pin1, pin3, pin5, pin9, pin11, pin13,
pin2, pin4, pin6, pin8, pin10, pin12);

	input pin1, pin3, pin5, pin13, pin11, pin9;
	output pin2, pin4, pin6, pin12, pin10, pin8;
	
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin12 = ~pin13;
	assign pin10 = ~pin11;
	assign pin8 = ~pin9;

endmodule 

// 7408 quad 2 input AND
module v7408 (pin1, pin3, pin5, pin9, pin11, pin13,
pin2, pin4, pin6, pin8, pin10, pin12);

	input pin1, pin2, pin4, pin5, pin13, pin12, pin10, pin9;
	output pin3, pin6, pin11, pin8;
	
	assign pin3 = pin1 & pin2;
	assign pin6 = pin4 & pin5;
	assign pin8 = pin10 & pin9;
	assign pin11 = pin13 & pin12;

endmodule 

// 7432 quad 2 input OR
module v7432 (pin1, pin3, pin5, pin9, pin11, pin13,
pin2, pin4, pin6, pin8, pin10, pin12);

	input pin1, pin2, pin4, pin5, pin13, pin12, pin10, pin9;
	output pin3, pin6, pin11, pin8;
	
	assign pin3 = pin1 | pin2;
	assign pin6 = pin4 | pin5;
	assign pin8 = pin10 | pin9;
	assign pin11 = pin13 | pin12;

endmodule 

module mux2to1 (x, y, s, m);

	input x, y, s;
	output m;
	
	wire w1, w2, w3;
	
	v7404 v7404c1(.pin1(s), .pin2(w1));
	v7408 v7408c1(.pin1(w1), .pin2(x), .pin3(w2), .pin4(s), .pin5(y), .pin6(w3));
	v7432 v7432c1(.pin1(w2), .pin2(w3), .pin3(m));
	
endmodule 