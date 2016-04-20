`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:33 04/01/2016 
// Design Name: 
// Module Name:    program_counter 
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
module program_counter(
		input							clk,
		input							reset,
		input							PCWrite,
		input[ADDR_WIDTH-1:0]	PCin,
		output reg[ADDR_WIDTH-1:0]  PCout
    );
parameter ADDR_WIDTH = 16;

initial begin
	PCout = 0;
end

always @(posedge clk) begin
	if(reset)
		PCout = 0;
	if(PCWrite) 
		PCout = PCin;
end

endmodule
