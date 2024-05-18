`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2024 07:09:05 PM
// Design Name: 
// Module Name: MultiplexedOutput
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
//parameter [2:0] A=3'b000, B=3'b001, C=3'b010, D= 3'b011, E=3'b100, F=3'b101, G=3'b111; // States Encoding

module MultiplexedOutput(
input en_clk,
input clk, 
input clk_seconds,
input rst,
input [3:0] minutes_units,
input [2:0] minutes_tens,
input [3:0] hours_units,
input [1:0] hours_tens,
output [3:0] anode_active,
output [7:0] segments,
input [2:0] state, 
input [3:0] minutes_units_A,
input [2:0] minutes_tens_A,
input [3:0] hours_units_A,
input [2:0] hours_tens_A 
);
 
   
 reg [3:0] mux_output;
 wire [1:0] sel;
 
 NBitCounter #(.n(4)) Counter (.clk(clk), .reset(rst), .en(1'b1), .updown(1'b1), .count(sel));
 
 
 
    always @(sel)begin
    
        case(sel)
            2'b00: mux_output = (state==3'b101 | state==3'b100)? minutes_units_A : minutes_units ;
            2'b01: mux_output = (state==3'b101 | state==3'b100)? minutes_tens_A : minutes_tens;
            2'b10: mux_output = (state==3'b101 | state==3'b100)? hours_units_A : hours_units;
            2'b11: mux_output = (state==3'b101 | state==3'b100)? hours_tens_A : hours_tens;
        endcase
    end
    
    
    // Instantiate 7segment
     SevenSegment segment_decoder (
    .sel(sel),
    .num(mux_output),
    .en_clk(en_clk),
    .Dot(clk_seconds),
    .display(segments),
    .anode_active(anode_active) 
    );


endmodule
