//
// This is the template for Part 2 of Lab 7.
//
// Paul Chow
// November 2021
//

module part2(iResetn,iPlotBox,iBlack,iColour,iLoadX,iXY_Coord,iClock,oX,oY,oColour,oPlot);
   parameter X_SCREEN_PIXELS = 8'd160;
   parameter Y_SCREEN_PIXELS = 7'd120;
   
   input wire iResetn, iPlotBox, iBlack, iLoadX;
   input wire [2:0] iColour;
   input wire [6:0] iXY_Coord;
   input wire 	    iClock;
   
	output wire [7:0] oX;         // VGA pixel coordinates
   output wire [6:0] oY;
   
   output wire [2:0] oColour;     // VGA pixel colour (0-7)
   output wire 	     oPlot;       // Pixel draw enable

   //
   // Your code goes here
   //
	
	
	wire wLoadx, wLoady, wBlack, wPlot, wLdc;
	
	control c0(iClock, iResetn, iLoadX, iPlotBox, iBlack, wLoadx, wLoady, wBlack, wPlot, wLdc);
   dataPath d0(iClock, iResetn, wLoadx, wLoady, wBlack, wPlot, wLdc, iXY_Coord, iColour, oX, oY, oColour, oPlot);
	
endmodule // part2

module control(input clock, resetn, iLoadx, iPlotBox, iBlack, output reg ioLoadx, ioLoady, ioBlack, ioPlotBox, ild_c);
	localparam  S_load_x_wait = 3'd0,
					S_load_x 	  = 3'd1,
					S_load_yc 	  = 3'd2,
					S_negedge_wait= 3'd3,
					S_plot 		  = 3'd4;
	
	reg [2:0] cs, ns;
	
	// state table
	always @(*) begin
		case (cs)
			S_load_x_wait: 	ns = iLoadx 	? S_load_x			: S_load_x_wait;
			S_load_x: 			ns = iLoadx 	? S_load_x 			: S_load_yc;
			S_load_yc: 			ns = iPlotBox 	? S_negedge_wait	: S_load_yc;
			S_negedge_wait: 	ns = iPlotBox 	? S_negedge_wait	: S_plot;
			S_plot: 				ns = iPlotBox 	? S_load_x_wait 	: S_plot;
			default: ns = S_load_x_wait;
		endcase
	end
	
	
	// output logic
	always @(*) begin
	
		ioPlotBox 	= 0;
		ild_c 		= 0;
		ioLoadx 		= 0;
		ioLoady 		= 0;
		
		case (cs)
			S_load_x: 	begin 
				ioLoadx 	= 1'b1;
			end
			S_load_yc: 	begin
				ild_c 	= 1'b1;
				ioLoady 	= 1'b1;
			end
			S_plot:		begin
				ioPlotBox= 1'b1;
			end
			
			default: ;
		endcase
		ioBlack = iBlack;
	
	end
	
	// current state reg
	always@(posedge clock) begin
		if(!resetn)
			cs <= S_load_x_wait;
		else
			cs <= ns;
	end // state_FFS

endmodule

// input control logic from FMS: ioLoadx, ioLoady, ioBlack, ioPlotBox, ild_c
// output values are: outputx, outputy, outputcolour, outputplot
module dataPath(input iClock, resetn, iLoadx, iLoady, iBlack, iPlotBox, ld_c, input [6:0] ixy_coord, input [2:0] iColour, output reg [7:0] oX, output reg [6:0] oY, output reg [2:0] oColour, output reg oPlot);
	
	reg [7:0] reg_x, reg_y; // reg for x and y coordinate
	reg [2:0] reg_c, reg_b; // reg for colour and black screen
	
	reg [3:0] reg_counter_4bits;
	reg [5:0] reg_counter_6bits;
	
	// registers: reg_x reg_y reg_c reg_b
	always @(posedge iClock) begin
		if(!resetn) begin
			reg_x <= 8'b0;
			reg_y <= 8'b0;
			reg_c <= 3'b0;
			reg_b <= 3'b0;
		end else begin 
			if(iLoadx && !iLoady) begin // load reg_x when iLoadx is high
				reg_x <= {1'b0, ixy_coord};
			end else if(iLoady && !iLoadx) begin // load reg_y and reg_c when iLoady is high
				reg_y <= {1'b0, ixy_coord};
				reg_c <= iColour;
			end
		end
	end
	
	// 4_bit counter enabled when iPlotBox is high
	always @(posedge iClock) begin
		if(!resetn) begin
			reg_counter_4bits <= 0;
		end else if(reg_counter_4bits == 4	'b1111) begin
			reg_counter_4bits <= 0;
		end else if(iPlotBox && !iBlack) begin
			reg_counter_4bits <= reg_counter_4bits + 1;
		end
	end
	
	// clear screen counter
	always @(posedge iClock) begin
		if(!resetn) begin
			reg_counter_6bits <= 6'b0;
		end else if(reg_counter_6bits == 6'd39) begin
			reg_counter_6bits <= 6'b0;
		end else if(iPlotBox && iBlack) begin 
			reg_counter_6bits <= reg_counter_6bits + 1;
		end
	end
	
	// clear screen counters
	always @(posedge iClock) begin
		if(iPlotBox && !iBlack) begin
			oX <= reg_counter_4bits[1:0] + reg_x;
			oY <= reg_counter_4bits[3:2] + reg_y;
			oColour <= reg_c; 	
			oPlot <= 1;
		end else if(iPlotBox && iBlack) begin
			oX <= reg_counter_6bits[2:0];
			oY <= reg_counter_6bits[5:3];
			oColour <= reg_b;
			oPlot <= 1;
		end
	end
endmodule 