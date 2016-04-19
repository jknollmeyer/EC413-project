`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:22:12 04/08/2016 
// Design Name: 
// Module Name:    DataReg 
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
module DataReg(
	input clk,
	input[DATA_WIDTH-1:0] in,
	output reg[DATA_WIDTH-1:0] out
    );
	parameter DATA_WIDTH = 32;
	
	initial out <= 0;
	
	always @(posedge clk)
		out <= in;

endmodule
