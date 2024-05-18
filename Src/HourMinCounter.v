`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2024 04:55:41 PM
// Design Name: 
// Module Name: HourMinCounter
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


module HourMinCounter
(   input clk,
    input reset,
    input en,
    input enHours,
    input enMins,
    input updown,
    output [5:0] seconds,
    output [3:0] minutes_units,
    output [2:0] minutes_tens,
    output [3:0] hours_units,
    output [1:0] hours_tens
);

wire [5:0] minutes;
wire [4:0] hours;
wire enhours;
wire enmins;

assign enhours = en ? seconds == 59 & minutes == 59: enHours;
assign enmins = en ? seconds == 59 : enMins;

NBitCounter #(60, 6) DUT0 ( .clk( clk) , .reset(reset), .en(en),.updown(1'b1), .count(seconds)); 

NBitCounter #(60, 6) DUT2 ( .clk(clk) , .reset(reset), .en(enmins),.updown(updown), .count(minutes));  

NBitCounter #(24, 5) DUT4 ( .clk(clk) , .reset(reset), .en(enhours),.updown(updown), .count(hours));   

assign minutes_units = minutes % 10;
assign minutes_tens = minutes / 10;

assign hours_units = hours % 10;
assign hours_tens = hours / 10;

endmodule 
