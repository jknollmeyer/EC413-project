`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:00:17 04/21/2016 
// Design Name: 
// Module Name:    MDRMux 
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
module MDRMux(
	input MemRead,
	input[DATA_WIDTH-1:0] DMemOut,
	input[DATA_WIDTH-1:0] DataRegB,
	output[DATA_WIDTH-1:0] out
    );
	parameter DATA_WIDTH = 32;
	assign out = MemRead ? DMemOut : DataRegB;
endmodule
