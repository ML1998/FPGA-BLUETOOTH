`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 18:13:21
// Design Name: 
// Module Name: dec_cnt
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


module dec_cnt(
    input cnt_en,                   //计数使能
    input clock,
    input reset,
    output reg [15:0] num
    );

always@(posedge clock or posedge reset)         //高位不为9情况下，低位逢9清零，高位逢9进位。
begin
    if(reset)
        num <= 0;
              
    else if(cnt_en) begin
        if(num[15:12] == 4'b1001 && num[11:8] == 4'b1001 && num[7:4] == 4'b1001 && num[3:0] == 4'b1001)
            num <= 0;
        else if (num[11:8] == 4'b1001 && num[7:4] == 4'b1001 && num[3:0] == 4'b1001)
            begin
                num[15:12] <= num[15:12] + 4'b0001;
                num[11:8]  <= 0;
                num[7:4]   <= 0;
                num[3:0]   <= 0;
            end
        else if (num[7:4] == 4'b1001 && num[3:0] == 4'b1001)
            begin
                num[11:8]  <= num[11:8] + 4'b0001;
                num[7:4]   <= 0;
                num[3:0]   <= 0;
            end 
        else if (num[3:0] == 4'b1001)
            begin
                num[7:4]   <= num[7:4] + 4'b0001;
                num[3:0]   <= 0;                      
            end
        else
                num[3:0]   <= num[3:0] + 4'b0001;
    end
        
    else 
         num <= num;
end
endmodule
