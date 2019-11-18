module shiftreg(input wire clk, load, cin, input wire[3:0] load_sig, output wire cout, output wire[3:0] out_sig);
    reg[3:0] r;
    assign cout = ~r[0];

    always @(posedge clk)
    begin
        if (load == 1) begin
            r[0] <= load_sig[0];
            r[1] <= load_sig[1];
            r[2] <= load_sig[2];
            r[3] <= load_sig[3];
        end else begin
            r[0] <= r[1];
            r[1] <= r[2];
            r[2] <= r[3];
            r[3] <= cin;
        end
    end

    assign out_sig = r;
endmodule

module halfadder(input wire a, b, output wire s, c);
    assign s = a ^ b;
    assign c = a & b;
endmodule

module addunit(input wire clk, cout, set, output wire nbit);
    wire t1, t2;
    reg carry;
    
    always @(posedge clk)
    begin
        if (set == 1) begin
            carry <= 1'b1;
        end else begin
            carry <= t2;
        end
    end

    halfadder hai1 (cout, carry, t1, t2);
    assign nbit = t1;
endmodule

module connect(input wire clk, load, input wire[3:0] load_sig, output wire[3:0] out_sig);
    wire t1, t2;
    shiftreg sri0 (clk, load, t1, load_sig, t2, out_sig);
    addunit aui0 (clk, t2, load, t1);
endmodule

module serialcompliment(input wire clk, set, input wire[3:0] load_sig, output wire[3:0] out_sig);
    wire t1, t2;

    assign t1 = 1'b1;
    assign t2 = 1'b0;

    connect ci0 (clk, set, load_sig, out_sig);
endmodule
