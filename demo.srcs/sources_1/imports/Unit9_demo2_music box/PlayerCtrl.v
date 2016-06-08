module PlayerCtrl (
	input clk,
	input reset,
	output reg [9:0] ibeat
);
parameter BEATLEAGTH = 10'd751; //BEATLEAGTH * 4

always @(posedge clk, posedge reset) begin
	if (reset)
		ibeat <= 10'd0;
	else if (ibeat < BEATLEAGTH) 
		ibeat <= ibeat + 10'd1;
	else 
		ibeat <= 10'd0;
end

endmodule