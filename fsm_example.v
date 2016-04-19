//-----------------------------------------------------
// This is an FSM demo program using a function for
// next state logic.
// Design Name : fsm_example
// File Name   : fsm_example.v
//-----------------------------------------------------
`timescale 1ns / 1ps
// comment out next line to remove debug print outs when
// running test bench
`define DEBUG_PRINTOUTS_ENABLED;

module fsm_example (
	input_signal , // FSM input
	output_signal, // FSM output
	reset        , // Active high, syn reset
	clk            // clk
);
//-------------Internal Constants----------------------
parameter INPUT_SIZE =  3;
parameter OUTPUT_SIZE = 6;
parameter STATE_SIZE =  3;
//--- Parameters to describe States ---
parameter S_IDLE=          3'b000;
parameter S_NAP=           3'b001;
parameter S_SLEEP=         3'b010;
parameter S_HIBERNATE=     3'b011;
parameter S_WAKEUP=        3'b100;
parameter S_ATTENDCLASS=   3'b101;
//--- Parameters to describe Input bit patterns ---
// (all go to sleep inputs begin with 0)
parameter I_GETTIRED=      3'b001;
parameter I_GETVERYTIRED=  3'b010;
parameter I_TRANQUILIZER=  3'b011;
// (all wake up inputs begin with 1)
parameter I_TIMEFORCLASS=  3'b100;
parameter I_LOUDNOISE=     3'b101;
parameter I_ALARMCLOCK=    3'b110;
parameter I_COLDWATER=     3'b111;
//--- Parameters to describe Output bit patterns ---
parameter O_NOTHING=       6'b100000;
parameter O_SNORE=         6'b100001;
parameter O_UPSET=         6'b100010;
parameter O_LEARN=         6'b100011;
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
reg     [STATE_SIZE-1:0] state;      // Seq part of the FSM
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
	S_IDLE:
		case(I)
			I_GETTIRED:     nextstate_func= S_NAP;
			I_GETVERYTIRED: nextstate_func= S_SLEEP;
			I_TRANQUILIZER: nextstate_func= S_HIBERNATE;
			I_TIMEFORCLASS: nextstate_func= S_ATTENDCLASS;
			default:        nextstate_func= S_IDLE;
		endcase
	S_NAP:
		// Example of using casez to cover all wakeup inputs
		casez(I)
			3'b1zz:         nextstate_func= S_WAKEUP;
			default:        nextstate_func= S_NAP;
		endcase
	S_SLEEP:
		case(I)
			I_LOUDNOISE:    nextstate_func= S_WAKEUP;
			I_ALARMCLOCK:   nextstate_func= S_WAKEUP;
			I_COLDWATER:    nextstate_func= S_WAKEUP;
			default:        nextstate_func= S_SLEEP;
		endcase
	S_HIBERNATE: 
		case(I)
			I_COLDWATER:    nextstate_func= S_WAKEUP;
			default:        nextstate_func= S_HIBERNATE;
		endcase
	S_WAKEUP:
		case(I)
			I_TIMEFORCLASS: nextstate_func= S_ATTENDCLASS;
			default:        nextstate_func= S_IDLE;
		endcase
	S_ATTENDCLASS:
		case(I)
			I_GETTIRED:     nextstate_func= S_NAP;
			I_GETVERYTIRED: nextstate_func= S_SLEEP;
			I_TRANQUILIZER: nextstate_func= S_HIBERNATE;
			I_TIMEFORCLASS: nextstate_func= S_ATTENDCLASS;
			default:        nextstate_func= S_IDLE;
		endcase
	default :             nextstate_func = S_IDLE;
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
		output_signal= O_NOTHING;
	end
	else begin
		case(state)
			S_IDLE :       output_signal=  O_NOTHING;
			S_NAP  :       output_signal=  O_SNORE;
			S_SLEEP:       output_signal=  O_SNORE;
			S_HIBERNATE:   output_signal=  O_SNORE;
			S_WAKEUP:      output_signal=  O_UPSET;
			S_ATTENDCLASS: output_signal=  O_LEARN;
			default:       output_signal=  O_NOTHING;
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
     state <=  S_IDLE;
   end else begin
     state <=  next_state;
   end

`ifdef DEBUG_PRINTOUTS_ENABLED
	// Debug printouts to display current state when running 
	// the testbench
	case(next_state)
		S_IDLE        : $display("Current state: S_IDLE");
		S_NAP         : $display("Current State: S_NAP");
		S_SLEEP       : $display("Current State: S_SLEEP");
		S_HIBERNATE   : $display("Current State: S_HIBERNATE");
		S_WAKEUP      : $display("Current State: S_WAKEUP");
		S_ATTENDCLASS : $display("Current State: S_ATTENDCLASS");
		default       : $display("Current State: Invalid State");
	endcase
`endif	

end // End Of Block FSM_SEQ

 
endmodule // End of Module arbiter

