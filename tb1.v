`timescale 1 ns / 100 ps

module tb;
    reg clk,set;
    wire [3:0] sig_in, sig_out;
    initial begin $dumpfile("htw.vcd"); $dumpvars(0,tb); end
    initial clk = 1'b0; always #5 clk =~ clk;
    initial set = 1'b1; always #10 set = 1'b0;
    assign sig_in[0] = 1'b0;
    assign sig_in[1] = 1'b1;
    assign sig_in[2] = 1'b0;
    assign sig_in[3] = 1'b1;

    complimentshiftreg csr0 (clk, set, sig_in, sig_out);

    initial begin
        #55 $finish;
    end
endmodule
