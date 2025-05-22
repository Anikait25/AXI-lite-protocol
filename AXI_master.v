module AXI_master(
	//Global signals
	input A_clk,
	input A_reset,
	//Address Read signals
	output reg [7:0]AR_addr,
	output reg AR_valid,
	input AR_ready,
	//Read signals
	input [7:0]R_data,
	input R_resp,
	input R_valid,
	output reg R_ready,
	//Address Write signals
	output reg [7:0]AW_addr,
	output reg AW_valid,
	input AW_ready,
	//Write signals
	output reg [7:0]W_data,
	output reg W_valid,
	input W_ready,
	//Write response signals
	input B_resp,
	input B_valid,
	output reg B_ready,
	//user input signals
	input [7:0] raddr,
	input [7:0] waddr,
	input [7:0] data,
	output reg [7:0] read
);

reg [3:0]AW_state;
reg [3:0]W_state;
reg [3:0]AR_state;
reg [3:0]R_state;
reg [3:0]B_state;

localparam AW_IDLE = 0;
localparam AW_VALIDITY = 1;
localparam AW_DONE = 2;

localparam AR_IDLE = 3;
localparam AR_VALIDITY = 4;
localparam AR_DONE = 5;

localparam W_IDLE = 6;
localparam W_WRITE = 7;
localparam W_DONE = 8;

localparam R_IDLE = 9;
localparam R_READ = 10;
localparam R_DONE = 11;

localparam B_IDLE = 12;
localparam B_RESPONSE = 13;
localparam B_DONE = 14;

always@(posedge A_clk)
begin
	if(A_reset) begin
		AW_state <= AW_IDLE;
		W_state <= W_IDLE;
		AR_state <= AR_IDLE;
		R_state <= R_IDLE;
		B_state <= B_IDLE;
	end
	else begin
	//Address write FSM
		case(AW_state)
			AW_IDLE:
				begin
					AW_valid <= 1;
					AW_state <= AW_VALIDITY;
				end
			AW_VALIDITY:
				begin
					if(AW_valid && AW_ready) begin
						AW_addr <= waddr;
						AW_valid <= 0;
						AW_state <= AW_DONE;
					end
				end
			AW_DONE:
				begin
					AW_state <= AW_IDLE;
				end
			default: AW_state <= AW_IDLE;
		endcase
	//Write FSM
		case(W_state)
			W_IDLE:
				begin
					W_valid <= 1;
					W_state <= W_WRITE;
				end
			W_WRITE:
				begin
					if(W_valid && W_ready && AW_addr) begin
						W_data <= data;
						W_valid <= 0;
						W_state <= W_DONE;
					end
				end
			W_DONE:
				begin
					W_state <= W_IDLE;
				end
			default: W_state <= W_IDLE;
		endcase
	//Address read FSM
		case(AR_state)
			AR_IDLE:
				begin
					AR_valid <= 1;
					AR_state <= AR_VALIDITY;
				end
			AR_VALIDITY:
				begin
					if(AR_valid && AR_ready) begin
						AR_addr <= AW_addr;
						AR_valid <= 0;
						AR_state <= AR_DONE;
					end
				end
			AR_DONE:
				begin
					AR_state <= AR_IDLE;
				end
			default: AR_state <= AR_IDLE;
		endcase
	//Read FSM
		case(R_state)
			R_IDLE:
				begin
					R_ready <= 1;
					R_state <= R_READ;
				end
			R_READ:
				begin
					if(R_valid && R_ready && AR_addr) begin
						read <= R_data;
						R_ready <= 0;
						R_state <= R_DONE;
						end
						//$display("read = %h", R_data);
				end
			R_DONE:
				begin
					R_state <= R_IDLE;
				end
			default: R_state <= R_IDLE;
		endcase
		//$display("Read state = %d", R_state);
	//Write Response
		case(B_state)
			B_IDLE:
				begin
					if(!B_valid)
						B_ready <= 1;
					B_state <= B_RESPONSE;
				end
			B_RESPONSE:
				begin
					if(B_valid && B_ready) begin
						B_ready <= 0;
						B_state <= B_DONE;
					end
				end
			B_DONE:
				begin
					B_state <= B_IDLE;
				end
			default:B_state <= B_IDLE;
		endcase
	end
end

endmodule