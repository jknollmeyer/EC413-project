`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:03:54 04/08/2016 
// Design Name: 
// Module Name:    SignExtend 
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
module SignZeroExtend(
	input[(DATA_WIDTH/2)-1:0] in,
	output[DATA_WIDTH-1:0] out
    );
	parameter DATA_WIDTH = 32;
	assign out = in[(DATA_WIDTH/2)-1] ? {16'b1111_1111_1111_1111, in} : {16'b0000_0000_0000_0000, in};
endmodule
