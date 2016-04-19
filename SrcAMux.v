`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:04:20 04/08/2016 
// Design Name: 
// Module Name:    SrcAMux 
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
module SrcAMux(
	input ALUSrcA,
	input[(DATA_WIDTH/2)-1:0] PCOut,
	input[DATA_WIDTH-1:0] DataRegA,
	output[DATA_WIDTH-1:0] out
    );
	parameter DATA_WIDTH = 32;
	assign out = ALUSrcA ? DataRegA : {16'd0, PCOut};
endmodule
