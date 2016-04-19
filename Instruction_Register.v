`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:45:02 04/08/2016 
// Design Name: 
// Module Name:    Instruction_Register 
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
module Instruction_Register(
		input[DATA_WIDTH-1:0] InstructionIn,
		input IRWrite,
		input clk,
		output reg[DATA_WIDTH-1:0] IROut		
    );

	parameter DATA_WIDTH = 32;
	initial
		IROut <= 0;
	
	always @(posedge clk) begin
		if (IRWrite)
			IROut <= InstructionIn;
	end
endmodule
