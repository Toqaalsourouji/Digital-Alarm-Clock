`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2024 04:40:48 PM
// Design Name: 
// Module Name: NBitCounter
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


module NBitCounter #(parameter n = 4, x = 2)(input clk, reset, en, updown, output reg [(x-1):0] count);

    always @(posedge clk, posedge reset)begin
        if (reset == 1)
            count<= 0;
        else begin
            if (en == 1)begin
                if(updown ==1) begin
                    if (count < n - 1)
                        count <= count + 1;
                    else if (count == n - 1)
                        count<= 0;
                 end
                 else begin
                    if (count > 0)
                        count <= count - 1;
                    else if( count == 0)
                        count <= n-1;
                 end
            end
            else 
                count <= count;
        end
   end

endmodule
