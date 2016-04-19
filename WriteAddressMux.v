`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:16:28 04/08/2016 
// Design Name: 
// Module Name:    WriteAddressMux 
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
module WriteAddressMux(
	input[4:0] R2,
	input[4:0] R3,
	input RegDst,
	output[4:0] WriteRegister
    );

	assign WriteRegister = RegDst ? R3 : R2;
endmodule
