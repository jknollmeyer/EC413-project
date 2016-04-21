`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:08:05 04/08/2016 
// Design Name: 
// Module Name:    SrcBMux 
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
module SrcBMux(
	input[1:0] ALUSrcB,
	input[DATA_WIDTH-1:0] DataRegB,
	input[DATA_WIDTH-1:0] SignExtended,
	input[DATA_WIDTH-1:0] Register2FastTrack,
	output[DATA_WIDTH-1:0] out
    );
	parameter DATA_WIDTH = 32;
	
	assign out =  ALUSrcB[1] && ~ALUSrcB[0] ? SignExtended :
					 ~ALUSrcB[1] && ALUSrcB[0] ? 32'd1 :
					 ~ALUSrcB[1] && ~ALUSrcB[0] ? DataRegB : 
					 &ALUSrcB[1] ? Register2FastTrack: -1;

endmodule
