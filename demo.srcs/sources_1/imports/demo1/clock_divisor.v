module clock_divisor(clk1,clk17,clk20, clk);
input clk;
output clk1;

output clk20;
output[1:0] clk17;
reg [24:0] num;
wire [24:0] next_num;

always @(posedge clk) begin
  num <= next_num;
end

assign next_num = num + 1'b1;
assign clk1 = num[1];
assign clk17=num[16:15];
assign clk20=num[19];

endmodule
//================================================
module BTN(CLK,in,out);

input CLK,in;
output out;

reg[3:0] debounce;
reg[1:0] pos_edge;
wire out;

always @(posedge CLK)begin
	debounce[3:1]<=debounce[2:0];
	debounce[0]<=in;
end

always @(posedge CLK)begin
	pos_edge[1]<=pos_edge[0];
	pos_edge[0]<=(&debounce[3:0]);
end

assign out= (~pos_edge[1])&(pos_edge[0]);


endmodule
