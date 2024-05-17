`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2024 04:22:19 PM
// Design Name: 
// Module Name: SevenSegment
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


module SevenSegment(
input [3:0] num,
input [1:0] sel,
input en_clk,
input Dot,
output reg [7:0] display,
output reg [3:0] anode_active);

always @(sel) begin
        case (sel)
            2'b00:begin
                display[0] = 1'b1; // changed b0
                anode_active <= 4'b1110;
            end 
            2'b01: begin 
                 display[0] = 1'b1;
                 anode_active <= 4'b1101;
            end 
            2'b10: begin
                 display[0] = en_clk ? Dot : 1'b1;
                 anode_active <= 4'b1011; 
            end
            2'b11: begin
                display[0] = 1'b1;
                anode_active <= 4'b0111; 
            end
        endcase
case (num)     
   
    0: display[7:1] = 7'b0000001;
    1: display[7:1] = 7'b1001111;
    2: display[7:1] = 7'b0010010;
    3: display[7:1] = 7'b0000110;
    4: display[7:1] = 7'b1001100;
    5: display[7:1] = 7'b0100100; 
    6: display[7:1] = 7'b0100000;
    7: display[7:1] = 7'b0001111;
    8: display[7:1] = 7'b0000000;
    9: display[7:1] = 7'b0001100;
 
endcase 
end   
endmodule
  



