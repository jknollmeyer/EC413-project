`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:13:39 04/07/2016 
// Design Name: 
// Module Name:    PCMux 
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
module InstructionAddressMux(
	input[ADDR_WIDTH-1:0] PCOut,
	input[DATA_WIDTH-1:0] ALUOut,
	input	IorD,
	output[ADDR_WIDTH-1:0] out
    );
	parameter ADDR_WIDTH = 16;
	parameter DATA_WIDTH = 32;
	assign out = (IorD) ? ALUOut[ADDR_WIDTH-1:0] : PCOut;

	
endmodule
