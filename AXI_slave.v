module AXI_slave(
	//Global signals
	input A_clk,
	input A_reset,
	//Address Read signals
	input [7:0]AR_addr,
	input AR_valid,
	output reg AR_ready,
	//Read signals
	output reg [7:0]R_data,
	output reg R_resp,
	output reg R_valid,
	input R_ready,
	//Address Write signals
	input [7:0]AW_addr,
	input AW_valid,
	output reg AW_ready,
	//Write signals
	input [7:0]W_data,
	input W_valid,
	output reg W_ready,
	//Write response signals
	output reg B_resp,
	output reg B_valid,
	input B_ready
);
reg [7:0] MEM [0:255];
reg [7:0] waddr_reg;
reg [7:0] wdata_reg;
reg write_addr_valid, write_data_valid;
reg [7:0] raddr_reg;

always@(posedge A_clk)
begin
	if(A_reset) begin
		AR_ready <= 0;
		R_resp <= 0;
		R_valid <= 0;
		AW_ready <= 0;
		W_ready <= 0;
		B_resp <= 0;
		B_valid <= 0;
		write_addr_valid <= 0;
		write_data_valid <= 0;
	end
	else begin
		//write address handshake
		if(AW_valid && !write_addr_valid) begin
			AW_ready <= 1;
			waddr_reg <= AW_addr;
			write_addr_valid <= 1;
		end else begin
			AW_ready <= 0;
		end
		//write data handshake
		if(W_valid && !write_data_valid) begin
			W_ready <= 1;
			MEM[waddr_reg] <= W_data;
			B_valid <= 1;
			B_resp <= 0;
			write_addr_valid <= 0;
			write_data_valid <= 0;
		end
		else W_ready <= 0;
		//write response handshake
		if(B_valid && B_ready) begin
			B_valid <= 0;
		end
		
		//read address handshake
		if(AR_valid && !AR_ready && !R_valid) begin
			AR_ready <= 1;
			raddr_reg <= AR_addr;
		end else begin
			AR_ready <= 0;
		end
		
		//Read data channel
		if(AR_valid && AR_ready && !R_valid) begin
			R_data <= MEM[raddr_reg];
			R_resp <= 0;
			R_valid <= 1;
		end
		
		if(R_valid && R_ready) begin
			R_resp <= 1;
			R_valid <= 0;
		end
	end
end
endmodule