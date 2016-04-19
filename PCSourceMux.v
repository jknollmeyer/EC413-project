`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:28 04/08/2016 
// Design Name: 
// Module Name:    PCSourceMux 
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
module PCWriteSourceMux(
	input[1:0] PCSource,
	input[DATA_WIDTH-1:0] ALUOut,
	input[DATA_WIDTH-1:0] ALURegisterOut,
	input[25:0] Immediate,
	output[ADDR_WIDTH-1:0] out
    );
	
	parameter DATA_WIDTH = 32;
	parameter ADDR_WIDTH = 16;
	
	// Use ternary operator to assign outputs to wires
	// 10: PCWriteSource = Instruction Immediate
	// 01: PCWriteSource = ALU Register Output
   // 00: PCWriteSource = ALU Output
	
	assign out = PCSource[1] && ~PCSource[0] ? Immediate[15:0] :
					 ~PCSource[1] && PCSource[0] ? ALURegisterOut[15:0] :
					 ~PCSource[1] && ~PCSource[1] ? ALUOut[15:0] : -1;

endmodule
