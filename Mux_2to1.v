`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:24:33 04/21/2016 
// Design Name: 
// Module Name:    Mux_2to1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Mux_2to1(
		input[W-1:0] R1,
		input[W-1:0] R3,
		input isBranch,
		output[W-1:0] out
    );

	parameter W = 5;
	assign out = isBranch ? R1 : R3;
	
endmodule
