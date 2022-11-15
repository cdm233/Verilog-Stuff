//
// This is the template for Part 3 of Lab 7.
//
// Paul Chow
// November 2021
//

// iColour is the colour for the box
//
// oX, oY, oColour and oPlot should be wired to the appropriate ports on the VGA controller
//

// Some constants are set as parameters to accommodate the different implementations
// X_SCREENSIZE, Y_SCREENSIZE are the dimensions of the screen
//       Default is 160 x 120, which is size for fake_fpga and baseline for the DE1_SoC vga controller
// CLOCKS_PER_SECOND should be the frequency of the clock being used.

module part3(iColour,iResetn,iClock,oX,oY,oColour,oPlot);
   input wire [2:0] iColour;
   input wire 	    iResetn;
   input wire 	    iClock;
   output wire [7:0] oX;         // VGA pixel coordinates
   output wire [6:0] oY;
   
   output wire [2:0] oColour;     // VGA pixel colour (0-7)
   output wire 	     oPlot;       // Pixel drawn enable

   parameter
     X_SCREENSIZE = 160,  // X screen width for starting resolution and fake_fpga
     Y_SCREENSIZE = 120,  // Y screen height for starting resolution and fake_fpga
     CLOCKS_PER_SECOND = 5000, // 5 KHZ for fake_fpga
     X_BOXSIZE = 8'd4,   // Box X dimension
     Y_BOXSIZE = 7'd4,   // Box Y dimension
     X_MAX = X_SCREENSIZE - 1 - X_BOXSIZE, // 0-based and account for box width
     Y_MAX = Y_SCREENSIZE - 1 - Y_BOXSIZE,
     PULSES_PER_SIXTIETH_SECOND = CLOCKS_PER_SECOND / 60;

   //
   // Your code goes here
   //
	
	wire [3:0] frameWire;
	wire [3:0] xPosWire;
	wire [2:0] yPosWire;
	
	wire wResetCounter, wResetX, wResetY, wPlot, wDirH, wDirY, wUpDateX, wUpDateY, wClock, wBlack, wDrawReset;
	
	posControl 	pc(iResetn, iClock, frameWire, xPosWire, yPosWire, wResetCounter, wResetX, wResetY, wPlot, wDirH, wDirY, wUpDateX, wUpDateY, wBlack, wDrawReset);
	posDataPath pd(iClock, wResetCounter, wResetX, wResetY, wDirH, wDirY, wUpDateX, wUpDateY, xPosWire, yPosWire, frameWire, wClock);
	draw			dd({4'b0, xPosWire}, {5'b0, yPosWire}, iClock, wDrawReset, wBlack, wPlot, iColour, oX, oY, oColour, oPlot);


endmodule // part3

module posControl(input iResetn, clock, input [3:0] frames, input [3:0] xPos, input [2:0] yPos,
		output reg oResetCounter, oResetX, oResetY, oPlot, oDirH, oDirY, oUpDateX, oUpDateY, oBlack, oDrawReset);

	localparam  
			S_initial_set 		= 3'd0,
			S_reset_counters	= 3'd1,
			S_draw 		  		= 3'd2,
			S_check_pos			= 3'd3,
			S_change_dir		= 3'd4,
			S_update_pos		= 3'd5,
			S_clear_screen		= 3'd6;
	
	reg [2:0] cs, ns;
	
	// state table
	always @(*) begin
		case (cs)
			S_initial_set: 	ns = S_reset_counters;
			S_reset_counters:	ns = S_draw;
			S_draw: 				ns = frames < 15 ? S_draw : S_check_pos;
			S_check_pos:	 	begin
										if(((xPos + 4) > 8) || ((yPos + 4) > 6)) 
											ns = S_change_dir;
										else
											ns = S_update_pos;
									end
			S_change_dir: 		ns = S_update_pos;
			S_update_pos:		ns = S_clear_screen;
			S_clear_screen:	ns = S_reset_counters;
			default: ns = S_initial_set;
		endcase
	end
	
	// main logic
	always @(*) begin
	
		oResetCounter	= 1; // default to not reset
		oResetX			= 1;
		oResetY			= 1;
		oPlot				= 0; // default to plot
		oBlack			= 0; // default to not clear screen
		oUpDateX			= 0; // default to not update X
		oUpDateY			= 0; // default to not update Y
		oDrawReset 		= 1;
		
		case (cs)
			S_initial_set: 	begin 
				oResetX			= 0;
				oResetY			= 0;
				oDirH 			= 1; // default to down_right diagonal movement
				oDirY 			= 0;
			end
			S_reset_counters: begin
				oResetCounter 	= 0;
				oDrawReset 		= 0;
			end
			S_draw:				begin
				oPlot 			= 1;
			end					
			S_change_dir:		begin
				if((xPos + 4) > 8)
					oDirH = ~oDirH;
				if((yPos + 4) > 6)
					oDirY = ~oDirY;
			end
			S_update_pos:		begin
				oUpDateX = 1;
				oUpDateY = 1;
				oDrawReset = 0;
				oPlot 	= 1;
			end
			S_clear_screen: 	begin
				oBlack 	= 1;
				oPlot 	= 1;
			end
			default: ;
		endcase
	
	end
	
	// current state reg
	always@(posedge clock) begin
		if(!iResetn)
			cs <= S_initial_set;
		else
			cs <= ns;
	end // state_FFS

