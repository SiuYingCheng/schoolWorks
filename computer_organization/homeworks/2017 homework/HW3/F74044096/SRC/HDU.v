// Hazard Detection Unit(figure)

module HDU ( // input
			ID_Rs,
             		ID_Rt,
			EX_WR_out,
			EX_MemtoReg,
			EX_JumpOP,
			// output
			PCWrite,
			IF_IDWrite,
			IF_Flush,
			ID_Flush
			);
	
	parameter bit_size = 32;
	
	input [4:0] ID_Rs;
	input [4:0] ID_Rt;
	input [4:0] EX_WR_out;
	input EX_MemtoReg;
	input [1:0] EX_JumpOP;
	
	output PCWrite;
	output IF_IDWrite;
	output IF_Flush;
	output ID_Flush;

	reg PCWrite;
	reg IF_IDWrite;
	reg IF_Flush;
	reg ID_Flush;

	always @(*) begin
		PCWrite = 1;
		IF_IDWrite = 1;
		IF_Flush = 0;
		ID_Flush = 0;
		
		if(EX_JumpOP != 0)
		begin
			IF_Flush = 1;
			ID_Flush = 1;
		end
		
		if(EX_MemtoReg)
		begin
			if(EX_WR_out == ID_Rs)//if(EX_WR_out == ID_Rs || EX_WR_out == ID_Rt)(try)
			begin
				PCWrite = 0;
				IF_IDWrite = 0;
			end
			
			if(EX_WR_out == ID_Rt)
			begin
				PCWrite = 0;
				IF_IDWrite = 0;
			end
		end
	end			
	
endmodule