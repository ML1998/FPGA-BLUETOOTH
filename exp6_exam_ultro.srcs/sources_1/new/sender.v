`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mingyu Lei
// 
// Create Date: 2018/11/27 21:58:16
// Design Name: 
// Module Name: sender
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


module sender(
    input baudclk,
    input rst,
    input en,
    input [7:0] data,
    output reg status,       //高电平表示空闲
    output reg txd
    );

reg poscatch1;
reg poscatch2;

always@(posedge baudclk or posedge rst)
begin
    if(rst)
    begin
         poscatch1 <= 1'b0;
         poscatch2 <= 1'b0;
    end
    else
    begin
        poscatch1 <= en;
        poscatch2 <= poscatch1;
    end
end
        
reg cnt_en;
reg [7:0] cnt;
always@(posedge baudclk or posedge rst)
begin
    if(rst)
        cnt_en <= 1'b0;
    else if((~poscatch2)&& poscatch1) //出现上升沿
        cnt_en <= 1'b1;
    else if(cnt == 8'd160)
        cnt_en <= 1'b0;
    else 
        cnt_en <= cnt_en;
end


always@(posedge baudclk or posedge rst)
begin
    if(rst)
        status <= 1'b1;
    else if((~poscatch2)&& poscatch1) //出现上升沿
        status <= 1'b0;
    else if(cnt == 8'd160)
        status <= 1'b1;
    else 
        status <= status;
end


always@(posedge baudclk or posedge rst)
begin
    if(rst)
        cnt <= 8'd0;
    else if(cnt_en)
        cnt <= cnt + 8'b1;
    else
        cnt <= 8'd0;   
end

always@(posedge baudclk or posedge rst)
begin
    if(rst)
        txd <= 1'b1;
    else if(cnt_en)
        case(cnt)
            8'd0:   txd <= 1'b0;
            8'd16:  txd <= data[0];       
            8'd32:  txd <= data[1];      
            8'd48:  txd <= data[2];       
            8'd64:  txd <= data[3];    
            8'd80:  txd <= data[4]; 
            8'd96:  txd <= data[5]; 
            8'd112: txd <= data[6];     
            8'd128: txd <= data[7]; 
            8'd144: txd <= 1'b1;         
           default: txd <= txd;
       endcase
    else
        txd <= 1'b1;
end 

    
endmodule
