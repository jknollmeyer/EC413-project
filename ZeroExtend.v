`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:00:44 04/20/2016 
// Design Name: 
// Module Name:    ZeroExtend 
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
module ZeroExtend(
	input[(DATA_WIDTH/2)-1:0] in,
	output[DATA_WIDTH-1:0] out
    );
	parameter DATA_WIDTH = 32;
	assign out = {16'b0000_0000_0000_0000, in};
endmodule
