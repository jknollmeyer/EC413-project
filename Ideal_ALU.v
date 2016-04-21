`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:15:02 10/23/2014 
// Design Name: 
// Module Name:    Ideal_ALU 
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
module Ideal_ALU(R1, R2, R3, ALUOp, Opcode, Zero);
	 
	 
	parameter	word_size = 32;		// word_size default value = 32		
	input  [3:0] Opcode;
	input  [word_size-1:0] R2, R3;
	input	 [1:0]			  ALUOp;
	output reg [word_size-1:0] R1;	// Note: R1 here is not a D-flip-flop. It just declares a variable here.
												//       a "reg" without the "always @ (posedge clk)" is not a D-flip-flop.

 output Zero;
 assign Zero = R2 - R3 == 32'd0 ? 1 : 0;
 always @ (R1, R2, R3, ALUOp, Opcode)				// When any of R2, R3, ALUOp changes, R1 will change. 
	// ---- ideal ALU ------	
	begin
		case (ALUOp)
			// 00 Always ADD
			2'b00:
				R1 = R2 + R3; 
			// 01 Always SUB
			2'b01:
				R1 = R2 - R3;
			
			
			/*
			// 01 Arithmetic/Logical R-type
			2'b01:
				case(Opcode)
					4'b0000: R1 = R2; //MOV
					4'b0001: R1 = ~R2; //NOT
					4'b0010: R1 = R2 + R3; //ADD
					4'b0011: R1 = R2 - R3; //SUB
					4'b0100: R1 = R2 | R3; //OR
					4'b0101: R1 = R2 & R3; //AND
					4'b0110: R1 = R2 ^ R3; //XOR
					4'b0111: R1 = (($signed(R2) < $signed(R3))? 1:0); // SLT
					default: R1 = -1;
				endcase*/
			/* 10 Branch I-type
			2'b10:
				case(Opcode)
					4'b0001: R1 = -1;//BNE
					default: R1 = -1;
				endcase
			// 11 Arithmetic/Logical I-type*/
			
			
			// 10 Check the opcode
			2'b10:
				// R3 in this case is a SE(Imm) or ZE(Imm)
				case(Opcode)
					4'b0000: R1 = R2;
					4'b0010: R1 = R2 + R3; //ADDI
					4'b0011: R1 = R2 - R3; //SUBI
					4'b0100: R1 = R2 | R3; //ORI
					4'b0101: R1 = R2 & R3; //ANDI
					4'b0110: R1 = R2 ^ R3; //XORI
					4'b0111: R1 = (($signed(R2) < $signed(R3))? 1:0); // SLTI
					4'b1001: R1 = R3; //LI
					4'b1011: R1 = R3; //LWI
					4'b1100: R1 = R2; //SWI Data
					default: R1 = -1;
				endcase
			// 11 Force MOV R3 -> R1
			2'b11:
				case(Opcode)
					4'b1100: R1 = R3; //SWI Address
					4'b1011: R1 = R3;
					default: R1 = -1;
				endcase
			default: R1 = -1;
		endcase
	end
	
// ---- ideal ALU end------

endmodule
