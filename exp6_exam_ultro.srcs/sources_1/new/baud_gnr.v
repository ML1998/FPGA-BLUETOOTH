`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/23 22:44:48
// Design Name: 
// Module Name: baud_gnr
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
module baud_gnr(
    input sysclk,
    input rst,
    output reg baudclk = 0  // 9600 * 16 = 153600Hz  
    );
    
reg [9:0] cnt = 0;             //100,000,000/153600 = 651   2^10 = 1024
always@(posedge sysclk or posedge rst)
begin
    if(rst)
    begin
        cnt <= 10'b0;
        baudclk <= 0;
    end
    else 
        begin
        if(cnt > 10'd650)
            begin
                cnt <= 10'b0;
                baudclk <= 1;
            end
        else
            begin
                cnt <= cnt + 10'b1;
                baudclk <= 0;
            end
        end
end

//always@(posedge sysclk)
//begin
//    if(cnt > 10'd650)
//        baudclk <= ~baudclk;       
//    else
//        baudclk <= baudclk;       
//end
    
endmodule
