module complimenter(input wire clk,reset,i,output wire o);
  wire t1,t2;
  or2 o0(i,t2,t1);
  dfr d(clk,reset,t1,t2);
  xor2 x(i,t2,o);
endmodule

module complimentshiftreg(input wire clk, load, input wire[3:0] load_sig, output wire[3:0] out_sig);
    reg[3:0] r;
    wire cin,cout;
    assign cout = r[0];
    complimenter c(clk,load,cout,cin);
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
