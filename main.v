module shiftreg(input wire clk, load, cin, input wire[3:0] load_sig, output wire cout, output wire[3:0] out_sig);
    wire[3: 0] tmp;
    wire[3: 0] regw;

    assign out_sig = regw;
    assign cout = regw[0];

    mux2 mx2i0 (regw[1], load_sig[0], load, tmp[0]);
    mux2 mx2i1 (regw[2], load_sig[1], load, tmp[1]);
    mux2 mx2i2 (regw[3], load_sig[2], load, tmp[2]);
    mux2 mx2i3 (cin, load_sig[3], load, tmp[3]);

    df dfi0 (clk, tmp[0], regw[0]);
    df dfi1 (clk, tmp[1], regw[1]);
    df dfi2 (clk, tmp[2], regw[2]);
    df dfi3 (clk, tmp[3], regw[3]);
endmodule

module halfadder(input wire a, b, output wire s, c);
    assign s = a ^ b;
    assign c = a & b;
endmodule

module addunit(input wire clk, cout, set, output wire nbit);
    wire carry, t;

    dfs dfi4 (clk, set, t, carry);
    halfadder hai1 (cout, carry, nbit, t);
endmodule

module connect(input wire clk, load, input wire[3:0] load_sig, output wire[3:0] out_sig);
    wire t1, t2;
    shiftreg sri0 (clk, load, t1, load_sig, t2, out_sig);
    addunit aui0 (clk, !t2, load, t1);
endmodule

module serialcompliment(input wire clk, set, input wire[3:0] load_sig, output wire[3:0] out_sig);
    connect ci0 (clk, set, load_sig, out_sig);
endmodule
