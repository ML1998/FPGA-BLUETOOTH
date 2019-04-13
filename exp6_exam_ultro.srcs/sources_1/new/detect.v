`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 18:13:21
// Design Name: 
// Module Name: detect
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
//leimingyu+2016K8009909011
//9011_mingyu
//ASCII: 39 30 31 31 6D 69 6E 67 79 75 

module detect(
    input clock,
    input reset,
    input rx_status,
    input [7:0] rx_data,
    output reg counter_en,
    output [15:0] counter_num,
    output reg [4:0] current_state
    );
    
localparam   [4:0]  S0 = 5'd0,
                    S1 = 5'd1,
                    S2 = 5'd2,
                    S3 = 5'd3,
                    S4 = 5'd4,
                    S5 = 5'd5,
                    S6 = 5'd6,
                    S7 = 5'd7,
                    S8 = 5'd8,
                    S9 = 5'd9,
                   S10 = 5'd10;    

reg poscatch1 = 0;
reg poscatch2 = 0;
always@(posedge clock or posedge reset)                     // rx_status posedge_catch
begin
    if(reset) begin
        poscatch1 <= 1'b0;
        poscatch2 <= 1'b0;
    end
    else      begin
        poscatch1 <= rx_status;
        poscatch2 <= poscatch1;
    end
end    
wire pos; 
assign pos = (~poscatch1) && rx_status ;   

//reg [4:0] current_state = S0;
reg [4:0] next_state;                
always@(posedge clock or posedge reset)
begin
    if(reset)
        current_state <= S0;
    else
        current_state <= next_state;
end

always@ (*)
begin
if(pos)
begin                                     //状态机判断条件改变，在pos使能即rx_status上升沿时，改变状态
    case(current_state)
        S0:begin
                    if(rx_data == 8'h39)     next_state = S1;
                    else                     next_state = S0;

           end     
        S1:begin 
                    if(rx_data == 8'h30)        next_state = S2;
                    else if(rx_data == 8'h39)   next_state = S1;
                    else                        next_state = S0;              
            end
        S2:begin
          
                    if(rx_data == 8'h31)        next_state = S3;
                    else if(rx_data == 8'h39)   next_state = S1;
                    else                        next_state = S0;
           end                   
        S3:begin 
                    if(rx_data == 8'h31)        next_state = S4;
                    else if(rx_data == 8'h39)   next_state = S1;
                    else                        next_state = S0;  
           end
        S4:begin
                    if(rx_data == 8'h6D)        next_state = S5;
                    else if(rx_data == 8'h39)   next_state = S1;
                    else                        next_state = S0;
           end
        S5:begin
                    if(rx_data == 8'h69)        next_state = S6;
                    else if(rx_data == 8'h39)   next_state = S1;
                    else                        next_state = S0;
           end
        S6:begin 
                    if(rx_data == 8'h6E)        next_state = S7;
                    else if(rx_data == 8'h39)   next_state = S1;
                    else                        next_state = S0;
           end
        S7:begin
                    if(rx_data == 8'h67)        next_state = S8;
                    else if(rx_data == 8'h39)   next_state = S1;
                    else                        next_state = S0;
            end
        S8:begin
                    if(rx_data == 8'h79)        next_state = S9;
                    else if(rx_data == 8'h39)   next_state = S1;
                    else                        next_state = S0;
           end
        S9:begin
                    if(rx_data == 8'h75)        next_state = S10;
                    else if(rx_data == 8'h39)   next_state = S1;
                    else                        next_state = S0;
            end
        S10: begin 
                    if(rx_data == 8'h39)    next_state = S1;
                    else                    next_state = S0;
            end   
         default:
               next_state = S0;   
  endcase
end
else
    next_state = current_state;
end

reg cnt_en;
always@(posedge clock)
begin
    if(next_state == S10 && poscatch2)
        cnt_en <= 1'b1;
    else 
        cnt_en <= 1'b0;
end

always@(posedge clock or posedge reset)  //使得counter_en 与 counter_num同步改变
begin
    if(reset)
        counter_en <= 1'b0;
    else
        counter_en <= cnt_en;
end

dec_cnt inst_dec_cnt(
    .clock(clock),
    .reset(reset),
    .cnt_en(cnt_en),
    .num(counter_num)
); 
endmodule