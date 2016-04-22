`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:26:38 04/07/2016 
// Design Name: 
// Module Name:    Datapath 
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
module Datapath(
	input clk,
	input reset,
	output[DATA_WIDTH-1:0] result
    );
	
	parameter DATA_WIDTH = 32;
	parameter ADDR_WIDTH = 16;
	
	//Wires carrying data-wide bits
	wire[DATA_WIDTH-1:0] ALUOut, 
								ALURegisterOut, 
								Instruction, 
								IROut, 
								MDROut, 
								MemData,
								ReadData1, 
								ReadData2,
								DataRegAOut, 
								DataRegBOut,
								ImmExtended,
								SrcB, 
								SrcA, 
								WriteDataMuxOut,
								MDRIn; 
	                     
	
	// Wires containing address-wide bits
	wire[ADDR_WIDTH-1:0] PCOut, 
								PCMuxOut, 
								PCSourceOut;
	
	wire[4:0] RegWriteAddress;
	
	// 1 bit wide wires
	wire ALUSrcA, 
			IorD, 
			IRWrite,
			PCWriteCond, 
			PCWrite,
			MemWrite, 
			MemtoReg, 
		   RegWrite, 
			RegDst,
			MemRead,
			ZeroOrSign;
	
	// 1 bit wide wires for the PC Write gates
	wire PCWriteCond_AND_Zero, 
			PCWriteCond_AND_Zero_OR_PCWrite;
			
	wire[1:0] PCSource,
					ALUSrcB;
	wire[1:0] ALUOp;
	wire[3:0] Opcode;
	
	wire ALUZero;
	wire[15:0] fakeFSMOutput;
	
	and(PCWriteCond_AND_Zero, PCWriteCond, ALUZero);
	or(PCWriteCond_AND_Zero_OR_PCWrite, PCWriteCond_AND_Zero, PCWrite);
	
	// Output the result from the ALUOut Register
	assign result = ALURegisterOut;
	assign Opcode = IROut[29:26];
	// controller
	controller Control(
		.input_signal(IROut[31:26]),
		.reset(reset),
		.clk(clk),

		.output_signal({
			ZeroOrSign,
			PCWriteCond,
			PCWrite,
			IorD,
			MemRead,
			MemWrite,
			MemtoReg,
			IRWrite,
			PCSource,
			ALUOp,
			ALUSrcB,
			ALUSrcA,
			RegWrite,
			RegDst
		})
		/*
		.PCWriteCond(PCWriteCond),
		.PCWrite(PCWrite),
		.IorD(IorD),
		//.MemRead(MemRead),
		.MemWrite(MemWrite),
		.MemtoReg(MemtoReg),
		.IRWrite(IRWrite),
		.PCSource(PCSource),
		.ALUOp(ALUOp),
		.ALUSrcB(ALUSrcB),
		.ALUSrcA(ALUSrcA),
		.RegWrite(RegWrite),
		.RegDst(RegDst)*/
	);
	
	// Program Counter
	program_counter PC(
		.reset(reset),
		.clk(clk),
		.PCWrite(PCWriteCond_AND_Zero_OR_PCWrite),
		.PCin(PCSourceOut),
		.PCout(PCOut)
	);
	
	//PC Mux
	InstructionAddressMux PCtoIRMux(
		.IorD(IorD),
		.PCOut(PCOut),
		.ALUOut(ALUOut),
		.out(PCMuxOut)
	);
		
	//Memory
	IMem IMem(
		.PC(PCMuxOut),
		.Instruction(Instruction)
	);
	
	DMem DMem(
		.WriteData(MDROut),
		.MemData(MemData),
		.Address(ALURegisterOut[15:0]),
		.MemWrite(MemWrite),
		.Clk(clk)
	);
	
	
	//MDR
	MDR MDR(
		.clk(clk),
		.dataIn(MDRIn),
		.dataOut(MDROut)
	);
	
	//IR
	Instruction_Register IR(
		.InstructionIn(Instruction),
		.IRWrite(IRWrite),
		.IROut(IROut),
		.clk(clk)
	);
	
	//MDR Mux
	WriteDataMux WriteDataMux(
		.MemtoReg(MemtoReg),
		.ALUOut(ALURegisterOut),
		.MDROut(MDROut),
		.WriteData(WriteDataMuxOut)
	);
	MDRMux MDRMux(
		.MemRead(MemRead),
		.DMemOut(MemData),
		.DataRegB(ReadData2),
		.out(MDRIn)
	);
	
	//Instruction sign extender FIX THIS
	SignZeroExtend SignZeroExtend(
		.in(IROut[15:0]),
		.ZeroOrSign(ZeroOrSign),
		.out(ImmExtended)
	);

	// Register 2 Mux
	wire[4:0] ReadSelect2;
	Mux_2to1 ReadSelect2Mux(
		.R1(IROut[25:21]),
		.R3(IROut[15:11]),
		.isBranch(ALUOp[1]),
		.out(ReadSelect2)
	);

	// WriteAddressMux
	WriteAddressMux WriteAddressMux(
		.R2(IROut[25:21]),
		.R3(IROut[20:16]),
		.RegDst(RegDst),
		.WriteRegister(RegWriteAddress)
	);
	//Register File
	nbit_register_file RegisterFile(
		.write_data(WriteDataMuxOut),
		.read_data_1(ReadData1),
		.read_data_2(ReadData2),
		.read_sel_1(IROut[20:16]),
		.read_sel_2(ReadSelect2),
		.write_address(RegWriteAddress),
		.RegWrite(RegWrite),
		.clk(clk)
	);
	
	
	//DataA register
	DataReg DataRegA(
		.clk(clk),
		.in(ReadData1),
		.out(DataRegAOut)
	);
	//DataB register
	DataReg DataRegB(
		.clk(clk),
		.in(ReadData2),
		.out(DataRegBOut)
	);
	//SrcA Mux
	SrcAMux SrcAMux(
		.ALUSrcA(ALUSrcA),
		.PCOut(PCOut),
		.DataRegA(DataRegAOut),
		.out(SrcA)
	);
	//SrcB Mux
	SrcBMux SrcBMux(
		.ALUSrcB(ALUSrcB),
		.DataRegB(DataRegBOut),
		.SignExtended(ImmExtended),
		.Register2FastTrack(ReadData2),
		.out(SrcB)
	);
	
	
	//ALU
	Ideal_ALU ALU(
		.R1(ALUOut),
		.R2(SrcA),
		.R3(SrcB),
		.ALUOp(ALUOp),
		.Opcode(Opcode),
		.Zero(ALUZero)
	);
	
	//ALUOut
	DataReg ALURegister(
		.clk(clk),
		.in(ALUOut),
		.out(ALURegisterOut)
	);
	
	//PCSource Mux
	PCWriteSourceMux PCWriteSourceMux(
		.PCSource(PCSource),
		.ALUOut(ALUOut),
		.ALURegisterOut(ALURegisterOut),
		.Immediate(IROut[25:0]),
		.out(PCSourceOut)
	);
	
endmodule
