module AXI_protocol(
	//Global signals
	input A_clk,
	input A_reset,
	//Address Read signals
	output wire [7:0]AR_addr,
	output wire AR_valid,
	output wire AR_ready,
	//Read signals
	output wire [7:0]R_data,
	output wire R_resp,
	output wire R_valid,
	output wire R_ready,
	//Address Write signals
	output wire [7:0]AW_addr,
	output wire AW_valid,
	output wire AW_ready,
	//Write signals
	output wire [7:0]W_data,
	output wire W_valid,
	output wire W_ready,
	//Write response signals
	output wire B_resp,
	output wire B_valid,
	output wire B_ready,
	//user input signals
	input [7:0] raddr,
	input [7:0] waddr,
	input [7:0] data,
	output [7:0] read
);

AXI_master master(
	//Global signals
	.A_clk(A_clk),
	.A_reset(A_reset),
	//Address Read signals
	.AR_addr(AR_addr),
	.AR_valid(AR_valid),
	.AR_ready(AR_ready),
	//Read signals
	.R_data(R_data),
	.R_resp(R_resp),
	.R_valid(R_valid),
	.R_ready(R_ready),
	//Address Write signals
	.AW_addr(AW_addr),
	.AW_valid(AW_valid),
	.AW_ready(AW_ready),
	//Write signals
	.W_data(W_data),
	.W_valid(W_valid),
	.W_ready(W_ready),
	//Write response signals
	.B_resp(B_resp),
	.B_valid(B_valid),
	.B_ready(B_ready),
	.raddr(raddr),
	.waddr(waddr),
	.data(data),
	.read(read)
);

AXI_slave slave(
	//Global signals
	.A_clk(A_clk),
	.A_reset(A_reset),
	//Address Read signals
	.AR_addr(AR_addr),
	.AR_valid(AR_valid),
	.AR_ready(AR_ready),
	//Read signals
	.R_data(R_data),
	.R_resp(R_resp),
	.R_valid(R_valid),
	.R_ready(R_ready),
	//Address Write signals
	.AW_addr(AW_addr),
	.AW_valid(AW_valid),
	.AW_ready(AW_ready),
	//Write signals
	.W_data(W_data),
	.W_valid(W_valid),
	.W_ready(W_ready),
	//Write response signals
	.B_resp(B_resp),
	.B_valid(B_valid),
	.B_ready(B_ready)
);

endmodule