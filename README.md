# Serial 2s Compliment

This repository holds the verilog code to find serial 2s compliment using shift registers.

#### How to run the code?

In order to run this program, you would require [iverilog](https://github.com/steveicarus/iverilog) and [gtkwave](http://gtkwave.sourceforge.net/).

```bash
git clone https://github.com/Kriyszig/scompliment.git
cd scompliment
```
```bash
iverilog main.v tb.v lib.v
./a.out
gtkwave htw.vcd
```
