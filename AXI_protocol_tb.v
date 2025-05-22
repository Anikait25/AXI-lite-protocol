module AXI_protocol_tb;
//Global signals
reg A_clk;
reg A_reset;
//Address Read signals
wire [7:0]AR_addr;
wire AR_valid;
wire AR_ready;
//Read signals
wire [7:0]R_data;
wire R_resp;
wire R_valid;
wire R_ready;
//Address Write signals
wire [7:0]AW_addr;
wire AW_valid;
wire AW_ready;
//Write signals
wire [7:0]W_data;
wire W_valid;
wire W_ready;
//Write response signals
wire B_resp;
wire B_valid;
wire B_ready;
//user input signals
reg [7:0] raddr;
reg [7:0] waddr;
reg [7:0] data;
wire [7:0] read;
AXI_protocol protocol(
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

initial
A_clk = 0;
always #5 A_clk = ~A_clk;

initial
begin
A_reset = 1;
#30;
A_reset = 0;
#10;
waddr = 8'h45;
data = 8'h23;
#30;
waddr = 8'h65;
data = 8'h34;
#30;
raddr = 8'h45;
#50;
raddr = 8'h65;
//$monitor($time," R_read = %b", R_data);
#50;
$stop;
end
endmodule