endmodule






// draw: input [7:0] xPos, yPos, input iClock, iResetn, iBlack, iPlot, input [2:0] iColour, output reg [7:0] oX, oY, output reg [2:0] oColour, output oPlot
module posDataPath(
		input iClock, iResetCounter, iResetX, iResetY, DirH, DirY, upDateX, upDateY,
		output [3:0] oX, output [2:0] oY, output [3:0] oFrames, output oClock
		);
		
	wire dividedClock;
	
	delayCounter divider(iClock, 1'b1, iResetCounter, dividedClock); // rate divider is always enabled
	frameCounter framesCounter(iClock, dividedClock, 1'b1, iResetCounter, oFrames);
	xCounter		 xPosCounter(iClock, DirH, upDateX, iResetX, oX);
	yCounter		 yPosCounter(iClock, DirY, upDateY, iResetY, oY);
	
	assign oClock = dividedClock;

endmodule 

// delayCounter for every 20 clock edges; output clock pulse
module delayCounter(input clock, enable, resetn, output pulse);
	reg [4:0] value;
	
	always @(posedge clock) begin
		if(!resetn) begin
			value <= 0;
		end else if(value == 5'd19) begin
			value <= 0;
		end else begin
			value <= value + 1;
		end
	end
	assign pulse = value == 5'd19 ? 1 : 0;
endmodule

// simple counter for keeping track of how many frames have passed; output counter 4bits value (0 to 15)
module frameCounter(input clock, dClock, enable, resetn, output reg [3:0] value);

	always @(posedge clock) begin
		if(!resetn) begin
			value <= 0;
		end else if(dClock) begin
			value <= value + 1;
		end
	end

endmodule

// up_down counter for keeping track of the square's x position; output x position 4bits value (0 to 8)
module xCounter(input clock, upDown, enable, resetn, output reg [3:0] xPos);

	always @(posedge clock) begin
		if(!resetn) begin
			xPos <= 0;
		end else if(enable && upDown) begin
			xPos <= xPos + 1;
		end else if(enable && !upDown) begin
			xPos <= xPos - 1;
		end
	end
		
endmodule

// up_down counter for keeping track of the square's y position; output y position 3bits value (0 to 6)
module yCounter(input clock, upDown, enable, resetn, output reg [2:0] yPos);

	always @(posedge clock) begin
		if(!resetn) begin
			yPos <= 0;
		end else if(enable && upDown) begin
			yPos <= yPos - 1;
		end else if(enable && !upDown) begin
			yPos <= yPos + 1;
		end
	end

endmodule





// draw when iPlot is high
module draw(input [7:0] xPos, yPos, input iClock, iResetn, iBlack, inputPlot, input [2:0] iColour, 
		output reg [7:0] oX, output reg [6:0] oY, output reg [2:0] oColour, output oPlot
		);

	reg [3:0] counterReg4bits; // for drawing square
	reg [7:0] counterReg8bits; // for clearing the screen
	
	reg [2:0] colourBlackReg;
	
	reg iPlot;
	reg done;
	
	assign oPlot = 1;
	always @(*) begin
		
		if(done) 
			iPlot = 0;
		else
			iPlot = 1;
	
	end
	
	// 4bit counter for drawing square
	always @(posedge iClock) begin
		if(!iResetn) begin
			counterReg4bits <= 0;
			done = 0;
		end else if(counterReg4bits == 4'd15) begin
			counterReg4bits <= 0;
			done = 1;
		end else if(iPlot && !iBlack) begin
			counterReg4bits <= counterReg4bits + 1;
			done = 0;
		end
	end
	
	// 8bit counter for clearing the screen
	always @(posedge iClock) begin
		if(!iResetn) begin
			counterReg8bits <= 0;
			done = 0;
		end else if(counterReg8bits == 8'd70) begin
			counterReg8bits <= 0;
			done = 1;
		end else if(iPlot && iBlack) begin
			if(counterReg8bits[2:0] == 3'b110) begin
				counterReg8bits <= counterReg8bits + 2;
				done = 0;
			end else begin
				counterReg8bits <= counterReg8bits + 1;
				done = 0;
			end
		end
	end
	
	always @(posedge iClock) begin
		if(!iResetn) begin
			done = 0;
			colourBlackReg <= 0;
		end else if(iPlot && !iBlack) begin // draw square
			oX <= counterReg4bits[1:0] + xPos; 
			oY <= counterReg4bits[3:2] + yPos; 
			oColour <= iColour;  
		end else if(iPlot && iBlack) begin	// clear screen
			oX <= counterReg8bits[6:3]; 
			oY <= counterReg8bits[2:0]; 
			oColour <= colourBlackReg;
		end
	end
endmodule 