`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:39:53 04/08/2016 
// Design Name: 
// Module Name:    MDR 
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
module MDR(
		input clk,
		input[DATA_WIDTH-1:0] dataIn,
		output reg[DATA_WIDTH-1:0] dataOut
    );

parameter DATA_WIDTH = 32;

initial begin
	dataOut <= 0;
end
always @(posedge clk) begin
	dataOut <= dataIn;
end

endmodule
