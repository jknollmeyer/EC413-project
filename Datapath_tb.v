`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:41:14 04/07/2016
// Design Name:   Datapath
// Module Name:   /ad/eng/users/j/k/jknollm/EC413/project/Datapath_tb.v
// Project Name:  project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Datapath
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Datapath_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	Datapath uut (
		.clk(clk), 
		.reset(reset), 
		.result(result)
	);

	always #5 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
		
	end
      
endmodule

