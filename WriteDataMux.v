`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:52:51 04/08/2016 
// Design Name: 
// Module Name:    WriteDataMux 
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
module WriteDataMux(
	input[DATA_WIDTH-1:0] ALUOut,
	input[DATA_WIDTH-1:0] MDROut,
	input MemtoReg,
	output[DATA_WIDTH-1:0] WriteData
    );

	parameter DATA_WIDTH = 32;
	
	assign WriteData = MemtoReg ? MDROut : ALUOut;

endmodule
