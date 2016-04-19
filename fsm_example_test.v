//-----------------------------------------------------
// Test bench for fsm_example state machine.
//-----------------------------------------------------
`timescale 1ns / 1ps
module fsm_example_test;
	//-------------Internal Constants----------------------
	parameter INPUT_SIZE =  3;
	parameter OUTPUT_SIZE = 6;
	parameter STATE_SIZE =  3;
	
	// Inputs
	reg [INPUT_SIZE-1:0] input_signal;
	reg reset;
	reg clk;

	// Outputs
	wire [OUTPUT_SIZE-1:0] output_signal;

	// Instantiate the Unit Under Test (UUT)
	fsm_example uut (
		.input_signal(input_signal), 
		.output_signal(output_signal), 
		.reset(reset), 
		.clk(clk)
	);

	initial begin
	
		$display ("time\tclk\treset\t\tinput_signal\t\toutput_signal");
		$monitor ("%g\t%b\t%b\t\t%b\t\t%b",
					 $time, clk, reset, input_signal, output_signal);
	
		// Initialize Inputs
		input_signal = 0;
		reset = 1;
		clk = 0;

		// Reset the FSM.  Should go into S_IDLE= 3'b000 state, and output O_NOTHING= 6'b100000.
		#25; clk= 1; reset= 1;              
		#25; clk= 0; reset= 0;
		// No input.  Should stay in S_IDLE= 3'b000 state, and output O_NOTHING= 6'b100000.
		#25; clk= 1;              
		#25; clk= 0;
		#25; clk= 1;
		// Input I_GETTIRED= 3'b001. Should go to state S_SLEEP= 3'b010, and output O_SNORE= 6'b100001.
		#25; clk= 0;input_signal= 3'b001;
		#25; clk= 1;
		// Should stay in state S_SLEEP= 3'b010 state, and output O_SNORE= 6'b100001.
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		// Input I_TIMEFORCLASS= 3'b100. Should go to state S_WAKEUP= 3'b100, and output O_UPSET= 6'b100010.
		#25; clk= 0;input_signal= 3'b100;
		#25; clk= 1;
		// Should go to state S_ATTENDCLASS= 3'b101, and output O_LEARN= 6'b100011.
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		// Input I_TRANQUILIZER= 3'b011. Should go to state S_HIBERNATE= 3'b011, and output O_SNORE= 6'b100001.
		#25; clk= 0;input_signal= 3'b011;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		// Input I_TIMEFORCLASS= 3'b100. Should still stay in state S_HIBERNATE= 3'b011, and output O_SNORE= 6'b100001.
		#25; clk= 0;input_signal= 3'b100;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		// Input I_COLDWATER= 3'b111. Should go to state S_WAKEUP= 3'b100, and output O_UPSET= 6'b100010.
		#25; clk= 0;input_signal= 3'b111;
		#25; clk= 1;
		// Should go into S_IDLE= 3'b000 state, and output O_NOTHING= 6'b100000.
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
		#25; clk= 1;
		#25; clk= 0;
	end
      
endmodule

