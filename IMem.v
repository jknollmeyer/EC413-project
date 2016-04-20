// IMem
//
// A module used to mimic Instruction memory, for the EC413 project.
// Returns hardcoded instructions based on the current PC.
//
// Version2. Posted 7:30PM on Nov 27.
// Fixed a false nop instruction and reg select fields in 1.
//
`timescale 1ns / 1ps
// ----------------------------------------------------
// IMPORTANT!
// Which test program to use:
// - PROGRAM_1: first simple example.
//
// - PROGRAM_2: test remaining instructions 
//              and corner cases.
// - PROGRAM_3: optional LW/SW program.
//
`define PROGRAM_1 // <<<<<<<<<<<< CHANGE TEST PROGRAM HERE!
//
// Change the previous line to try a different program,
// when available.
// ----------------------------------------------------

module IMem(PC,          // PC (address) of instruction in IMem
            Instruction);

`ifdef PROGRAM_1
	parameter PROG_LENGTH= 26;
`else
`ifdef PROGRAM_2
	parameter PROG_LENGTH= 1;
`else
`ifdef PROGRAM_3
	parameter PROG_LENGTH= 1;
`endif
`endif
`endif
//-------------Input Ports-----------------------------
input [15:0] PC;
//-------------Output Ports----------------------------
output [31:0] Instruction;
reg [31:0] Instruction;
//------------Code Starts Here-------------------------
always @(PC)
begin
case(PC)
//-----------------------------------------------------
`ifdef PROGRAM_1
//-----------------------------------------------------


	// NOOP
	0: Instruction=  32'b000000_00000_00000_0000000000000000;		

	1: Instruction=  32'b110010_00001_00001_0000000000000101;		// I, addi r1 with 00000005 		=> r1 = 00000005
	
	2: Instruction=  32'b110010_00010_00010_0000000000001010;		// I, addi r2 with 0000000A 		=> r2 = 0000000A
	
	3: Instruction=  32'b110010_00011_00011_1111111111111000;		// I, addi r3 with 0000FFF8 		=> r3 = FFFFFFF8
	
	4: Instruction=  32'b110011_00100_00100_0000000000000001;		// I, subi r4 with 00000001 		=> r4 = FFFFFFFF
	
	5: Instruction=  32'b110100_00101_00101_1010101010101010;		// I, ori r5 with 0000AAAA  		=> r5 = 00000AAAA
	
	6: Instruction=  32'b110101_00110_00110_1111111111111111;		// I, andi r6 with 0000FFFF 		=> r6 = 00000000

	7: Instruction=  32'b010000_00111_00001_0000000000000000;		// R, mov r1 to r7					=> r7 = 00000005
	
	8: Instruction=  32'b010000_01000_00010_0000000000000000;		// R, mov r2 to r8					=> r8 = 0000000A

	9: Instruction=	 32'b010000_01001_00000_0000000000000000;		// R, mov r0 to r9					=> r9 = 000000000

	10: Instruction=  32'b010010_01010_00111_01000_00000000000;		// R, r10 = r7 + r8					=> r10 = 0000000F

	11: Instruction= 32'b010011_01011_00111_01000_00000000000;		// R, r11 = r7 - r8					=> r11 = FFFFFFFB

	12: Instruction= 32'b010100_01100_00111_01001_00000000000;		// R, r12 = r7 or r9				=> r12 = 00000005

	13: Instruction=  32'b010101_01101_01000_00100_00000000000;		// R, r13 = r8 and r4				=> r13 = 0000000A

	14: Instruction=  32'b100001_00010_01101_1111111111110010;		// BNE, Jump to 0 when r2 != r13

	15: Instruction= 32'b100001_01100_01101_0000000000000001;		// BNE, Jump to 17 when r12 != r13
	
	16: Instruction= 32'b010000_01101_00000_0000000000010000;		// R, mov r0 to r13				 	=> r13 = 00000000

	17: Instruction= 32'b111100_01101_00000_0000000000001000;		// SWI r13 to MEM address 0x08

	18: Instruction= 32'b111011_01110_00000_0000000000001000;		// LWI r14 from MEM address 0x08   	=> r14 = 0000000A

	19: Instruction= 32'b100001_01101_01110_0000000000000001;		// BNE, Jump to 21 when r13 != r14

	20: Instruction= 32'b111001_01111_00000_0000000000001000;		// LI r15 from immediate 8			=> r15 = 00000008

	21: Instruction= 32'b100001_01100_01110_0000000000000001;		// BNE, Jump to 23 when r12 != r14

	22: Instruction= 32'b111001_01111_00000_0000000000001011;		// LI r15 from immediate B			=> r15 = 0000000B
	
	23:	Instruction= 32'b010111_10000_01111_01110_00000000000;		// SLT, r16 = (r15 < r14)			=> r16 = 00000001
	
	24:	Instruction= 32'b110111_10001_01111_1111111111111111;		// SLTI, r17 = (r15 < -1)			=> r17 = 00000000
	
	25:	Instruction= 32'b110111_10010_01111_0000000000001001;		// SLTI, r18 = (r15 < 9)			=> r18 = 00000001
	
	26: Instruction= 32'b000001_00000_00000_0000000000000000;		// Jump to Instr 0
`else
//-----------------------------------------------------
`ifdef PROGRAM_2
//-----------------------------------------------------

	
`else
//-----------------------------------------------------
`ifdef PROGRAM_3
//-----------------------------------------------------


`endif
`endif
`endif
	default: Instruction= 0; //NOOP
endcase
end

endmodule
	
