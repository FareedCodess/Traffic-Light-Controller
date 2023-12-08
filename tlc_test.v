module tlc_test(input clk, reset, enable, output wire[3:0]r, g, output [7:0]seg, an);
wire[3:0] D0,D1,D2,D3,D4,D5,D6,D7;
// Reg signals are derived from inverted green signals.
assign r[3] = ~g[3];assign r[2] = ~g[2];assign r[1] = ~g[1];assign r[0] = ~g[0];
/// Creating a 1hz clock for the circuit to work at a speed of 1hz (1s).
onehz m1(clk, reset, enable, clk1hz);
// Main module
tlc_time m2(clk, reset, clk1hz, g[3], g[2], g[1], g[0],  D6, D4, D2, D0);
// 7 - segment display for the remaining time display.
DISP7SEG ssd(clk,D0,D1,D2,D3,D4,D5,D6,D7, text_mode,slow, med, fast, error, seg, an);
endmodule