`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:26:33 03/31/2016 
// Design Name: 
// Module Name:    Controller 
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

//-----------------------------------------------------
`timescale 1ns / 1ps
// comment out next line to remove debug print outs when
// running test bench
`define DEBUG_PRINTOUTS_ENABLED;

module controller (
	input_signal , // FSM input
	output_signal, // FSM output
	reset        , // Active high, syn reset
	clk            // clk
);
//-------------Internal Constants----------------------
parameter INPUT_SIZE =  6;
parameter OUTPUT_SIZE = 17;
parameter STATE_SIZE =  4;
//--- Parameters to describe States ---
parameter S_IRFETCH=    	4'b0000; //0
parameter S_IRDECODE=      4'b0001; //1
parameter S_MEMCOMP=       4'b0010; //2
parameter S_MEMACCESS3=    4'b0011; //3
parameter S_WRITEBACK=     4'b0100; //4
parameter S_MEMACCESS5=   	4'b0101; //5
parameter S_EXECUTION=   	4'b0110; //6
parameter S_RTYPECOMP=   	4'b0111; //7
parameter S_BRANCHCOMP=   	4'b1000; //8
parameter S_JUMPCOMP=   	4'b1001; //9
parameter S_IEXECUTIONSE=   	4'b1010; //10
parameter S_IEXECUTIONZE=   	4'b1011; //11
//--- Parameters to describe Input bit patterns ---

parameter I_NOOP = 	6'b000000; //NOOP	
parameter I_MOV = 	6'b010000; //R1 = R2 MOV
parameter I_NOT = 	6'b010001; //R1 = ~R2 NOT
parameter I_ADD = 	6'b010010; //R1 = R2 + R3 ADD
parameter I_SUB = 	6'b010011; //R1 = R2 - R3 SUB
parameter I_OR = 		6'b010100; //R1 = R2 | R3 OR	 
parameter I_AND = 	6'b010101; //R1 = R2 & R3 AND
parameter I_XOR = 	6'b010110; //R1 = R2 ^ R3 XOR
parameter I_SLT = 	6'b010111; //R1	= 1 if R2 < R3, else 0 SLT
parameter I_J = 		6'b000001; //PC <- PC[31:26] || Limm J
parameter I_BNE = 	6'b100001; //IF (R1 != R2) THEN PC <- PC + SE(Imm) BNE ELSE PC <- PC + 1
parameter I_BLT = 	6'b100010; //IF (R1 < R2) THEN PC <- PC + SE(Imm) BlT ELSE PC <- PC + 1
parameter I_BLE = 	6'b100011; //IF (R1 <= R2) THEN PC <- PC + SE(Imm) BlE ELSE PC <- PC + 1
parameter I_ADDI = 	6'b110010; //R1 = R2 + SE(Imm) ADDI
parameter I_SUBI = 	6'b110011; //R1 = R2 - SE(Imm) SUBI
parameter I_ORI = 	6'b110100; //R1 = R2 | ZE(Imm) ORI
parameter I_ANDI = 	6'b110101; //R1 = R2 & ZE(Imm) ANDI
parameter I_XORI = 	6'b110110; //R1	= R2 ^ ZE(Imm) XORI
parameter I_SLTI = 	6'b110111; //R1 = 1 if R2 < SE(Imm), else 0 SLTI
parameter I_LI = 		6'b111001; //R1[15:0] <- ZE(Imm) LI
parameter I_LWI = 	6'b111011; //R1 <- M[ZE(Imm)] LWI
parameter I_LW = 		6'b111101; //R1 <- M[R2] + SE(IMM) LW
parameter I_SWI = 	6'b111100; //M[ZE(IMM)] <- R1 SWI

//--- Parameters to describe Output bit patterns ---

//ZeroOrSign   1'b
//PCWriteCond	1'b
//PCWrite		1'b
//IorD			1'b
//MemRead		1'b
//MemWrite		1'b
//MemtoReg		1'b
//IRWrite		1'b
//PCSource		2'b
//ALUOp			2'b
//ALUSrcB		2'b
//ALUSrcA		1'b	
//RegWrite		1'b
//RegDst			1'b

parameter O_IRFETCH=    	16'b0_1_0_1_0_0_1_00_00_01_0_0_0; // 0
parameter O_IRDECODE=      16'b0_0_0_0_0_0_0_00_00_10_0_0_0; // 1
parameter O_MEMCOMP=       16'b0_0_0_0_0_0_0_00_11_10_1_0_0; // 2
parameter O_MEMACCESS3=    16'b0_0_1_1_0_0_0_00_00_00_0_0_0; // 3
parameter O_WRITEBACK=     16'b0_0_0_0_0_1_0_00_01_00_0_1_0; // 4
parameter O_MEMACCESS5=   	16'b0_0_1_0_1_0_0_00_01_10_1_0_0; // 5
parameter O_EXECUTION=   	16'b0_0_0_0_0_0_0_00_01_00_1_0_0; // 6
parameter O_RTYPECOMP=   	16'b0_0_0_0_0_0_0_00_00_00_0_1_0; // 7
parameter O_BRANCHCOMP=   	16'b1_0_0_0_0_0_0_01_10_11_1_0_0; // 8
parameter O_JUMPCOMP=   	16'b0_1_0_0_0_0_0_10_00_00_0_0_0; // 9

parameter O_IEXECUTIONSE=  17'b0_0_0_0_0_0_0_0_00_01_10_1_0_0; // 10
parameter O_IEXECUTIONZE=  17'b1_0_0_0_0_0_0_0_00_01_10_1_0_0; 
  	
//-------------Input Ports-----------------------------
input   [INPUT_SIZE-1:0] input_signal;
input   clk,reset;
//-------------Output Ports----------------------------
output  [OUTPUT_SIZE-1:0] output_signal;
//-------------Input ports Data Type-------------------
wire    [INPUT_SIZE-1:0] input_signal;
wire    clk,reset;
//-------------Output Ports Data Type------------------
reg     [OUTPUT_SIZE-1:0] output_signal;
//-------------Internal Variables----------------------
reg     [STATE_SIZE-1:0] state = 0;      // Seq part of the FSM
wire    [STATE_SIZE-1:0] next_state; // Combo part of FSM

//----------Code starts Here---------------------------

// ================= Next state Logic =================
// Example of using a Verilog Function for Combinational 
// Logic to determine next state
assign next_state = nextstate_func(state, input_signal);
function [STATE_SIZE-1:0] nextstate_func; 
input [STATE_SIZE-1:0]  S; // current state
input [INPUT_SIZE-1:0]  I; // FSM input
begin

// Next state logic
case(S)
	S_IRFETCH: 
		case(I)
			//I_NOOP: 		nextstate_func= S_IRFETCH;
			default: 	nextstate_func= S_IRDECODE;
		endcase
	S_IRDECODE:
		case(I)
			I_NOOP:    	nextstate_func= S_IRFETCH;
			I_MOV:    	nextstate_func= S_EXECUTION; 
			I_NOT:    	nextstate_func= S_EXECUTION;
			I_ADD:    	nextstate_func= S_EXECUTION;
			I_SUB:    	nextstate_func= S_EXECUTION;
			I_OR:    	nextstate_func= S_EXECUTION;
			I_AND:    	nextstate_func= S_EXECUTION;
			I_XOR:    	nextstate_func= S_EXECUTION;
			I_SLT:    	nextstate_func= S_EXECUTION;
			I_J:    		nextstate_func= S_JUMPCOMP;
			I_BNE:    	nextstate_func= S_BRANCHCOMP;
			I_BLT:    	nextstate_func= S_BRANCHCOMP;
			I_BLE:    	nextstate_func= S_BRANCHCOMP;
			I_ADDI:    	nextstate_func= S_IEXECUTIONSE;
			I_SUBI:    	nextstate_func= S_IEXECUTIONSE;
			I_ORI:    	nextstate_func= S_IEXECUTIONZE;
			I_ANDI:    	nextstate_func= S_IEXECUTIONZE;
			I_XORI:    	nextstate_func= S_IEXECUTIONZE;
			I_SLTI:    	nextstate_func= S_IEXECUTIONZE;
			I_LI:    	nextstate_func= S_MEMCOMP;
			I_LWI:   	nextstate_func= S_MEMCOMP;
			I_LW:   		nextstate_func= S_MEMCOMP;
			I_SWI:    	nextstate_func= S_MEMCOMP;
			default:		nextstate_func= S_IRFETCH;
		endcase
	S_MEMCOMP:
		case(I)
			I_LI:    	nextstate_func= S_RTYPECOMP;
			I_LWI:   	nextstate_func= S_MEMACCESS3;
			I_LW:   		nextstate_func= S_MEMACCESS3;
			I_SWI:    	nextstate_func= S_MEMACCESS5;
			default:    nextstate_func= S_IRFETCH;
		endcase
	S_MEMACCESS3: 
		case(I)
			I_LWI:   	nextstate_func= S_WRITEBACK;
			I_LW:   		nextstate_func= S_WRITEBACK;
			default:    nextstate_func= S_IRFETCH;
		endcase
	S_WRITEBACK: 		nextstate_func= S_IRFETCH;
	S_MEMACCESS5: 		nextstate_func= S_IRFETCH;
	S_EXECUTION:
		case(I)
			I_MOV:    	nextstate_func= S_RTYPECOMP; 
			I_NOT:    	nextstate_func= S_RTYPECOMP;
			I_ADD:    	nextstate_func= S_RTYPECOMP;
			I_SUB:    	nextstate_func= S_RTYPECOMP;
			I_OR:    	nextstate_func= S_RTYPECOMP;
			I_AND:    	nextstate_func= S_RTYPECOMP;
			I_XOR:    	nextstate_func= S_RTYPECOMP;
			I_SLT:    	nextstate_func= S_RTYPECOMP;
			default:    nextstate_func= S_IRFETCH;
		endcase
	S_RTYPECOMP: 		nextstate_func= S_IRFETCH;
	S_BRANCHCOMP: 		nextstate_func= S_IRFETCH;
	S_JUMPCOMP: 		nextstate_func= S_IRFETCH;
	S_IEXECUTIONSE:
		case(I)
			I_ADDI:    	nextstate_func= S_RTYPECOMP;
			I_SUBI:    	nextstate_func= S_RTYPECOMP;
			default: 	nextstate_func= S_IRFETCH;
		endcase
	S_IEXECUTIONZE:
		case(I)
			I_ORI:    	nextstate_func= S_RTYPECOMP;
			I_ANDI:    	nextstate_func= S_RTYPECOMP;
			I_XORI:    	nextstate_func= S_RTYPECOMP;
			I_SLTI:    	nextstate_func= S_RTYPECOMP;
			default: 	nextstate_func= S_IRFETCH;
		endcase
	default : 			nextstate_func= S_IRFETCH;
endcase
end
endfunction // End Of nextstate_func

// ================= Output Combinatorial Logic =================
// This combinatorial logic determines the output of the FSM
// based on the current state only (Moore machine).  If it
// depended upon input_signal as well we would have a Mealy 
// machine.
always @ (state or reset)
	begin : OUTPUT_LOGIC
	if (reset == 1'b1) begin
		output_signal= 16'd0;
	end
	else begin
		case(state)
			S_IRFETCH:	    	output_signal=  O_IRFETCH;
			S_IRDECODE:      	output_signal=  O_IRDECODE;
			S_MEMCOMP:      	output_signal=  O_MEMCOMP;
			S_MEMACCESS3:    	output_signal=  O_MEMACCESS3;
			S_WRITEBACK:      output_signal=  O_WRITEBACK;
			S_MEMACCESS5:     output_signal=  O_MEMACCESS5;
			S_EXECUTION:      output_signal=  O_EXECUTION;
			S_RTYPECOMP:      output_signal=  O_RTYPECOMP;
			S_BRANCHCOMP:     output_signal=  O_BRANCHCOMP;
			S_JUMPCOMP:       output_signal=  O_JUMPCOMP;
			S_IEXECUTIONSE:   output_signal=  O_IEXECUTIONSE;
			S_IEXECUTIONZE:   output_signal=  O_IEXECUTIONZE;
			default:       	output_signal=  O_IRFETCH;
			endcase
	end
end // End Of Block OUTPUT_LOGIC

// ================= Sequential Logic =================
always @ (posedge clk)
begin : FSM_SEQ

	// <= represents a non-blocking assignment:
	// - The right hand side is evaluated immediately.
	// - The actual assignment to the LHS is delayed until all 
	//   other evaluations are completed in the current clock cycle.
	//   Then all assignments to the LHS are performed simultaneously.
   if (reset == 1'b1) begin
     state <=  S_IRFETCH;
   end else begin
     state <=  next_state;
   end

`ifdef DEBUG_PRINTOUTS_ENABLED
	// Debug printouts to display current state when running 
	// the testbench
	case(next_state)
		S_IRFETCH     	: $display("Current state: S_IRFETCH");
		S_IRDECODE    	: $display("Current state: S_IRDECODE");
		S_MEMCOMP      : $display("Current state: S_MEMCOMP");
		S_MEMACCESS3   : $display("Current state: S_MEMACCESS3");
		S_WRITEBACK    : $display("Current state: S_WRITEBACK");
		S_MEMACCESS5   : $display("Current state: S_MEMACCESS5");
		S_EXECUTION  	: $display("Current state: S_EXECUTION");
		S_RTYPECOMP   	: $display("Current state: S_RTYPECOMP");
		S_BRANCHCOMP   : $display("Current state: S_BRANCHCOMP");
		S_JUMPCOMP    	: $display("Current state: S_JUMPCOMP");
		S_IEXECUTIONSE  	: $display("Current state: S_IEXECUTIONSE");
		S_IEXECUTIONZE  	: $display("Current state: S_IEXECUTIONZE");
		default       	: $display("Current State: Invalid State");
	endcase
`endif	

end // End Of Block FSM_SEQ

 
endmodule // End of Module arbiter

