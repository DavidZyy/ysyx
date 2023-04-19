module    SEG7P2S(input wire clk,						//parallel to serial
						input wire rst,
						input wire Start,
						input wire[DATA_BITS-1:0] PData,

						output wire s_clk,
						output wire s_clrn,
						output wire sout,
						output reg  EN
						);
						
parameter
	DATA_BITS = 16,  											// data length
	DATA_COUNT_BITS = 4,										// data shift bits
	DIR = 0;														// Shift direction
localparam
		S_IDLE = 0,  // idle
		S_TRAN = 1;  // converting	
		
wire S1,S0,SL,SR;
reg [DATA_BITS:0] Q;
reg sh_clk;
reg [1:0]Go = 00, S = 00, state = 00;	


	always @(negedge s_clk )begin
		case({S1,S0})
		2'b00: Q <= Q;													//S1S0=00 ����
		2'b01: Q <= {SR,Q[DATA_BITS:1]};							//S1S0=01 ����
		2'b10: Q <= {Q[DATA_BITS-1:0],SL};						//S1S0=10 ����
		2'b11: if(DIR)Q <= {1'b0,PData}; 
				 else   Q <= {PData,1'b0};							//S1S0=11 ����
		endcase
	end	

	assign {SR,SL} = 2'b11;
	assign s_clk = sh_clk;		
	assign s_clrn = 1;
	
	assign sout    = DIR ? Q[0] : Q[DATA_BITS];
	assign {S1,S0} = DIR ? {S[0],S[1]} : S;
	wire finish    = DIR ? &Q[DATA_BITS:2] : &Q[DATA_BITS-2:0];
	
	
	always @(posedge clk )
		Go <= {Go[0],Start};

	always @(posedge clk or posedge rst )begin
		if (rst) begin
			sh_clk <= 0;
		end
		else case(state)
			S_IDLE: if(Go == 2'b01)begin 
						  EN = 0;
						  S = 2'b10;
					     state  <= S_TRAN;
						  sh_clk <= ~sh_clk;
					  end	 
					  else begin 
						  EN = 1;
						  S = 2'b11;
						  sh_clk <= 0;
						  state <= S_IDLE;
					  end		
					  
			S_TRAN: begin if(finish)begin			
								  sh_clk <= ~sh_clk;
								  EN = 1;
								  S = 2'b11;
							     state <= S_IDLE;
							  end
							  else begin sh_clk <= ~sh_clk;
									 state <= S_TRAN;
							  end
					  end
						default: state <=  S_IDLE;
		  endcase
	end

endmodule
