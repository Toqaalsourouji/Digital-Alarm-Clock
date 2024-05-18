`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2024 04:52:10 PM
// Design Name: 
// Module Name: DigitalAlarmClock
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


module DigitalAlarmClock(    
    input clk,  
    input rst, 
    input en,
    input  [4:0] BTN, 
    output [7:0] segments,  
    output [3:0] anode_active,  
    output reg [4:0] LED
);

reg [2:0] state, nextState;
parameter [2:0] A=3'b000, B=3'b001, C=3'b010, D= 3'b011, E=3'b100, F=3'b101; // States Encoding
wire [4:0] BTN_Det;
wire [5:0] seconds;
wire [3:0] minutes_units;
wire [2:0] minutes_tens;
wire [3:0] hours_units;
wire [1:0] hours_tens;
wire [3:0] minutes_units_A;
wire [2:0] minutes_tens_A;
wire [3:0] hours_units_A;
wire [1:0] hours_tens_A;
wire clk_200, clk_1;
reg updown;
reg enAdjTimeMin;
reg enAdjTimeHours;
reg enAdjAlarmMin;
reg enAdjAlarmHours;
reg inputclock;
reg en_sec;
wire BTNC;

genvar i;
generate
    for(i = 0 ; i  < 5 ; i = i + 1)
        PushButtonDet BTN(clk_200, rst, BTN[i],BTN_Det[i]);
endgenerate

//PushButtonDet BTN(clk_200, rst, BTN[0],BTNC);
// assign LED[0] = BTNC;

ClockDiv #(250000) Div1 (clk, rst, clk_200); //for anode

ClockDiv Div2 (clk, rst, clk_1); //for seconds
 
HourMinCounter clock (.clk(inputclock), .reset(rst), .en(en_sec),.enHours(enAdjTimeHours), .enMins(enAdjTimeMin),.updown(updown), .seconds(seconds),.minutes_units(minutes_units), .minutes_tens(minutes_tens),
.hours_units(hours_units),.hours_tens(hours_tens));

HourMinCounter alarm (.clk(inputclock), .reset(rst), .en(1'b0),.enHours(enAdjAlarmHours),
.enMins(enAdjAlarmMin),.updown(updown), .seconds(),.minutes_units(minutes_units_A), .minutes_tens(minutes_tens_A),
.hours_units(hours_units_A),.hours_tens(hours_tens_A)); // what will the clk be? ^2

MultiplexedOutput out (.en_clk(en_sec), .clk(clk_200), .clk_seconds(clk_1), .rst(rst), .minutes_units(minutes_units), .minutes_tens(minutes_tens),
.hours_units(hours_units), .hours_tens(hours_tens), .anode_active(anode_active), .segments(segments), .state(state), 
.minutes_units_A(minutes_units_A), .minutes_tens_A(minutes_tens_A),
.hours_units_A(hours_units_A), .hours_tens_A(hours_tens_A)) ;
 
 
// Next state generation (combinational logic)

always @ (BTN_Det or state)
case (state)

A:begin // clock state
    if (BTN_Det == 5'b00001) nextState = C; // BTNC 
    else if (minutes_units == minutes_units_A && minutes_tens == minutes_tens_A 
    && hours_units == hours_units_A && hours_tens == hours_tens_A && seconds == 0 ) nextState = B; // Alarm 
    else begin
         nextState = A;
         LED = 5'b00000;
         inputclock = clk_1;
         en_sec = 1'b1;
         updown = 1'b1;
         enAdjAlarmHours = 1'b0;
         enAdjAlarmMin = 1'b0;
     end
end

B:  begin // Alarm
        if (BTN_Det == 5'b00001)
            begin nextState = A;// BTNC
            end
        else if(BTN_Det == 5'b00010)
            begin nextState = A;// BTNC
            end
        else if(BTN_Det == 5'b00100)
            begin nextState = A;// BTNC
            end
        else if(BTN_Det == 5'b01000)
            begin nextState = A;// BTNC
            end
        else if(BTN_Det == 5'b10000)
            begin nextState = A;// BTNC
            end
        else begin 
            LED[0] = clk_1;
            LED[4:1] = 4'b0000;
            inputclock = clk_1;
            en_sec = 1'b1;
            updown = 1'b1;
            enAdjAlarmHours = 1'b0;
            enAdjAlarmMin = 1'b0;
            nextState = B;  
        end
    end

C:  begin // Adjust clock hours 

        if(BTN_Det == 5'b00001)
            begin nextState = A;// BTNC
            end
        else if(BTN_Det == 5'b00100) nextState = F; // BTNL
        else if (BTN_Det == 5'b00010) nextState = D; // BTNR

        else if (BTN_Det == 5'b01000) begin // BTNU
            inputclock = clk_200;
            updown = 1'b1;
            enAdjTimeHours = 1'b1;
        end
        else if (BTN_Det == 5'b10000) begin // BTND
            inputclock = clk_200;
            updown = 1'b0;
            enAdjTimeHours = 1'b1;
        end
        else begin// else
            en_sec = 1'b0;
            updown = 1'b1;
            enAdjTimeHours = 1'b0;
            enAdjAlarmHours = 1'b0;
            enAdjAlarmMin = 1'b0;
            inputclock = clk_200;
            LED = 5'b10001;
            nextState = C;
        end
    end 

D:  begin 

        if(BTN_Det == 5'b00001)
            begin nextState = A;// BTNC
            end
        else if(BTN_Det == 5'b00100) nextState = C; // BTNL
        else if (BTN_Det == 5'b00010) nextState = E; // BTNR

        else if (BTN_Det == 5'b01000) begin // BTNU
            inputclock = clk_200;
            updown = 1'b1;
            enAdjTimeMin = 1'b1;
        end
        else if (BTN_Det == 5'b10000) begin // BTND
            inputclock = clk_200;
            updown = 1'b0;
            enAdjTimeMin = 1'b1;
        end
        else begin// else
            en_sec = 1'b0;
            updown = 1'b1;
            enAdjTimeMin = 1'b0;
            enAdjAlarmHours = 1'b0;
            enAdjAlarmMin = 1'b0;
            inputclock = clk_200;
            LED = 5'b01001;
            nextState = D;
        end
    end 
    
E:  begin

        if(BTN_Det == 5'b00001) 
            begin nextState = A;// BTNC
            end
        else if(BTN_Det == 5'b00100) nextState = D; // BTNL
        else if (BTN_Det == 5'b00010) nextState = F; // BTNR

        else if (BTN_Det == 5'b01000) begin // BTNU
            inputclock = clk_200;
            updown = 1'b1;
            enAdjAlarmHours = 1'b1;
        end
        else if (BTN_Det == 5'b10000) begin // BTND
            inputclock = clk_200;
            updown = 1'b0;
            enAdjAlarmHours = 1'b1;
        end
        else begin// else
            en_sec = 1'b0;
            updown = 1'b1;
            enAdjAlarmHours = 1'b0;
            enAdjAlarmMin = 1'b0;
            inputclock = clk_200;
            LED = 5'b00101;
            nextState = E;
        end
    end 
    
    
F:  begin 

        if(BTN_Det == 5'b00001) 
            begin nextState = A;// BTNC
            end                    
        else if(BTN_Det == 5'b00100) nextState = E; // BTNL
        else if (BTN_Det == 5'b00010) nextState = C; // BTNR

        else if (BTN_Det == 5'b01000) begin // BTNU
            inputclock = clk_200;
            updown = 1'b1;
            enAdjAlarmMin = 1'b1;
        end
        else if (BTN_Det == 5'b10000) begin // BTND
            inputclock = clk_200;
            updown = 1'b0;
            enAdjAlarmMin = 1'b1;
        end
        else begin// else
            en_sec = 1'b0;
            updown = 1'b1;
            enAdjAlarmMin = 1'b0;
            enAdjAlarmHours = 1'b0;
            inputclock = clk_200;
            LED = 5'b00011;
            nextState = F;
        end
    end 


   default: nextState = A;
   
endcase


// State register
// Update state FF's with the triggering edge of the clock

// output generation (combinational logic)
// State Changer on clock edge
always @ (posedge clk_200, posedge rst) begin  
    if(rst)begin
        state <= A;
    end
    else
        state <= nextState;
end

endmodule
