module onehz( input clk, reset, enable, output clk1hz);
reg[26:0] counter;
// To generate a signal with a frequency of 1hz from 100Mhz, the counter 
// should count 100 000 000 clock cycles.
assign clk1hz = (counter == 99999999);
always@(posedge clk)
if (reset || clk1hz )
	counter <= 0;
else if (enable)
	counter <= counter + 1;
endmodule