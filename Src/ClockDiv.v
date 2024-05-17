`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2024 04:43:20 PM
// Design Name: 
// Module Name: ClockDiv
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


module ClockDiv
#(parameter n = 50000000) //10000
(input clk, reset, output reg clk_out);

parameter WIDTH = $clog2(n);
reg [WIDTH-1:0] count;
// Big enough to hold the maximum possible value// Increment count
always @ (posedge clk, posedge reset) begin
if (reset == 1'b1) // Asynchronous Reset  count <= 32'b0;
    count <= 32'b0;

else if (count == n-1)
     count <= 32'b0;
else
    count <= count + 1;
end
// Handle the output clock
always @ (posedge clk, posedge reset) begin
if (reset) // Asynchronous Reset
    clk_out <= 0;
else if (count == n-1)
    clk_out <= ~ clk_out;
end

endmodule
