`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:05:57 10/30/2013 
// Design Name: 
// Module Name:    FSM 
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
module FSM(Opcode, Clk, Reset, State);

input				[5:0]	Opcode;
input						Clk, Reset;

output	reg	[3:0]	State;

parameter	LW = 6'b100011, SW = 6'b101011, J = 6'b000010, BEQ = 6'b000100, R_type = 6'b000000;

always @ (posedge Clk)

begin:	FSM

if (Reset)
	begin
	State <= 0;
	end 

else
	case (State)
	
	4'd0:	State <= 4'd1;
	
	4'd1: 
			if ((Opcode == LW) || (Opcode == SW))
				State <= 4'd2;
			else	if (Opcode == R_type)
				State <= 4'd6;
			else  if (Opcode == BEQ)
				State <= 4'd8;
			else  if (Opcode == J)
				State <= 4'd9;
			else  State <= 4'd1;
			
	4'd2:
			if (Opcode == LW)
				State <= 4'd3;
			else if (Opcode == SW)
				State <= 4'd5;
			else State <= 4'd2;
			
	4'd3:
			State <= 4'd4;
	
	4'd4:
			State <= 4'd0;
	
	4'd5:
			State <= 4'd0;
			
	4'd6:
			State <= 4'd7;
			
	4'd7:
			State <= 4'd0;

	4'd8:
			State <= 4'd0;

	4'd9:
			State <= 4'd0;

	default: State <= 4'd0;
	
	endcase
	
end

endmodule
