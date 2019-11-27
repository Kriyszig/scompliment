//module reg(input wire clk,reset,input wire in,output wire out);
//  wire [14:0] d;
//	dfr d0(clk,reset,in,d[0]);
//	dfr d1(clk,reset,d[0],d[1]);
//	dfr d2(clk,reset,d[1],d[2]);
//	dfr d3(clk,reset,d[2],d[3]);
//	dfr d4(clk,reset,d[3],d[4]);
//	dfr d5(clk,reset,d[4],d[5]);
//	dfr d6(clk,reset,d[5],d[6]);
//	dfr d7(clk,reset,d[6],d[7]);
//	dfr d8(clk,reset,d[7],d[8]);
//	dfr d9(clk,reset,d[8],d[9]);
//	dfr d10(clk,reset,d[9],d[10]);
//	dfr d11(clk,reset,d[10],d[11]);
//	dfr d12(clk,reset,d[11],d[12]);
//	dfr d13(clk,reset,d[12],d[13]);
//	dfr d14(clk,reset,d[13],d[14]);
//	dfr d15(clk,reset,d[14],out);
//endmodule

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
