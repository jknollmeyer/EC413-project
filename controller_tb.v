`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:40:44 03/31/2016
// Design Name:   controller
// Module Name:   /ad/eng/users/a/v/avahid/Documents/EC413/Project/Project/controller_tb.v
// Project Name:  Project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module controller_tb;

	parameter INPUT_SIZE =  6;
	parameter OUTPUT_SIZE = 17;
	parameter STATE_SIZE =  4;
	
	// Inputs
	reg [INPUT_SIZE-1:0] input_signal;
	reg reset;
	reg clk;

	// Outputs
	wire [OUTPUT_SIZE-1:0] output_signal;

	// Instantiate the Unit Under Test (UUT)
	controller uut (
		.input_signal(input_signal), 
		.output_signal(output_signal), 
		.reset(reset), 
		.clk(clk)
	);

	initial begin
	
		$display ("time\tclk\treset\t\tinput_signal\t\toutput_signal");
		$monitor ("%g\t%b\t%b\t\t%b\t\t%b",
					 $time, clk, reset, input_signal, output_signal);
	
		// Initialize Inputs
		input_signal = 0;
		reset = 1;
		clk = 0;

		// Reset the FSM.
		#25; clk= 1; reset= 1;              
		#25; clk= 0; reset= 0;
		// No input.
		#25; clk= 1;              
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b010000;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b010001;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b010010;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b010011;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b010100;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b010100;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b010101;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b010110;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b010111;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;		
		
		#25; clk= 0;input_signal= 6'b000001;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b100001;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;

		#25; clk= 0;input_signal= 6'b110010;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b110011;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b110100;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b110101;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b110110;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b110111;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b111001;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b111011;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
		#25; clk= 0;input_signal= 6'b111100;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		
	end
      
endmodule

