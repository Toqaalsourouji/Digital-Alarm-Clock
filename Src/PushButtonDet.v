`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2024 04:47:34 PM
// Design Name: 
// Module Name: PushButtonDet
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PushButtonDet(input clk, rst, in, output z);

wire out;
wire SIG1;

Debouncer DUT_debouncer(clk, rst, in,  out);
Synchronizer DUT_synch(clk, out, SIG1);
risingEdgeDet DUT_edge_det( clk, rst, SIG1,z);

endmodule
